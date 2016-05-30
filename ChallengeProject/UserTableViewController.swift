//
//  UserTableViewController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePullToRefresh()
        // if not using storyboard we must register our cell class programatically
        self.tableView.registerClass(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if hasUsers() {
            self.changeTableViewBackGroundtoGray()
        }
    }
    
    // MARK: - Table View Data Source Methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
        let user = UserController.sharedInstance.users[indexPath.row]
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.name
        cell.backgroundColor = UIColor.queGray()
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // if we have no users we must display our nill case which prompts the user to refresh their data
        // Otherwise we change our tableView style to have single seperator lines
        if hasUsers() {
            configureTableViewForNilCase()
        } else {
            configureTableViewForUsers()
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.sharedInstance.users.count
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destinationVC = UserDetailViewController()
        let user = UserController.sharedInstance.users[indexPath.row]
        destinationVC.user = user
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // MARK: - Helper Methods
    
    func hasUsers() -> Bool {
        if UserController.sharedInstance.users.count < 1 {
            return false
        }
        return true
    }
    
    func configureTableViewForNilCase() {
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
    }
    
    func configureTableViewForUsers() {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
    
    func configurePullToRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.grayColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.addTarget(self, action: #selector(checkForUsers), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func checkForUsers() {
        // clear coreData of the users it has in it's storage.
        UserController.sharedInstance.removeUsers()
        
        // make an asyncronous network call to fetch JSON containting user info.
        UserController.sharedInstance.loadUsers { (users) in
            
            // save the users locally to our Core Data Persistent Store
            UserController.sharedInstance.saveToPersistentStoregae()
            
            // stop the refresh controller from animating
            self.refreshControl?.endRefreshing()
            
            // reload our tableview to display our new data from network call
            self.tableView.reloadData()
            
            // now that tableView has some data we must replace our 'No Data availabl...' background message
            self.changeTableViewBackGroundtoGray()
        }
    }
    
    func changeTableViewBackGroundtoGray() {
        let tableViewBackground = UIView()
        tableViewBackground.backgroundColor = UIColor.queGray()
        self.tableView.backgroundView = tableViewBackground
    }
    
}







