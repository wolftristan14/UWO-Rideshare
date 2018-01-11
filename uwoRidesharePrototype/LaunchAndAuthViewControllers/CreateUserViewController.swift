//
//  CreateUserViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

protocol CreateUserViewControllerDelegate: class { // class so you can make delegate weak
    func didFinishCreatingUser(firstName: String, lastName: String, image: UIImage)
    
}

class CreateUserViewController: UIViewController {

    weak var delegate: CreateUserViewControllerDelegate?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImageFromPhotoLibrary(_ sender: Any) {
        self.delegate?.didFinishCreatingUser(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", image: imageView.image ?? #imageLiteral(resourceName: "default-user"))
    }
    
    


}
