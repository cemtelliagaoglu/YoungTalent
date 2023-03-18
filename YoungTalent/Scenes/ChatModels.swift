//
//  ChatModels.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Chat {
    
    enum Case {
        
        struct Request {
            
        }
        
        struct Response {
            let user: User
        }
        
        struct ViewModel {
            struct User{
                let nameSurname: String
                let profilePhoto: String?
                let title: String
                
                var fullName: String?{
                    return "\(nameSurname) (\(title))"
                }
            }
        }
        
    }
    
}
// swiftlint:enable nesting
