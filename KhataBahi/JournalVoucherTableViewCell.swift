//
//  JournalVoucherTableViewCell.swift
//  KhataBahi
//
//  Created by Apple on 08/08/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class JournalVoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var Credit: UILabel!
    @IBOutlet weak var debit: UILabel!
    @IBOutlet weak var particulars: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
