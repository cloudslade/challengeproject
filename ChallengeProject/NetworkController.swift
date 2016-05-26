//
//  NetworkController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation

class NetworkController {
    func dataTask(url: NSURL, completion: (data: NSData?) -> ()) {
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, respone, error) in
            if error != nil {
                completion(data: data)
            }
        }
        dataTask.resume()
    }
    
}