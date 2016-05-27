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
        self.configurePullToRefresh()
        self.tableView.registerClass(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
    }
    func checkForUsers() {
        // In here we will load the users
        UserController.sharedInstance.loadUsers { (users) in
            // reload the tableview
            
            self.tableView.reloadData()
            // stop the refrechcontroller from loasing
            
            self.refreshControl?.endRefreshing()
            // ...miss anything?
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
//        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "userCell") as! UserTableViewCell
        let user = UserController.sharedInstance.users[indexPath.row]
        cell.updateWithUser(user)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if UserController.sharedInstance.users.count < 1 {
            let nilCaseLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
            nilCaseLabel.text = "No data is available. Please pull down to refresh."
            nilCaseLabel.textColor = .blackColor()
            nilCaseLabel.numberOfLines = 0
            nilCaseLabel.textAlignment = NSTextAlignment.Center
            nilCaseLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            self.tableView.backgroundView = nilCaseLabel
//            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 1
        } else {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.sharedInstance.users.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
    }
    
    func configurePullToRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.grayColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.addTarget(self, action: #selector(checkForUsers), forControlEvents: UIControlEvents.ValueChanged)
    }
    
}







