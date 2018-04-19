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
    var docRef: DocumentReference!
    var storage: Storage!
    var storageRef: StorageReference!
    var newUser: User!
    var user: User!

    var isNavBarHidden: Bool!
    var isNameHidden: Bool!


    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "CreateUser", bundle: nil)
        let createUserVC = storyboard.instantiateViewController(withIdentifier: "createuser") as! CreateUserViewController
        print("navigationController:\(createUserVC.navigationController)")
        if isNavBarHidden == true {
            createUserVC.isNavBarHidden = true
        } else {
            createUserVC.isNavBarHidden = false

        }
        if isNameHidden == true {
            createUserVC.isNameHidden = true
            createUserVC.user = user
        } else {
            createUserVC.isNameHidden = false

        }
        createUserVC.delegate = self as CreateUserViewControllerDelegate
        navigationController?.pushViewController(createUserVC, animated: true)
    }
    
    func loadUserData() {
        
    }
    
    
    func storeImageInFirebaseStorage(image: UIImage, completionHandler: @escaping ( _ imageDownloadURL:String) -> Void) {
        let data = UIImageJPEGRepresentation(image, 0.3)!
        storage = Storage.storage()
        storageRef = storage.reference()
        let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        self.storageRef.child(filePath).putData(data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                
                let imageDownloadURL = metaData!.downloadURL()!.absoluteString
                completionHandler(imageDownloadURL)

            }
            
        }
    }
    
    func writeNewUserDataToDatabase(user: User) {
        if Auth.auth().currentUser != nil {
        
        docRef = Firestore.firestore().document("users/\(Auth.auth().currentUser?.email ?? "no email, probably added phone sign in, update to work with phone number if this comes up")")
            
         docRef.setData([
            "email": user.email,
            "name": user.name,
            "phoneNumber": user.phoneNumber,
            "imageDownloadURL": user.imageDownloadURL,
            "notificationTokens": user.notificationTokens,
            "rating": 5
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //self.navigationController?.popViewController(animated: true)
                self.delegate?.didDismissCreateUserViewController()
                print("Document added with ID: \(self.docRef!.documentID)")
                
            }
        }
        } else {
           print("error")
        }
    }
    
    func updateUserData(phoneNumber: String, imageDownloadURL: String) {
        
            docRef = Firestore.firestore().document("users/\(Auth.auth().currentUser?.email ?? "no email, probably added phone sign in, update to work with phone number if this comes up")")
        docRef.updateData([
            "phoneNumber": phoneNumber,
            "imageDownloadURL": imageDownloadURL,
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    //self.navigationController?.popViewController(animated: true)
                    //self.delegate?.didDismissCreateUserViewController()
                    print("Document updated with ID: \(self.docRef!.documentID)")
                    
                }
        }
        
    }

}

extension CreateUserCoordinator: CreateUserViewControllerDelegate {
    func didFinishUpdatingUser(phoneNumber: String, image: UIImage) {
        self.navigationController?.popViewController(animated: true)
        storeImageInFirebaseStorage(image: image) {imageDownloadURL in
           // self.newUser.imageDownloadURL = imageDownloadURL
            self.updateUserData(phoneNumber: phoneNumber, imageDownloadURL: imageDownloadURL)
            
        }
    }
    
    func didFinishCreatingUser(name: String, phoneNumber: String, image: UIImage, notificationTokens: [String]) {
        self.navigationController?.popViewController(animated: true)
        newUser = User(name: name, phoneNumber: phoneNumber, email: Auth.auth().currentUser?.email ?? "error", imageDownloadURL: "", notificationTokens: notificationTokens, image: nil)
        storeImageInFirebaseStorage(image: image) {imageDownloadURL in
            self.newUser.imageDownloadURL = imageDownloadURL
            self.writeNewUserDataToDatabase(user: self.newUser)

        }
        

    }
    
    
    
}
