//
//  UserDetailViewController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    private let margin: CGFloat = 10.0
    
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
        addTextToLabels(user)
    }
    
    // Successful constraints must fully define both the size and location of the view (or NSLayoutGuide).
    // To set your own constraints you must set translatesAutoresizingIntoConstraints to false.
    
    func setupConstraints() {
        // add all subviews here
        addSubViews()
        disableTranslatesAutoresizingMaskIntoConstraints()
        
        // Create an array of labels excluding the label which will be on top (usernameLabel)
        let labelArray = [nameLabel, emailLabel, phoneLabel, websiteLabel, companyLabel, addressLabel, idLabel]
        
        // username size constraints
        var constraint: NSLayoutConstraint
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 20)
        view.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: view.frame.size.width)
        view.addConstraint(constraint)
        
        // username Location Constraints
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: margin)
        view.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: (self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.height + margin)
        view.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: usernameLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: margin)
        view.addConstraint(constraint)
        
        //        // name Location Constraints
        //        constraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: margin)
        //        view.addConstraint(constraint)
        //        constraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: usernameLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: margin)
        //        view.addConstraint(constraint)
        //        constraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: margin)
        //        view.addConstraint(constraint)
        //
        //        // name size constraints
        //        constraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 20)
        //        view.addConstraint(constraint)
        //        constraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: view.frame.size.width)
        //        view.addConstraint(constraint)
        
        self.addGenereicConstraintsToLabels(labelArray)
    }
    
    func addGenereicConstraintsToLabels(labels: [UILabel]) {
        var aboveLabel = self.usernameLabel
        var constraint: NSLayoutConstraint
        
        for label in labels {
            // size constraints
            constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 20)
            view.addConstraint(constraint)
            constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: view.frame.size.width)
            view.addConstraint(constraint)
            
            // location constraints
            // update Leading constraints
            constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: margin)
            view.addConstraint(constraint)
            // update trailing constraints
            constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: margin)
            view.addConstraint(constraint)
            // update top constraints
            constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: aboveLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: margin)
            view.addConstraint(constraint)
            
//            if label == labels.last {
//                constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//            }
            
            // updateAbove label
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
    
    func addTextToLabels(user: User) {
        if let user = self.user {
            self.usernameLabel.text = user.userName
            self.idLabel.text = String(user.id)
            self.nameLabel.text = user.name
            self.phoneLabel.text = user.phone
            self.emailLabel.text = user.email
            self.websiteLabel.text = user.website
            self.companyLabel.text = user.company["name"]
            self.addressLabel.text = user.address["street"] as? String
        }
    }
    
    func disableTranslatesAutoresizingMaskIntoConstraints() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


// Get just the top constraint positioned correctly then worry about the other constraints.
// Find what constraints are needed to make the label position properly. This may require some playing around with different constraitns before it will work.



