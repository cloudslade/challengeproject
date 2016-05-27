//
//  UserTableViewCell.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    var nameLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: , height: 30))
    
    func updateWithUser(user: User) {
        nameLabel.text = user.name
        contentView.addSubview(nameLabel)
        
    }
    
}