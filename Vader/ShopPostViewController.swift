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
    
    
    @IBOutlet weak var shopPhoto1: UIImageView!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
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
    
    //delegate function for imagePicker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        print("Got an image")
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            let selectorToCall = Selector("imageWasSavedSuccessfully:didFinishSavingWithError:context:")
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, selectorToCall, nil)
        }
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func imageWasSavedSuccessfully(image: UIImage, didFinishSavingWithError error: NSError!, context: UnsafeMutablePointer<()>) {
        print("image was saved!")
        if let theError = error {
            print("An error ocurred while attempting to save the image = \(theError)")
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.shopPhoto1.image  = image
            })
        }
        
    }
    
    //IBAction for tapping camera and launching image picker
    @IBAction func tappedCamera1(sender: UITapGestureRecognizer) {
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
//            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: nil)
//                
//            }
//            else {
//                rearCameraAlert()
//            }
        } else {
            cameraInaccessableAlert()
        }
    }
    
    //alert for empty item name text field
    func cameraInaccessableAlert() {
        let alert = UIAlertController(title: "Camera inaccessable", message: "Application cannot access the camera.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //alert for no rear Camera
    func rearCameraAlert() {
        let alert = UIAlertController(title: "Rear camera unavailable", message: "Application cannot access the rear camera.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
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
