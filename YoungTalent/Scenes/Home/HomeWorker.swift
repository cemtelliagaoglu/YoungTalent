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
    
    
    
    
    
    
}

//extension HomeWorker: HTTPClient{
//
//    func fetchData(completion: @escaping ((Result<[Home.Case.ViewModel.GroupModel]?, RequestError>) -> ())) {
//        sendRequest(endpoint: GroupsEndpoint.all, responseModel: AllGroupsResponse.self) { result in
//
//            var groups: [Home.Case.ViewModel.GroupModel] = []
//
//            switch result{
//            case .success(let allGroups):
//                allGroups.body.groups.forEach { group in
//
//                    let users = group.users?.map({ user in
//                        return Home.Case.ViewModel.User(nameSurname: user.nameSurname,
//                                                        profilePhoto: user.profilePhoto,
//                                                        title: user.title)
//                    })
//
//                    let lastMessage = Home.Case.ViewModel.GroupLastMessage(
//                        fromUsername: group.lastMessage?.from.nameSurname ?? "No Message Yet",
//                        message: group.lastMessage?.message ?? ""
//                    )
//
//                    groups.append(Home.Case.ViewModel.GroupModel(name: group.name ,
//                                                                 groupPhoto: group.groupPhoto,
//                                                                 users: users,
//                                                                 lastMessage: lastMessage))
//                }
//                completion(.success(groups))
//
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
