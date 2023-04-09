//
//  HomeInteractor.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchData()
    func switchTheme()
    func requestLogout()
}

protocol HomeDataStore: AnyObject {
    var groupsData: [AllGroupsResponse.Group]? { get set }
    var contacts: [User]? { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var groupsData: [AllGroupsResponse.Group]?
    var contacts: [User]?

    func fetchData() {
        Task {
            do {
                let allGroupsResponse = try await worker.fetchGroups()
                let userResponse = try await worker.fetchCurrentUser()
                let allUsersResponse = try await worker.fetchAllUsers()
                self.groupsData = allGroupsResponse.body.groups
                self.contacts = allUsersResponse.body
                guard let groupsData,
                      let contacts
                else { return }
                presenter?.presentGroups(groupsModel: groupsData)
                presenter?.presentCurrentUser(userModel: userResponse.body)
                presenter?.presentAllContacts(contactsModel: contacts)
            } catch {
                guard let error = error as? RequestError else { return }
                presenter?.presentErrorMessage(error.customMessage)
            }
        }
    }

    func requestLogout() {
        worker.deleteRefreshToken { [weak self] in
            self?.presenter?.presentLogoutSuccess()
        }
    }

    func switchTheme() {
        worker.updateDarkMode { [weak self] isDarkMode in
            self?.presenter?.presentNewTheme(isDarkMode)
        }
    }
}
