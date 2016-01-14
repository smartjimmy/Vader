//
//  ShopCell.swift
//  Vader
//
//  Created by James Kang on 12/30/15.
//  Copyright © 2015 James Kang. All rights reserved.


import UIKit
import Parse
import ParseUI

//custom cell for shop cells
class ShopCell: UITableViewCell {

    @IBOutlet weak var shopImage: PFImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
