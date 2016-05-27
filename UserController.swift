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
    
    func loadUsers(completion: (users: [User]) -> ()) {
        // Retrieve url
        
        let url = destinationURL("http://jsonplaceholder.typicode.com/users")
        
        //        Make a network call.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        NetworkController.performRequestForURL(url) { (data) in
            guard let data = data else {
                print("data returned as nil")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(users: [])
                return
            }
            
            do {
                let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]]
                var users: [User] = []
                for userDictionary in jsonArray! {
                    let user = User(json: userDictionary)
                    users.append(user!)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(users: users)
            } catch {
                print("could not serialize successfully")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(users: [])
            }
            
            
        }
        //        Inside the comletion check for data
        
        // Do another check that we can serialzes the JSON as our dictionaries.
        
        // Create User objects out of our json
        
        // complete with our object
    }
    
    func destinationURL(urlString: String) -> NSURL {
        return NSURL(string: urlString)!
    }
    
    func saveToPersistentStoregae() {
        
    }
    
}