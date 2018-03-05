//
//  CreateUserViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase

protocol CreateUserViewControllerDelegate: class {  // class so you can make delegate weak
    func didFinishCreatingUser(name: String, phoneNumber: String, image: UIImage)
    
}

class CreateUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: CreateUserViewControllerDelegate?
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        nameTextField.text = Auth.auth().currentUser?.displayName

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
        
        if nameTextField.text == "" || phoneNumberTextField.text == "" {
            
            let alert = UIAlertController(title: ">:(", message: "You need to put your name and phone number!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            self.delegate?.didFinishCreatingUser(name: nameTextField.text ?? "error", phoneNumber: phoneNumberTextField.text ?? "error", image: imageView.image ?? #imageLiteral(resourceName: "default-user"))

        }
        

    }
    

}

