//
//  UserDetailViewController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/26/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let margin: CGFloat = 10.0
    private let imageWidth: CGFloat = 150.0
    private let imageHeight: CGFloat = 150.0
    
    // MARK: - Properties
    
    var user: User?
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let usernameLabel = UILabel()
    let formattedAddressLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    let companyNameLabel = UILabel()
    let websiteLabel = UILabel()
    let streetLabel = UILabel()
    let suiteLabel = UILabel()
    let cityLabel = UILabel()
    let zipcodeLabel = UILabel()
    let latLabel = UILabel()
    let lngLabel = UILabel()
    let catchPhraseLabel = UILabel()
    let bsLabel = UILabel()
    let imageView = UIImageView()
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.queGray()
        if let user = self.user {
            updateWithUser(user)
        }
    }
    
    override func loadView() {
        super.loadView()
        // we set constraints here because this is when the view is ready to have constraints added (the loadview event just happened)
        setupConstraints()
        configureImage()
        
        if let user = self.user {
            PhotoController.loadPhotoForId(Int(user.id), completion: { (image) in
                if let image = image {
                    self.imageView.image = image
                }
            })
        }
    }
    
    // MARK: - Configure Constraints
    
    func configureImage() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        var constraint: NSLayoutConstraint
        
        // Our image view will have a fixed size 0f 150 x 150 as per the size of images coming from our endpoint, http://jsonplaceholder.typicode.com/photos
        
        // location constraints
        constraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: margin)
        view.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: bsLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: margin)
        view.addConstraint(constraint)

        // size constraints
        constraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: imageHeight)
        view.addConstraint(constraint)
        // width constraint
        constraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: imageWidth)
        view.addConstraint(constraint)
    }
    
    func setupConstraints() {
        addSubViews()
        disableTranslatesAutoresizingMaskIntoConstraints()
        
        // create an array of labels excluding the label which will be on top (usernameLabel)
        // we need this array to pass into our setupConstraints function
        let labelArray = [nameLabel, emailLabel, phoneLabel, websiteLabel, companyNameLabel, formattedAddressLabel, idLabel, streetLabel, suiteLabel, cityLabel, zipcodeLabel, latLabel, lngLabel, catchPhraseLabel, bsLabel]
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
        self.addGenereicConstraintsToLabels(labelArray)
    }
    
    func addGenereicConstraintsToLabels(labels: [UILabel]) {
        // Adds a series of generic constraints to an aray of labels.
        var aboveLabel = self.usernameLabel
        var constraint: NSLayoutConstraint
        // loop through each label in the array and set the following constraints to it.
        for label in labels {
            // size constraints
            // height constraint
            constraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 20)
            view.addConstraint(constraint)
            // width constraint
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
            
            // The constraints reference the label above the current constraint. Once the constraitns for a label are finished the loop moves on the the label that will be below it.
            aboveLabel = label
        }
    }
    
    // MARK: - Helper Methods
    
    func updateWithUser(user: User) {
        addTextToLabels(user)
    }
    
    // MARK: - Label Configuration
    
    func addSubViews() {
        // add subviews to main view
        self.view.addSubview(streetLabel)
        self.view.addSubview(suiteLabel)
        self.view.addSubview(cityLabel)
        self.view.addSubview(zipcodeLabel)
        self.view.addSubview(latLabel)
        self.view.addSubview(lngLabel)
        self.view.addSubview(catchPhraseLabel)
        self.view.addSubview(bsLabel)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(websiteLabel)
        self.view.addSubview(companyNameLabel)
        self.view.addSubview(formattedAddressLabel)
    }
    
    func addTextToLabels(user: User) {
        // adds text to all labels based on the user
        if let user = self.user {
            self.streetLabel.text = user.street
            self.suiteLabel.text = user.suite
            self.cityLabel.text = user.city
            self.zipcodeLabel.text = user.zipcode
            self.latLabel.text = String(user.lat)
            self.lngLabel.text = String(user.lng)
            self.catchPhraseLabel.text = user.catchPhrase
            self.bsLabel.text = user.bs
            self.usernameLabel.text = user.userName
            self.idLabel.text = String(user.id)
            self.nameLabel.text = user.name
            self.phoneLabel.text = user.phone
            self.emailLabel.text = user.email
            self.websiteLabel.text = user.website
            self.formattedAddressLabel.text = user.formattedAddress
            self.companyNameLabel.text = user.companyName
        }
    }
    
    func disableTranslatesAutoresizingMaskIntoConstraints() {
        // disables translates autoresizing mask in connstraints for all labels
        streetLabel.translatesAutoresizingMaskIntoConstraints = false
        suiteLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        zipcodeLabel.translatesAutoresizingMaskIntoConstraints = false
        latLabel.translatesAutoresizingMaskIntoConstraints = false
        lngLabel.translatesAutoresizingMaskIntoConstraints = false
        catchPhraseLabel.translatesAutoresizingMaskIntoConstraints = false
        bsLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        formattedAddressLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}





