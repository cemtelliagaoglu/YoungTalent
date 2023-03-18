//
//  UserResponse.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

public struct UserResponse: Codable{
    public let body: User
}
public struct AllUsersResponse: Codable{
    public let body: [User]
}
//MARK: - User
public struct User: Codable{
    let nameSurname: String
    let profilePhoto: String?
    let title: String
    let phoneNumber: String?
    let email: String
}
