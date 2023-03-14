//
//  HomeModels.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Home {
    
    enum Case {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
            struct GroupModel{
                let name: String
                let groupPhoto: String?
                let users: [User]?
                let lastMessage: GroupLastMessage?
            }
            struct GroupLastMessage{
                let fromUsername: String
                let message: String
            }
            struct User{
                public let nameSurname: String
                public let profilePhoto: String?
                public let title: String?
            }
        }
        
        
    }
    
}
// swiftlint:enable nesting



