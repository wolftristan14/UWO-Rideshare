//
//  AuthViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-17.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

protocol LaunchViewControllerDelegate: class { //class so you can make delegate weak
    func signOut()
}

class LaunchViewController: UIViewController {
    
    weak var delegate: LaunchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(gradientStyle:.topToBottom, withFrame:self.view.frame, andColors:[UIColor.flatPurple, UIColor.flatPurpleDark])

    }
    
    @IBAction func signoutPressed(_ sender: Any) {
        self.delegate?.signOut()
    }
    
}

