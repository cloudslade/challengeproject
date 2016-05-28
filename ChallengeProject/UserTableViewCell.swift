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
        
    }
    
}







