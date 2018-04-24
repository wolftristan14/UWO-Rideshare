//
//  RatingsViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-23.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit
import Cosmos

protocol RatingsViewControllerDelegate: class {
    func didDismissRatingsViewController(rating: Double, driverid: String)
}

class RatingsViewController: UIViewController {
    @IBOutlet weak var driverLabel: UILabel!
    
    weak var delegate: RatingsViewControllerDelegate!
    var driverid: String!

    @IBOutlet weak var rateDriverView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rateDriverView.rating = 5
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //driverLabel.text = "rate \(driverid)"
    }

    @IBAction func rateDriverButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate.didDismissRatingsViewController(rating: rateDriverView.rating, driverid: driverid)
    }
    
    

}
