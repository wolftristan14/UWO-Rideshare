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
   func didAddUserToRide()
}

class RideDetailCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var selectedRide: Ride!
    
    weak var delegate: RideDetailCoordinatorDelegate?
    var docRef: DocumentReference!
    var docRefRides: DocumentReference!

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
        rideDetailVC.delegate = self as RideDetailViewControllerDelegate
        loadDriverImageAndName(selectedRide: selectedRide, rideDetailVC: rideDetailVC)
        rideDetailVC.selectedRide = selectedRide
        
       // rideDetailVC.delegate = self as RideDetailViewControllerDelegate
        navigationController?.pushViewController(rideDetailVC, animated: true)
    }
    
    func loadDriverImageAndName(selectedRide: Ride, rideDetailVC: RideDetailViewController) {
        docRef = Firestore.firestore().collection("users").document(selectedRide.driver)
        print("hit load driver image method")
        docRef.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                rideDetailVC.driverLabel.text = querySnapshot?.data()["firstName"] as? String
                let downloadURLString = querySnapshot?.data()["imageDownloadURL"] as? String
                //let downloadURL = URL(fileURLWithPath: downloadURLString!)
                self.storage = Storage.storage()
                let storageRef = self.storage.reference(forURL: downloadURLString!)
                storageRef.getData(maxSize: 1 * 2000 * 2000) { (data, error) -> Void in
                    print("got image data")
                    let image = UIImage(data: data!)
                    rideDetailVC.imageView.image = image
                    
                }

                    

                
            }
        }
    }
    
    func addPassengerToRide(ride: Ride) {
        docRefRides = Firestore.firestore().document("Rides/\(ride.origin) to \(ride.destination), \(ride.date)")
        //update passenger area (add current user email), take available seats down by 1
        
        ride.passengers.append((Auth.auth().currentUser?.email!)!)
        
        docRefRides.updateData(["passengers": ride.passengers])
    }
}

extension RideDetailCoordinator: RideDetailViewControllerDelegate {
    func didJoinRide(ride: Ride) {
        delegate?.didAddUserToRide()
        navigationController?.popViewController(animated: true)
        addPassengerToRide(ride: ride)
    }
    
    
}
