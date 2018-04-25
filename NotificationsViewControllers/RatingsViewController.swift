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
    var driverName: String!


    @IBOutlet weak var rateDriverView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rateDriverView.rating = 5
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let driver = driverName {
        driverLabel.text = "Rate \(driver)"
        }
    }

    @IBAction func rateDriverButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate.didDismissRatingsViewController(rating: rateDriverView.rating, driverid: driverid)
    }
    
    

}
