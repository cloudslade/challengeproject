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
        // clear coreData of the users it has in it's storage.
        UserController.sharedInstance.removeUsers()
        UserController.sharedInstance.loadUsers { (users) in
            // reload the tableview
            UserController.sharedInstance.saveToPersistentStoregae()
            self.tableView.reloadData()
            // stop the refreshcontroller from animating
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
        let user = UserController.sharedInstance.users[indexPath.row]
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.name
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
            let downArrowImage = UIImageView(image: UIImage(named: "downarrow"))
            self.tableView.backgroundView = downArrowImage
            self.tableView.backgroundView = nilCaseLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 1
        } else {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.sharedInstance.users.count
    }
    
    func configurePullToRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.grayColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.addTarget(self, action: #selector(checkForUsers), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationVC = UserDetailViewController()
        let user = UserController.sharedInstance.users[indexPath.row]
        destinationVC.user = user
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}







