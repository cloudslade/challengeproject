//
//  User.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation
import CoreData

private let kID = "id"
private let kName = "name"
private let kEmail = "email"
private let kAddress = "address"
private let kPhone = "phone"
private let kWebsite = "website"
private let kCompany = "company"

class User: NSManagedObject {
    
    convenience init?(json: [String: AnyObject], context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: context)!
        guard let id = json[kID] as? NSNumber,
        let name = json[kName] as? String,
        let email = json[kEmail] as? String,
        let address = json[kAddress] as? [String: AnyObject],
        let phone = json[kPhone] as? String,
        let website = json[kWebsite] as? String,
        let company = json[kCompany] as? [String: String] else {
            print("Could not initialize User")
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            return nil
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }

}

