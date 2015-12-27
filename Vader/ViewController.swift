//
//  ViewController.swift
//  Vader
//
//  Created by James Kang on 12/26/15.
//  Copyright © 2015 James Kang. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signInButtonTapped(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends"], block: { (user: PFUser?, error: NSError?) -> Void in
            
            if(error != nil) {
                // Display an alert message
                let myAlert = UIAlertController(title: "Alert", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil);
                
                return
                
            }
            
            print(user)
            print("Current User Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("Current User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            //checking if access token isnt nil spo we can send to another VC
            if(FBSDKAccessToken.currentAccessToken() != nil) {
                
                self.performSegueWithIdentifier("signInToShopSegue", sender: nil)
//                let profilePage = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
//                
//                let profileNavigation = UINavigationController(rootViewController: profilePage)
//                
//                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                
//                appDelegate.window?.rootViewController = profilePage
            } else {
                print("we have a login issue")
            }
            
        })
        
    }
    
}