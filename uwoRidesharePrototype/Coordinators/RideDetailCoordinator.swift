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
        navigationController?.pushViewController(rideDetailVC, animated: true)
        //loadDriverImageAndName(selectedRide: selectedRide, rideDetailVC: rideDetailVC)

        if isParentSearchVC == true {
            rideDetailVC.isJoinRideButtonHidden = false
        } else if isParentSearchVC == false {
            rideDetailVC.isJoinRideButtonHidden = true
        }
        
       // rideDetailVC.delegate = self as RideDetailViewControllerDelegate
    }
    
    func loadDriverImageAndName(selectedRide: Ride, rideDetailVC: RideDetailViewController) {
        docRef = Firestore.firestore().collection("users").document(selectedRide.driver)
        print("hit load driver image method")
        docRef.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("ye")
                rideDetailVC.driverLabel.text = querySnapshot?.data()["firstName"] as? String
                let downloadURLString = querySnapshot?.data()["imageDownloadURL"] as? String
                rideDetailVC.imageView.loadImageFromCache(downloadURLString: downloadURLString!, viewController: rideDetailVC)

            }
        }
    }
    
    func addPassengerToRide(ride: Ride) {
        

        docRefRequests = Firestore.firestore().collection("Requests").addDocument(data: [
            "requesterid": Auth.auth().currentUser?.email ?? "",
            "rideid": "",
            "driverEmail": ride.driver,
            "createdOn": Date.init(timeIntervalSinceNow: 0),
            "requestStatus": false
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.docRefRequests.documentID)")
            }
        }
        
//        docRefRides = Firestore.firestore().document("Rides/\(ride.origin) to \(ride.destination), \(ride.date)")
//
//        ride.passengers.append((Auth.auth().currentUser?.email!)!)
//
//        if ride.availableSeats > 0 {
//            docRefRides.updateData(["availableSpots": ride.availableSeats - 1])
//            docRefRides.collection("Passengers").document("Passenger\(Auth.auth().currentUser?.email ?? "")").setData(["name": Auth.auth().currentUser?.displayName ?? "", "email": Auth.auth().currentUser?.email ?? ""])
//        } else {
//            print("ride is full")
//
//        }
//    }
    }
}

extension RideDetailCoordinator: RideDetailViewControllerDelegate {
    func didJoinRide(ride: Ride) {
        delegate?.didAddUserToRide()
        navigationController?.popViewController(animated: true)
        addPassengerToRide(ride: ride)
    }
    
    
}
