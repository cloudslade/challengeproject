//
//  UserTableViewController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
        UserController.sharedInstance.loadUsers { (users) in
            UserController.sharedInstance.saveToPersistentStoregae()
            self.tableView.reloadData()
        }
    }
    
    // The user will pull down on the tableView
    // The loadUserFunction will be called.
    // With those users the
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
//        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "userCell") as! UserTableViewCell
        let user = UserController.sharedInstance.users[indexPath.row]
        cell.updateWithUser(user)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.sharedInstance.users.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
    }
    
}
