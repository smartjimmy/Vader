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
    }
    
//    func updateProfileInfo() {
//        var profileQuery = PFQuery(className: "User")
        
        
//        profileQuery.findObjectsInBackgroundWithBlock { (profileInfo, error: NSError?) -> Void in
//            print(profileQuery)
//        }
        
        
//    }
    
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            
            let loginPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            let loginNavigation = UINavigationController(rootViewController: loginPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = loginNavigation
            
        }
    }
    
}
