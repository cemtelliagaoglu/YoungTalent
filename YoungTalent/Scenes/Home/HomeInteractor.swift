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
    var groupsData:[AllGroupsResponse.Group]?{ get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
        
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    var groupsData: [AllGroupsResponse.Group]?
    
    func fetchData() {
        
        worker.fetchGroups { result in
            switch result{
            case .success(let allGroupsResponse):
                self.groupsData = allGroupsResponse.body.groups
                guard let groupsData = self.groupsData else{ return }
                self.presenter?.presentGroups(groupsModel: groupsData)
            case .failure(let error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }
        
        worker.fetchCurrentUser { result in
            switch result{
            case .success(let userResponse):
                self.presenter?.presentCurrentUser(userModel: userResponse.body)
            case .failure(let error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }
    }
    
}

