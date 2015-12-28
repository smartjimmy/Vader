//
//  ShopPostViewController.swift
//  Vader
//
//  Created by James Kang on 12/27/15.
//  Copyright © 2015 James Kang. All rights reserved.
//

import UIKit
import Parse

class ShopPostViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
//    
//    var imagePicker: UIImagePicker!
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //Text Fields logic and jumps
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == itemNameTextField {
            descriptionTextField.becomeFirstResponder()
        } else if textField == descriptionTextField {
            priceTextField.becomeFirstResponder()
            
        }
        else {
            priceTextField.resignFirstResponder()
        }
        return true
    }
    
    //Cancel Button tapped
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Post Button tapped
    @IBAction func postTapped(sender: AnyObject) {
        
        if self.itemNameTextField.text!.isEmpty {
            noItemAlert()
        } else {
            if self.descriptionTextField.text!.isEmpty {
                noDescriptionAlert()
            } else {
                if self.priceTextField.text!.isEmpty {
                    noPriceAlert()

                } else {
                    createShopPost()
                }
            }
        }
    }
    
    // function to save shoping post to parse
    func createShopPost() {
        let shopPost = PFObject(className: "ShopPost")
        shopPost.setObject(self.itemNameTextField.text!, forKey: "itemName")
        shopPost.setObject(self.descriptionTextField.text!, forKey: "itemDescription")
        shopPost.setObject(self.priceTextField.text!, forKey: "itemPrice")
        shopPost.setObject(PFUser.currentUser()!, forKey: "user")
        
        shopPost.saveInBackgroundWithBlock { (saved:Bool, error:NSError?) -> Void in
            if saved == true {
                self.dismissViewControllerAnimated(true, completion: nil)
                print("Dat youn data saved Do")
            } else {
                self.dataNotSavedAlert()
            }
        }
        
    }
    
    
    
    //alert for empty item name text field
    func noItemAlert() {
        let alert = UIAlertController(title: "Item Name", message: "Please include the name of your item", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
       self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //alert for empty description text field
    func noDescriptionAlert() {
        let alert = UIAlertController(title: "Description", message: "Please include a description of your item", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //alert for empty price text field
    func noPriceAlert() {
        let alert = UIAlertController(title: "Price", message: "Please include the price of your item", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //alert for data saving issue
    func dataNotSavedAlert() {
        let alert = UIAlertController(title: "Data Error", message: "Your data has not been saved.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
