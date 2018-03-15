//
//  RequestDetailCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-07.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol RequestDetailCoordinatorDelegate: class {
    
    
}

class RequestDetailCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    
    weak var delegate: RequestDetailCoordinatorDelegate?
    var docRefRide: DocumentReference!
    var docRefUser: DocumentReference!
    var docRefRequest: DocumentReference!

    var requestDetailVC: RequestDetailViewController!
    var selectedRequest: RideRequest!
    var ride: Ride!
    var didUseRequestsArray: Bool!

    
    
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "RequestDetail", bundle: nil)
        requestDetailVC = storyboard.instantiateViewController(withIdentifier: "requestdetail") as! RequestDetailViewController
        requestDetailVC.didUseRequestsArray = didUseRequestsArray
        requestDetailVC.delegate = self as RequestDetailViewControllerDelegate
        requestDetailVC.requesterName = selectedRequest.requesterName
        navigationController?.pushViewController(requestDetailVC, animated: true)
        loadFirebaseData()
        loadRequesterImage()
    }
    
    func loadFirebaseData() {
        docRefRide = Firestore.firestore().collection("Rides").document(selectedRequest.rideid)
        docRefRide.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.ride = Ride(docid: (querySnapshot?.documentID)!, origin: querySnapshot?.data()!["origin"] as! String, destination: querySnapshot?.data()!["destination"] as! String, date: querySnapshot?.data()!["date"] as! String, price: querySnapshot?.data()!["price"] as! String, availableSeats: querySnapshot?.data()!["availableSeats"] as! Int, driverEmail: querySnapshot?.data()!["driverEmail"] as! String, driverName: querySnapshot?.data()!["driverName"] as! String, passengers: querySnapshot?.data()!["passengers"] as! Array, createdOn: querySnapshot?.data()!["createdOn"] as! Date)
                
                self.requestDetailVC.originAndDestinationLabel.text = "\(self.ride.origin) to \(self.ride.destination)"
                self.requestDetailVC.dateLabel.text = self.ride.date
                self.requestDetailVC.priceLabel.text = self.ride.price
                

                
                
            }
        }
    }
    
    func loadRequesterImage() {
        docRefUser = Firestore.firestore().collection("users").document(selectedRequest.requesterid)
        docRefUser.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //print(querySnapshot?.documentID)
                let downloadURLString = querySnapshot?.data()?["imageDownloadURL"] as? String
                if let downloadURL = downloadURLString {
                self.requestDetailVC.imageView.loadImageFromCache(downloadURLString: downloadURL) { image in
                    
                    self.requestDetailVC.imageView.image = image
                    
                }
                
                }
            }
        }
    }
    
    func changeRequestStatus() {
        docRefRequest = Firestore.firestore().collection("Requests").document(selectedRequest.docid)
        
        docRefRequest.updateData(["requestStatus": true]) {(error) in
            if let err = error {
                print("Error getting documents: \(err)")
            }
            }
        
    }
    
    func updateAvailableSeats() {
        docRefRide = Firestore.firestore().collection("Rides").document(selectedRequest.rideid)
        
        let updatedAvailableSeats = ride.availableSeats - 1
        docRefRide.updateData(["availableSeats": updatedAvailableSeats]) {(error) in
            if let err = error {
                print("Error getting documents: \(err)")
            }
        }
    }
    
    func deleteRequest() {
    docRefRequest = Firestore.firestore().collection("Requests").document(selectedRequest.docid)
        
        docRefRequest.delete()

    }
    
}

extension RequestDetailCoordinator: RequestDetailViewControllerDelegate {
    func acceptButtonTapped() {
        changeRequestStatus()
        updateAvailableSeats()
        navigationController?.popViewController(animated: true)

    }
    
    func declineButtonTapped() {
        deleteRequest()
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
