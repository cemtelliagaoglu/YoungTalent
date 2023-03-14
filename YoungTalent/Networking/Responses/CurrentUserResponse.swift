//
//  CurrentUserResponse.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

public struct CurrentUserResponse: Codable{
    
    public let body: User
    
    public struct User: Codable{
        let nameSurname: String
        let profilePhoto: String?
        let title: String
        let phoneNumber: String?
        let email: String
    }
}
