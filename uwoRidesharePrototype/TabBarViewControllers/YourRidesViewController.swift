//
//  YourRidesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

protocol YourRidesViewControllerDelegate: class {
    func didTapAddRideButton()
}


class YourRidesViewController: UIViewController {

    weak var delegate: YourRidesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addRideButtonTapped(_ sender: Any) {
        self.delegate?.didTapAddRideButton()
    }
    
}
