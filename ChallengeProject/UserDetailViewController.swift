//
//  UserDetailViewController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var user: User?
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let addressLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    let companyLabel = UILabel()
    let websiteLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            updateWithUser(user)
        }
    }
    
    override func loadView() {
        super.loadView()
        setupConstraints()
    }
    
    func updateWithUser(user: User) {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.textAlignment = NSTextAlignment.Right
        idLabel.textColor = UIColor.blackColor()
        idLabel.backgroundColor = UIColor.whiteColor()
        self.idLabel.text = String(user.id)
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.userName
        self.emailLabel.text = user.email
        self.phoneLabel.text = user.phone
        self.websiteLabel.text = user.website
    }
    
    func setupConstraints() {
        // add all subviews here
        addSubViews()
        addTextToLabels()
        // Create an array of labels excluding the label which will be on top (usernameLabel)
        let labelArray = [nameLabel, emailLabel, phoneLabel, websiteLabel, companyLabel, addressLabel]
        
        var constraint: NSLayoutConstraint
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.height)
        view.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        self.addGenereicConstraintsToLabels(labelArray)
    }
    
    func addGenereicConstraintsToLabels(labels: [UILabel]) {
        let cellMargin: CGFloat = 15.0
        var aboveLabel = self.usernameLabel
        
        // update Leading constraints
        for label in labels {
            let constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
            view.addConstraint(constraint)
        }
        
        // update trailing constraints
        for label in labels {
            // constraints to aboveLabel
            let constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
            view.addConstraint(constraint)
        }
        
        // update top constraints
        for label in labels {
            // constraints to aboveLabel
            let constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: aboveLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: cellMargin)
            view.addConstraint(constraint)
            //updateAbove label
            aboveLabel = label
        }
    }
    
    func addSubViews() {
        self.view.addSubview(usernameLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(websiteLabel)
        self.view.addSubview(companyLabel)
        self.view.addSubview(addressLabel)
    }
    
    func addTextToLabels() {
        if let user = self.user {
            self.usernameLabel.text = user.userName
            self.idLabel.text = String(user.id)
            self.nameLabel.text = user.name
            self.phoneLabel.text = user.phone
            self.emailLabel.text = user.email
            self.companyLabel.text = user.company["name"]
            self.addressLabel.text = user.address["street"] as? String
        }
    }
    
    
}






