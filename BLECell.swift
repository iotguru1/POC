//
//  BLECell.swift
//  ListBLEDevices
//
//  Created by Yogesh Ranjan on 5/18/15.
//  Copyright (c) 2015 KSYR. All rights reserved.
//

import UIKit

class BLECell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var bleImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
