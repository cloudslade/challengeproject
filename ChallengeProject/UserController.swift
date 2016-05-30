//
//  UserController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit
import CoreData

class UserController {
    static let sharedInstance = UserController()
    var users: [User] {
        let moc = Stack.sharedStack.managedObjectContext
        let request = NSFetchRequest(entityName: "User")
        do {
            return try moc.executeFetchRequest(request) as! [User]
        } catch {
            return []
        }
    }
    
    // MARK: - CRUD Methods
    
    func loadUsers(completion: (users: [User]) -> ()) {
        // create a url from string and make a network call to retrieve our users from JSON data
        let url = destinationURL("http://jsonplaceholder.typicode.com/users")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        NetworkController.performRequestForURL(url) { (data) in
            
            // if we dont have data complete with an empty array of users
            guard let data = data else {
                print("data returned as nil")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(users: [])
                return
            }
            do {
                
                // if JSON serialization is successful loop through each element in our array of dictionaries and initialize a user for each element and complete with an array of all users.
                let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]]
                var users: [User] = []
                for userDictionary in jsonArray! {
                    let user = User(json: userDictionary)
                    users.append(user!)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(users: users)
                
                // if we cannot serialize JSON into users complete with empty array of users
            } catch {
                print("could not serialize successfully")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(users: [])
            }
        }
    }
    
    func removeUsers() {
        // removes all users from core Data Persistent Store
        let moc = Stack.sharedStack.managedObjectContext
        let request = NSFetchRequest(entityName: "User")
        do {
            let yo = try moc.executeFetchRequest(request) as! [User]
            for user in yo {
                moc.deleteObject(user)
                self.saveToPersistentStoregae()
            }
        } catch {
            print("could not make fetch request")
        }
    }
    
    func saveToPersistentStoregae() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("could not save")
        }
    }
    
    // MARK: - Helper Methods
    
    func destinationURL(urlString: String) -> NSURL {
        return NSURL(string: urlString)!
    }
    
}











