//
//  ProfileViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

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
    var docRefLoadUserProfile: DocumentReference!
    var user: User!


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFirebaseData()
        self.tabBarController?.navigationItem.title = "Profile / Settings"
        
        
    }
    
    func loadFirebaseData()  {
        let userUID = Auth.auth().currentUser?.uid ?? ""
        docRefLoadUserProfile = Firestore.firestore().collection("users").document(userUID)
        
        docRefLoadUserProfile.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //for document in querySnapshot!.documents {
                //print("\(document.documentID) => \(document.data())")
                let data = querySnapshot?.data() ?? [:]
                
                if data.count > 0 {
                    self.user = User(name: data["name"] as! String, phoneNumber: data["phoneNumber"] as! String, email: data["email"] as! String, imageDownloadURL: data["imageDownloadURL"] as? String, notificationTokens: data["notificationTokens"] as! [String], image: nil, rating: data["rating"] as? Double, numRatings: data["numRatings"] as? Double)
                    self.imageView.loadImageFromCache(downloadURLString: self.user.imageDownloadURL!) {image in
                        self.imageView.image = image
                    }
                    self.driverRatingView.rating = self.user.rating ?? 5
                    self.nameLabel.text = self.user.name
                    self.phoneNumberLabel.text = self.user.phoneNumber
                    self.emailLabel.text = self.user.email
                    
                }
                // }
            }
        }
        
    }

    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        delegate?.didTapEditProfileButton(image: imageView.image ?? #imageLiteral(resourceName: "default-user"))
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        delegate?.didTapSignOutButton()
    }
    

}
