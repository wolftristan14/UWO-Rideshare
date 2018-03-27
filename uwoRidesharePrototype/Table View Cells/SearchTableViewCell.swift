//
//  SearchTableViewCell.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-31.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

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
    
//    var ride: RideRecord? {
//        didSet {
//            guard let ride = ride else { return }
//           // print("passengers:\(ride.passengers)")
//            let userEmail = Auth.auth().currentUser?.email ?? ""
//
//            print("does passengers have the current users email:\(ride.passengers!.contains(userEmail))")
//            if ride.driverEmail != Auth.auth().currentUser?.email && ride.passengers!.contains(userEmail) == false {
//            originLabel.highlightedText = ride.origin
//            originLabel.highlightedTextColor = .black
//            originLabel.highlightedBackgroundColor = .yellow
//            destinationLabel.highlightedText = ride.destination
//            destinationLabel.highlightedTextColor = .black
//            destinationLabel.highlightedBackgroundColor = .yellow
//            priceLabel.highlightedText = ride.price
//            priceLabel.highlightedTextColor = .black
//            priceLabel.highlightedBackgroundColor = .yellow
//            dateLabel.highlightedText = ride.date
//            dateLabel.highlightedTextColor = .black
//            dateLabel.highlightedBackgroundColor = .yellow
//
//
//            if let availableSeats = ride.availableSeats {
//                availableSeatsLabel.text = "\(String(describing: availableSeats))"
//            }
//            } else {
//                //dont make cell
//                self.isHidden = true
//            }
//            ratingView.settings.updateOnTouch = false
//            if let rating = item.rating {
//                ratingView.rating = Double(rating)
//            }
//
//            itemImageView.cancelImageDownloadTask()
//
//            if let url = item.imageUrl {
//                itemImageView.contentMode = .scaleAspectFit
//                itemImageView.setImageWith(url, placeholderImage: ItemCell.placeholder)
//            } else {
//                itemImageView.image = ItemCell.placeholder
//            }
       // }
    //}

    
}
