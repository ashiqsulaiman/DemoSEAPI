//
//  ProfileInfoViewController.swift
//  DemoSEAPI
//
//  Created by ashiq on 02/04/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import UIKit


class ProfileInfoViewController: UIViewController {
    
    var userName: String = ""
    var userId: String = ""
    var userReputation: String = ""
    var ppImageString: String = ""
    
    

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userReputationLabel: UILabel!
    @IBOutlet weak var userPPImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
print("the username is \(userName)")
        userNameLabel.text = userName
        userIDLabel.text = userId
        userReputationLabel.text = userReputation
        //userPPImageView = imageView.Load(ppImageString)
        userPPImageView.load(ppImageString)
    
        //To clip the profile image to circle
        self.userPPImageView.clipsToBounds = true
   
 
        
    }
    

 

}
