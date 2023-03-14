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
//    var messagesData { get set }
//    var groupsData{ get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
        
    var presenter: HomePresentationLogic?
    var worker: HomeWorkingLogic = HomeWorker()
    
    func fetchData() {
        
        worker.fetchGroups { result in
            switch result{
            case .success(let allGroupsResponse):
                self.presenter?.presentGroups(groupsModel: allGroupsResponse.body.groups)
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

