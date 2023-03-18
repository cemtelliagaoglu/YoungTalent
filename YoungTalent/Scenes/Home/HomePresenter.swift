//
//  HomePresenter.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

protocol HomePresentationLogic: AnyObject {
    func presentGroups(groupsModel: [AllGroupsResponse.Group])
    func presentCurrentUser(userModel: User)
    func presentAllContacts(contactsModel: [User])
    func presentErrorMessage(_ errorMessage: String)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func presentGroups(groupsModel: [AllGroupsResponse.Group]) {
        
        var groupsViewModels: [Home.Case.ViewModel.GroupModel] = []
        
        groupsModel.forEach { group in
            
            let users = group.users?.map({ user in

                return Home.Case.ViewModel.User(nameSurname: user.nameSurname,
                                                profilePhoto: user.profilePhoto,
                                                title: user.title)
            })
            
            let lastMessage = Home.Case.ViewModel.GroupLastMessage(
                fromUsername: group.lastMessage?.from.nameSurname ?? "No Messages Yet",
                message: group.lastMessage?.message ?? ""
            )
            
            groupsViewModels.append(Home.Case.ViewModel.GroupModel(name: group.name ,
                                                                  groupPhoto: group.groupPhoto,
                                                                  users: users,
                                                                  lastMessage: lastMessage))
        }
        self.viewController?.displayGroups(groupViewModels: groupsViewModels)
    }
    
    func presentCurrentUser(userModel: User) {
        let userViewModel = Home.Case.ViewModel.User(nameSurname: userModel.nameSurname,
                                                     profilePhoto: userModel.profilePhoto,
                                                     title: userModel.title)
        viewController?.setCurrentUser(userViewModel: userViewModel)
    }
    
    func presentAllContacts(contactsModel: [User]) {
        var usersViewModel = [Home.Case.ViewModel.User]()
        
        contactsModel.forEach { contact in
            let userViewModel = Home.Case.ViewModel.User(
                nameSurname: contact.nameSurname,
                profilePhoto: contact.profilePhoto,
                title: contact.title)
            usersViewModel.append(userViewModel)
        }
        viewController?.displayUsers(userViewModels: usersViewModel)
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage)
    }
        
}


