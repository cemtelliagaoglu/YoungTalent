//
//  HomeWorker.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchCurrentUser(completion: @escaping ((Result<UserResponse, RequestError>) -> ()))
    func fetchGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> ()))
    func fetchAllUsers(completion: @escaping ((Result<AllUsersResponse, RequestError>) -> ()))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func fetchCurrentUser(completion: @escaping ((Result<UserResponse, RequestError>) -> ())) {
        sendRequest(endpoint: UserEndpoint.currentUser, responseModel: UserResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> ())) {
        sendRequest(endpoint: GroupsEndpoint.all, responseModel: AllGroupsResponse.self) { result in
            completion(result)
        }
    }
    func fetchAllUsers(completion: @escaping ((Result<AllUsersResponse, RequestError>) -> ())) {
        sendRequest(endpoint: UserEndpoint.allUsers, responseModel: AllUsersResponse.self) { result in
            completion(result)
        }
    }
}
