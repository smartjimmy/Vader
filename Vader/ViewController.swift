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
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("signInToShopSegue", sender: nil)
        }
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
                let requestParameters = ["fields": "id, email, first_name, last_name"]
                
                let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
                
                userDetails.startWithCompletionHandler { (connection, result, error: NSError!) -> Void in
                    
                    if(error != nil) {
                        print("\(error.localizedDescription)")
                        return
                    }
                    
                    if(result != nil) {
                        
                        let userId:String = result["id"] as! String
                        let userFirstName:String? = result["first_name"] as? String
                        let userLastName:String? = result["last_name"] as? String
                        let userEmail:String? = result["email"] as? String
                        
                        print("\(userEmail)")
                        
                        let myUser:PFUser = PFUser.currentUser()!
                        
                        //save their firstname
                        if(userFirstName != nil) {
                            myUser.setObject(userFirstName!, forKey: "first_name")
                        }
                        
                        //save their lastname
                        if(userLastName != nil) {
                            myUser.setObject(userLastName!, forKey: "last_name")
                        }
                        
                        // Save email address
                        if(userEmail != nil)
                        {
                            myUser.setObject(userEmail!, forKey: "email")
                        }
                        
                        //dispatch asynch task
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            
                            
                            // Get Facebook profile picture
                            var userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                            
                            let profilePictureUrl = NSURL(string: userProfile)
                            
                            let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                            
                            if(profilePictureData != nil) {
                                let profileFileObject = PFFile(data: profilePictureData!)
                                myUser.setObject(profileFileObject!, forKey: "profile_picture")
                                
                            }
                            
                            myUser.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                                
                                if(success) {
                                    print("user details are updated brah!")
                                }
                                
                            })
                        }
                        
                    }
                    
                }

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