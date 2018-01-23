//
//  YourRidesTableViewCell.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-23.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit

class YourRidesTableViewCell: UITableViewCell {

    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var availableSeatsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
