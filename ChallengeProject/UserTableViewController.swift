//
//  UserTableViewController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    private var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePullToRefresh()
        self.tableView.registerClass(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        if let indexPath = indexPath  {
            self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        }
    }
    
    func checkForUsers() {
        // In here we will load the users
        // clear coreData of the users it has in it's storage.
        UserController.sharedInstance.removeUsers()
        UserController.sharedInstance.loadUsers { (users) in
            // reload the tableview
            UserController.sharedInstance.saveToPersistentStoregae()
            self.tableView.reloadData()
            // stop the refrechcontroller from loasing
            
            self.refreshControl?.endRefreshing()
            // ...miss anything?
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
        let user = UserController.sharedInstance.users[indexPath.row]
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.name
        cell.delegate = self
        if self.indexPath == nil {
            self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
            self.indexPath = indexPath
        }
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
    
    func configurePullToRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.grayColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        self.refreshControl?.addTarget(self, action: #selector(checkForUsers), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func cellTapped() {
        // find the highlighted cell
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.indexPath = indexPath
            let destinationVC = UserDetailViewController()
            let user = UserController.sharedInstance.users[indexPath.row]
            destinationVC.user = user
            self.navigationController?.pushViewController(destinationVC, animated: true)
            // place it on the navController
            // perform segue
        }
    }
    
}







