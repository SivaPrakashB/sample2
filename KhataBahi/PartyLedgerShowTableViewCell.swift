//
//  PartyLedgerShowTableViewCell.swift
//  KhataBahi
//
//  Created by Narayan on 6/12/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class PartyLedgerShowTableViewCell: UITableViewCell {
    @IBOutlet weak var credit: UILabel!
    
    @IBOutlet weak var debit: UILabel!
    @IBOutlet weak var particular: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
