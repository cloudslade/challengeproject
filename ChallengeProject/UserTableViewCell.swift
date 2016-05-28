//
//  UserTableViewCell.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    let userNameLabel = UILabel()
    let nameLabel =  UILabel()
    let phoneLabel = UILabel()
    var delegate: UserTableViewController?
    
    override internal func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.delegate?.cellTapped()
    }
    
    func updateWithUser(user: User) {
        userNameLabel.text = user.userName
        nameLabel.text = user.name
        phoneLabel.text = user.phone
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        self.setNeedsUpdateConstraints()
        
        
        //        var constraint: NSLayoutConstraint
        //        constraint = NSLayoutConstraint(item: userNameLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        //        contentView.addConstraint(constraint)
        //        constraint = NSLayoutConstraint(item: userNameLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        //        contentView.addConstraint(constraint)
        
        //        let viewsDict = [
        //            "image" : imgUser,
        //            "username" : labUerName,
        //            "message" : labMessage,
        //            "labTime" : labTime,
        //            ]
        //
        //        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
        //        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
        //        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
        //        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
        //        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
    }
    
}







