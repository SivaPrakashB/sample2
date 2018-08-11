//
//  purchaseListShowTableViewCell.swift
//  KhataBahi
//
//  Created by Narayan on 4/25/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class purchaseListShowTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var Amount: UILabel!
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var voucherName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
