//
//  SearchTableViewCell.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-31.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var availableSeatsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
