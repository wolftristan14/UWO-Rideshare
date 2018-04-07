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
    
    @IBOutlet weak var smokingAllowedImageView: UIImageView!
    
    @IBOutlet weak var restStopsImageView: UIImageView!
    
    @IBOutlet weak var noFoodImageView: UIImageView!
    
    @IBOutlet weak var animalsAllowedImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
