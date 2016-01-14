//
//  ShopDetailViewController.swift
//  Vader
//
//  Created by James Kang on 1/2/16.
//  Copyright © 2016 James Kang. All rights reserved.
//

import UIKit
import Parse

class ShopDetailViewController: UIViewController {
    
    @IBOutlet weak var itemNameDetailLabel: UILabel!
    @IBOutlet weak var sellerNameDetailLabel: UILabel!
    @IBOutlet weak var priceDetailLabel: UILabel!
    @IBOutlet weak var itemDescriptionDetailLabel: UILabel!
    @IBOutlet weak var shopDetailImage: UIImageView!
    @IBOutlet weak var sellerProfileDetailImage: UIImageView!
    
//    var imageFile: PFFile!
    var itemName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemNameDetailLabel.text = self.itemName
        
        
        
    }


}
