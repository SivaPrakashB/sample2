//
//  notificationTableViewCell.swift
//  KhataBahi
//
//  Created by Narayan on 5/8/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class notificationTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var view123: UIView!
    
    
    @IBOutlet weak var messageDescription: UILabel!
    
    
    
    @IBOutlet weak var notifyImage: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
}
