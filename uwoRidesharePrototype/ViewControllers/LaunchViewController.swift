//
//  AuthViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-17.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol LaunchViewControllerDelegate: class {
    func signOut()
}

class LaunchViewController: UIViewController {
    
    var delegate: LaunchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signoutPressed(_ sender: Any) {
        self.delegate?.signOut()
    }
    
}

