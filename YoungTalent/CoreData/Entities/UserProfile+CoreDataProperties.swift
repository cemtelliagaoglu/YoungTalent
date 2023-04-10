//
//  UserProfile+CoreDataProperties.swift
//  YoungTalent
//
//  Created by admin on 28.03.2023.
//
//

import CoreData
import Foundation

public extension UserProfile {
    @nonobjc class func fetchRequest() -> NSFetchRequest<UserProfile> {
        NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged var gender: String?
    @NSManaged var dateOfBirth: Date?
}

extension UserProfile: Identifiable {}
