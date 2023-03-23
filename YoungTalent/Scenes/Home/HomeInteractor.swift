//
//  HomeInteractor.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchData()
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
        worker.fetchGroups { result in
            switch result {
            case let .success(allGroupsResponse):
                self.groupsData = allGroupsResponse.body.groups
                guard let groupsData = self.groupsData else { return }
                self.presenter?.presentGroups(groupsModel: groupsData)
            case let .failure(error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }

        worker.fetchCurrentUser { result in
            switch result {
            case let .success(userResponse):
                self.presenter?.presentCurrentUser(userModel: userResponse.body)
            case let .failure(error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }
        worker.fetchAllUsers { result in
            switch result {
            case let .success(allUsers):
                self.contacts = allUsers.body
                guard let contacts = self.contacts else { return }
                self.presenter?.presentAllContacts(contactsModel: contacts)
            case let .failure(error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }
    }
}
