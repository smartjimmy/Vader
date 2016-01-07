//
//  ProfileViewController.swift
//  Vader
//
//  Created by James Kang on 12/26/15.
//  Copyright © 2015 James Kang. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicBlur: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            
            let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            let loginNavigation = UINavigationController(rootViewController: loginPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = loginNavigation
            
        }
    }
    
}
