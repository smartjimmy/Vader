//
//  ShopViewController.swift
//  Vader
//
//  Created by James Kang on 12/26/15.
//  Copyright © 2015 James Kang. All rights reserved.
//

import UIKit
import Parse

// ball so hard

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var shopTableView: UITableView!
    
    var shopPosts = [PFObject]()
//    var imageFiles = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shopTableView.dataSource = self
        self.shopTableView.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        updateShopPost()
    }
    
    func updateShopPost() {
        
        let shopPostQuery = PFQuery(className: "ShopPost")
        //pic get attempt
        
        shopPostQuery.orderByDescending("createdAt")
        shopPostQuery.findObjectsInBackgroundWithBlock { (shopPosts:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                self.shopPosts = shopPosts!
                self.shopTableView.reloadData()
            }
        }
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopPosts.count
    }
    // updating what is in the cell from parse
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let shopCell = shopTableView.dequeueReusableCellWithIdentifier("shopCell") as! ShopCell
        let shopPost = self.shopPosts[indexPath.row]
        let user = shopPost["user"] as! PFUser
    
        shopCell.itemNameLabel.text = shopPost["itemName"] as? String
        shopCell.priceLabel.text = shopPost["itemPrice"] as? String
        shopCell.sellerNameLabel.text = shopPost["first_name"] as? String
        
        // loading images from Parse
        let picFile = shopPost["imageFile"] as! PFFile
        shopCell.shopImage.file = picFile
        shopCell.shopImage.loadInBackground()

        // grabbing the user's first name with a special query
        user.fetchIfNeededInBackgroundWithBlock { (userDetails:PFObject?, error:NSError?) -> Void in
            shopCell.sellerNameLabel.text = user["first_name"] as? String

        }
        

        
        return shopCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let shopPost = self.shopPosts[indexPath.row]
        self.performSegueWithIdentifier("shopViewToShopDetailSegue", sender: shopPost)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let indexPath = self.shopTableView.indexPathForSelectedRow
//        let shopDetailVC = segue.destinationViewController as! ShopDetailViewController
        
//        shopDetailVC.itemName = 
        
    }
    
}
