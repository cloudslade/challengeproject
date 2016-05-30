//
//  PhotoController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/27/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class PhotoController {
    
    // MARK: - Photos Over Network
    
    // Performs a network call to retrieve a photo for a specific user. The photo received correlates to the index of the user in the UserController singleton. i.g. UserController.sharedInstance.users[3] = photo 4.
    static func loadPhotoForId(id: Int, completion: (image: UIImage?) -> ()) {
        let url = destinationURL("http://jsonplaceholder.typicode.com/photos")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        NetworkController.performRequestForURL(url) { (data) in
            guard let data = data else {
                print("Network Request Failed")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(image: nil)
                return
            }
            
            // attempt to serialize JSON. If successful take the thumbnailUrl value in the dic and use it to create a URL for our final network call.
            do {
                if let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    let element = jsonArray[id]
                    // make another network request to the url contained in the dic
                    if let urlString = element["thumbnailUrl"] as? String {
                        let url = self.destinationURL(urlString)
                        PhotoController.performNetworkRequestForSpecificPhoto(url, completion: { (image) in
                            completion(image: image)
                        })
                    }
                }
            } catch {
                print("Could Not Serialize Photos")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(image: nil)
                return
            }
        }
    }
    
    // This will perform a network request of a specific photo URL from one of the photo dictionaries, i.g. http://placehold.it/150/412ffd. It will initialize a photo from the data it receives and complete with it.
    static func performNetworkRequestForSpecificPhoto(url: NSURL, completion: (image: UIImage?) -> ()) {
        NetworkController.performRequestForURL(url, completion: { (data) in
            // turn data into image and return it
            guard let data = data else {
                print("Failed to retrieve NSData for photo")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completion(image: nil)
                return
            }
            let image = UIImage(data: data)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            completion(image: image)
        })
    }
    
    // MARK: - Helped Methods
    
    static func destinationURL(urlString: String) -> NSURL {
        return NSURL(string: urlString)!
    }
}

// then add an image View to the detail controller