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

class CreateUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: CreateUserViewControllerDelegate?
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if imageView.image == nil {
            addPhotoButton.titleLabel?.isHidden = false
        } else {
        addPhotoButton.titleLabel?.isHidden = true
        }
    }
    
    @IBAction func chooseImageFromPhotoLibrary(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("hitting this")
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("picked image is the image")
            imageView.image = pickedImage

        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func finishTapped(_ sender: Any) {
        self.delegate?.didFinishCreatingUser(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", image: imageView.image ?? #imageLiteral(resourceName: "default-user"))
    }
    

}

