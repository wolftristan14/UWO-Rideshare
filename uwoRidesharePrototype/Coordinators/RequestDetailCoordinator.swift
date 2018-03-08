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
    var docRef: DocumentReference!
    var docRefUser: DocumentReference!
    var requestDetailVC: RequestDetailViewController!
    var selectedRequest: RideRequest!
    
    
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "RequestDetail", bundle: nil)
        requestDetailVC = storyboard.instantiateViewController(withIdentifier: "requestdetail") as! RequestDetailViewController
        requestDetailVC.delegate = self as? RequestDetailViewControllerDelegate
        requestDetailVC.requesterName = selectedRequest.requesterName
        navigationController?.pushViewController(requestDetailVC, animated: true)
        loadFirebaseData(selectedRequest: selectedRequest)
        loadRequesterImage(selectedRequest: selectedRequest)
    }
    
    func loadFirebaseData(selectedRequest: RideRequest) {
        docRef = Firestore.firestore().collection("Rides").document(selectedRequest.rideid)
        docRef.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let ride = Ride(docid: (querySnapshot?.documentID)!, origin: querySnapshot?.data()["origin"] as! String, destination: querySnapshot?.data()["destination"] as! String, date: querySnapshot?.data()["date"] as! String, price: querySnapshot?.data()["price"] as! String, availableSeats: querySnapshot?.data()["availableSeats"] as! Int, driverEmail: querySnapshot?.data()["driverEmail"] as! String, driverName: querySnapshot?.data()["driverName"] as! String, passengers: querySnapshot?.data()["passengers"] as! Array, createdOn: querySnapshot?.data()["createdOn"] as! Date)
                
                self.requestDetailVC.originAndDestinationLabel.text = "\(ride.origin) to \(ride.destination)"
                self.requestDetailVC.dateLabel.text = ride.date
                self.requestDetailVC.priceLabel.text = ride.price
                

                
                
            }
        }
    }
    
    func loadRequesterImage(selectedRequest: RideRequest) {
        docRefUser = Firestore.firestore().collection("users").document(selectedRequest.requesterid)
        docRefUser.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //print(querySnapshot?.documentID)
                let downloadURLString = querySnapshot?.data()["imageDownloadURL"] as? String
                self.requestDetailVC.imageView.loadImageFromCache(downloadURLString: downloadURLString!) { image in
                    
                    self.requestDetailVC.imageView.image = image
                    
                }
                
                
            }
        }
    }
    
    
    
}
