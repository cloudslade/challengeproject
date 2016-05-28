//
//  User+CoreDataProperties.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/27/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var email: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var address: [String: AnyObject]
    @NSManaged var phone: String
    @NSManaged var company: [String: String]
    @NSManaged var website: String
    @NSManaged var userName: String

}
