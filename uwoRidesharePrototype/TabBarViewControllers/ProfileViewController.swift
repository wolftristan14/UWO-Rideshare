//
//  ProfileViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class {
    func didTapSignOutButton()
}

class ProfileViewController: UIViewController {

    weak var delegate: ProfileViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        delegate?.didTapSignOutButton()
    }
    

}
