//
//  RideDetailCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-02-05.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase


protocol RideDetailCoordinatorDelegate: class {
    
}

class RideDetailCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var selectedRide: Ride!
    
    weak var delegate: RideDetailCoordinatorDelegate?
    var docRef: DocumentReference!
    var storage: Storage!
    //var storageRef: StorageReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "RideDetail", bundle: nil)
        let rideDetailVC = storyboard.instantiateViewController(withIdentifier: "ridedetail") as! RideDetailViewController
        loadDriverImageAndName(selectedRide: selectedRide, rideDetailVC: rideDetailVC)
        rideDetailVC.selectedRide = selectedRide
        
       // rideDetailVC.delegate = self as RideDetailViewControllerDelegate
        navigationController?.pushViewController(rideDetailVC, animated: true)
    }
    
    func loadDriverImageAndName(selectedRide: Ride, rideDetailVC: RideDetailViewController) {
        docRef = Firestore.firestore().collection("users").document(selectedRide.driver)
        
        docRef.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                //print("\(document.documentID) => \(document.data())")
                rideDetailVC.driverLabel.text = querySnapshot?.data()["firstName"] as? String
                let downloadURLString = querySnapshot?.data()["imageDownloadURL"] as? String
                //let downloadURL = URL(fileURLWithPath: downloadURLString!)
                // Create a storage reference from the URL
                self.storage = Storage.storage()
                let storageRef = self.storage.reference(forURL: downloadURLString!)
                // Download the data, assuming a max size of 1MB (you can change this as necessary)
                storageRef.getData(maxSize: 1 * 5000 * 5000) { (data, error) -> Void in
                    // Create a UIImage, add it to the array
                    let image = UIImage(data: data!)
                    rideDetailVC.imageView.image = image
                    
                }

                    

                
            }
        }
    }
    
    
}
