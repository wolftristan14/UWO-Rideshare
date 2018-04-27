//
//  RequestDetailViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-07.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

protocol RequestDetailViewControllerDelegate: class {
    func acceptButtonTapped()
    func declineButtonTapped()
}

class RequestDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originAndDestinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    weak var delegate: RequestDetailViewControllerDelegate?
    var requesterName: String!
    var didUseRequestsArray: Bool!

    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var declineButton: UIButton!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = requesterName
        
        if didUseRequestsArray == false {
            acceptButton.isHidden = true
            declineButton.isHidden = true
        }
    }
    
    @IBAction func acceptRequestButtonTapped(_ sender: Any) {
        delegate?.acceptButtonTapped()
    }
    
    @IBAction func declineRequestButtonTapped(_ sender: Any) {
        delegate?.declineButtonTapped()
    }
    
}
