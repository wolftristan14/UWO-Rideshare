//
//  ProfileViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Cosmos

protocol ProfileViewControllerDelegate: class {
    func didTapSignOutButton()
    func didTapEditProfileButton(image: UIImage)
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    weak var delegate: ProfileViewControllerDelegate?
    
    @IBOutlet weak var driverRatingView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.tabBarController?.navigationItem.title = "Profile / Settings"
        
        
    }

    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        delegate?.didTapEditProfileButton(image: imageView.image ?? #imageLiteral(resourceName: "default-user"))
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        delegate?.didTapSignOutButton()
    }
    

}
