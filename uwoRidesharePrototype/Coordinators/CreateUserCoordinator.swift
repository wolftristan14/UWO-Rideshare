//
//  CreateUserCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Foundation
import Firebase


protocol CreateUserCoordinatorDelegate: class {
   func didDismissCreateUserViewController()
}

class CreateUserCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    weak var delegate: CreateUserCoordinatorDelegate?
    var childCoordinators = [NSObject]()
    var databaseRef: DocumentReference!
    var storage: Storage!
    var storageRef: StorageReference!


    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "CreateUser", bundle: nil)
        let createUserVC = storyboard.instantiateViewController(withIdentifier: "createuser") as! CreateUserViewController
        createUserVC.delegate = self as CreateUserViewControllerDelegate
        navigationController?.pushViewController(createUserVC, animated: true)
    }
    
    func writeNewUserDataToDatabase(firstName: String, lastName: String, imageDownloadURL: String) {
        databaseRef = Firestore.firestore().document("users/\(firstName)")
        databaseRef.setData([
            "firstName": firstName,
            "lastName": lastName,
            "imageDownloadURL": imageDownloadURL
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didDismissCreateUserViewController()
                print("Document added with ID: \(self.databaseRef!.documentID)")
                
            }
        }
    }

}

extension CreateUserCoordinator: CreateUserViewControllerDelegate {
    func didFinishCreatingUser(firstName: String, lastName: String, image: UIImage) {
        let data = UIImageJPEGRepresentation(image, 0.8)!
        storage = Storage.storage()
        storageRef = storage.reference()
        // set upload path
        let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        self.storageRef.child(filePath).putData(data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                let imageDownloadURL = metaData!.downloadURL()!.absoluteString
                self.writeNewUserDataToDatabase(firstName: firstName, lastName: lastName, imageDownloadURL: imageDownloadURL)
            }

        }

    }
    
    
    
}
