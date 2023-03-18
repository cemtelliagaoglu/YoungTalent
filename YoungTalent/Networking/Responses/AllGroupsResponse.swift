//
//  AllGroupsResponse.swift
//  YoungTalent
//
//  Created by admin on 10.03.2023.
//

public struct AllGroupsResponse: Codable{
    
    public let reason: String
    public let error: Bool
    public let body: AllGroupsBody

    public struct AllGroupsBody: Codable{
        public let groups: [Group]
    }

    public struct Group: Codable {
        public let id: String
        public let name: String
        public let createdAt: String
        public let deletedAt: String?
        public let groupPhoto: String?
        public let users: [User]?
        var lastMessage: Message?

    }

    public struct Message: Codable{
        public let from: User
        public let message: String
        public let to: To
    }
    
    public struct To: Codable{
        public let id: String
        public let name: String
        public let createdAt: String
        public let deletedAt: String?
        public let groupPhoto: String?
    }
    
    public struct User: Codable{
        public let id: String
        public let email: String
        public let nameSurname: String
        public let profilePhoto: String?
        public let title: String
    }
}


