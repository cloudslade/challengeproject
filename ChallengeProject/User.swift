//
//  User.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/29/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation
import CoreData

// keys for dictionary values of a user as defined by our endpoint, http://jsonplaceholder.typicode.com/users
private let kCompanyName = "name"
private let kCatchPhrase = "catchPhrase"
private let kStreet = "street"
private let kSuite = "suite"
private let kCity = "city"
private let kZipcode = "zipcode"
private let kLat = "lat"
private let kLng = "lng"
private let kID = "id"
private let kName = "name"
private let kUserName = "username"
private let kEmail = "email"
private let kPhone = "phone"
private let kWebsite = "website"
private let kCompany = "company"
private let kAddress = "address"
private let kGeo = "geo"
private let kBs = "bs"

class User: NSManagedObject {
    
    // failable initializer designed to handle JSON format from endpoint at http://jsonplaceholder.typicode.com/users.
    convenience init?(json: [String: AnyObject], context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: context)!
        
        // all values required to make a user must successfully parse from our json dictionary else the initializer will fail 
        guard let id = json[kID] as? NSNumber,
        let name = json[kName] as? String,
        let userName = json[kUserName] as? String,
        let email = json[kEmail] as? String,
        let phone = json[kPhone] as? String,
        let website = json[kWebsite] as? String,
        let address = json[kAddress] as? [String: AnyObject],
        let company = json[kCompany] as? [String: String],
        let geo = address[kGeo] as? [String: String],
        let street = address[kStreet] as? String,
        let suite = address[kSuite] as? String,
        let city = address[kCity] as? String,
        let zipcode = address[kZipcode] as? String,
        let lat = geo[kLat],
        let lng = geo[kLng],
        let companyName = company[kCompanyName],
        let catchPhrase = company[kCatchPhrase],
        let bs = company[kBs] else {
            print("Could not initialize User")
            self.init(entity: entity, insertIntoManagedObjectContext: context)
            return nil
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        self.phone = phone
        self.website = website
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.lat = Double(lat)!
        self.lng = Double(lng)!
        self.companyName = companyName
        self.catchPhrase = catchPhrase
        self.bs = bs
        self.formattedAddress = "\(street), \(suite), \(city), \(zipcode)"
    }
    
}





