//
//  RequestDetailViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-07.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol RequestDetailViewControllerDelegate: class {
    
}

class RequestDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originAndDestinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    weak var delegate: RequestDetailViewControllerDelegate?
    var requesterName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = requesterName
    }
    
    @IBAction func acceptRequestButtonTapped(_ sender: Any) {
    }
    
    @IBAction func declineRequestButtonTapped(_ sender: Any) {
    }
    
}
