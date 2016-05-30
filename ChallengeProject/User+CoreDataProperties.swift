//
//  User+CoreDataProperties.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/29/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var formattedAddress: String
    @NSManaged var companyName: String
    @NSManaged var email: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var userName: String
    @NSManaged var website: String
    @NSManaged var catchPhrase: String
    @NSManaged var street: String
    @NSManaged var bs: String
    @NSManaged var suite: String
    @NSManaged var city: String
    @NSManaged var zipcode: String
    @NSManaged var lat: NSNumber
    @NSManaged var lng: NSNumber

}
