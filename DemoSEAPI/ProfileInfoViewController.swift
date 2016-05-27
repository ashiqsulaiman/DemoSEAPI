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
    
        //To clip the profile image to circle and add border
        self.userPPImageView.clipsToBounds = true
        self.userPPImageView.layer.borderWidth = 5.0
        self.userPPImageView.layer.borderColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6).CGColor
        
        //initial state to perform the animation
        userPPImageView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
            self.userPPImageView.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
 

}
