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
    var createUserDocRef: DocumentReference!
    var updateUserDocRef: DocumentReference!
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
        self.storageRef.child(filePath).downloadURL(){(url, error) in
        if let error = error {
                print(error.localizedDescription)
                return
        }else{
            
            if let url = url {
                let urlString = url.absoluteString
                completionHandler(urlString)
            }
        }
        }
//        self.storageRef.child(filePath).putData(data, metadata: metaData){(metaData,error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }else{
//                //metaData?.path
//               // metaData?.storageReference
//
//                let imageDownloadURL = metaData?
//                //let imageDownloadURL = metaData!.downloadURL()!.absoluteString
//                completionHandler(imageDownloadURL!)
//
//            }
//
//        }
    }
    
    func writeNewUserDataToDatabase(user: User) {
        if Auth.auth().currentUser != nil {
        
        createUserDocRef = Firestore.firestore().document("users/\(Auth.auth().currentUser?.uid ?? "no email, probably added phone sign in, update to work with phone number if this comes up")")
         createUserDocRef.setData([
            "email": user.email,
            "name": user.name,
            "phoneNumber": user.phoneNumber,
            "imageDownloadURL": user.imageDownloadURL,
            "notificationTokens": user.notificationTokens,
            "rating": user.rating,
            "numRatings": user.numRatings
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //self.navigationController?.popViewController(animated: true)
                self.delegate?.didDismissCreateUserViewController()
                print("Document added with ID: \(self.createUserDocRef!.documentID)")
                
            }
        }
        } else {
           print("error")
        }
    }
    
    func updateUserData(phoneNumber: String, imageDownloadURL: String) {
        
            updateUserDocRef = Firestore.firestore().document("users/\(Auth.auth().currentUser?.uid ?? "no email, probably added phone sign in, update to work with phone number if this comes up")")
        updateUserDocRef.updateData([
            "phoneNumber": phoneNumber,
            "imageDownloadURL": imageDownloadURL,
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    //self.navigationController?.popViewController(animated: true)
                    //self.delegate?.didDismissCreateUserViewController()
                    print("Document updated with ID: \(self.updateUserDocRef!.documentID)")
                    
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
        newUser = User(name: name, phoneNumber: phoneNumber, email: Auth.auth().currentUser?.email ?? "error", imageDownloadURL: "", notificationTokens: notificationTokens, image: nil, rating: 5, numRatings: 0)
        storeImageInFirebaseStorage(image: image) {imageDownloadURL in
            self.newUser.imageDownloadURL = imageDownloadURL
            self.writeNewUserDataToDatabase(user: self.newUser)

        }
        

    }
    
    
    
}
