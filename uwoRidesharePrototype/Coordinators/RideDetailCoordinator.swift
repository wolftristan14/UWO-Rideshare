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
    var isParentSearchVC: Bool!
    
    weak var delegate: RideDetailCoordinatorDelegate?
    var docRef: DocumentReference!
    var docRefRequests: DocumentReference!
    var rideDetailVC: RideDetailViewController!


    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "RideDetail", bundle: nil)
        rideDetailVC = storyboard.instantiateViewController(withIdentifier: "ridedetail") as! RideDetailViewController
        rideDetailVC.delegate = self as RideDetailViewControllerDelegate
        loadDriverImage(selectedRide: selectedRide)

        rideDetailVC.selectedRide = selectedRide
        navigationController?.pushViewController(rideDetailVC, animated: true)

        if isParentSearchVC == true {
            rideDetailVC.isJoinRideButtonHidden = false
        } else if isParentSearchVC == false {
            rideDetailVC.isJoinRideButtonHidden = true
        }
        
       // rideDetailVC.delegate = self as RideDetailViewControllerDelegate
    }
    
    func loadDriverImage(selectedRide: Ride) {
        docRef = Firestore.firestore().collection("users").document(selectedRide.driverEmail)
        print("hit load driver image method")
        docRef.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("ye")
                //rideDetailVC.driverLabel.text = querySnapshot?.data()["name"] as? String
                let downloadURLString = querySnapshot?.data()?["imageDownloadURL"] as? String
                if let downloadURL = downloadURLString {
                self.rideDetailVC.imageView.loadImageFromCache(downloadURLString: downloadURL) { image in
                    
                    self.rideDetailVC.imageView.image = image
                
                }
                }

            }
        }
    }
    
    func addPassengerToRide(ride: Ride) {
        

        docRefRequests = Firestore.firestore().collection("Requests").addDocument(data: [
            "docid": "",
            "requesterid": Auth.auth().currentUser?.email ?? "",
            "requesterName": Auth.auth().currentUser?.displayName ?? "Failed to load",
            "rideid": ride.docid,
            "driverEmail": ride.driverEmail,
            "driverName": ride.driverName,
            "createdOn": Date.init(timeIntervalSinceNow: 0),
            "requestStatus": false
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.docRefRequests.documentID)")
            }
        }
        

    }
}

extension RideDetailCoordinator: RideDetailViewControllerDelegate {
    func didJoinRide(ride: Ride) {
        delegate?.didAddUserToRide()
        navigationController?.popViewController(animated: true)
        addPassengerToRide(ride: ride)
    }
    
    
}
