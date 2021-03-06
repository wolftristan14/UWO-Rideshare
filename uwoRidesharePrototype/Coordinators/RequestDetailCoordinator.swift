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
    var docRefFullRides: DocumentReference!
    var docRefRequest: DocumentReference!
    var channelQuery: Query!
    var channelDocRef: DocumentReference!

    var requestDetailVC: RequestDetailViewController!
    var selectedRequest: RideRequest!
    var ride: RideRecord!
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
        requestDetailVC.selectedRequest = selectedRequest
        navigationController?.pushViewController(requestDetailVC, animated: true)
    }
    

    
    func changeRequestStatus() {
        docRefRequest = Firestore.firestore().collection("Requests").document(selectedRequest.docid)
        
        docRefRequest.updateData(["requestStatus": true]) {(error) in
            if let err = error {
                print("Error getting documents: \(err)")
            }
            }
        
    }
    
    func changeChannelStatus() {
        channelQuery = Firestore.firestore().collection("Channels").whereField("members.\(ride.driverUID ?? "")", isEqualTo: true).whereField("rideid", isEqualTo: ride.docid ?? "")
        
        channelQuery.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.addUserToChannel(data: document.data(), docid: document.documentID)
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    
    }
    
    func addUserToChannel(data: [String:Any], docid: String) {
        channelDocRef = Firestore.firestore().collection("Channels").document(docid)
        
        
        
        channelDocRef.updateData(["members.\(selectedRequest.requesterid)" : true])
    }
    
    func updateAvailableSeats() {
        docRefRide = Firestore.firestore().collection("Rides").document(selectedRequest.rideid)
        docRefFullRides = Firestore.firestore().collection("FullRides").document(selectedRequest.rideid)
        let updatedAvailableSeats = ride.availableSeats! - 1
        if updatedAvailableSeats == 0  {
            
            
        docRefFullRides.updateData(["passengers.\(selectedRequest.requesterid)": true])
            
        docRefFullRides.setData([

                "docid": ride.docid!,
                "driverEmail": ride.driverEmail!,
                "driverUID": ride.driverUID!,
                "driverName": ride.driverName!,
                "destination": ride.destination!,
                "origin": ride.origin!,
                "date": ride.date!,
                "price": ride.price!,
                "availableSeats": updatedAvailableSeats,
                "createdOn": ride.createdOn!,
                "passengers": ride.passengers!,
                "isSmokingAllowed": ride.isSmokingAllowed!,
                "willThereBeRestStops": ride.willThereBeRestStops!,
                "noFoodAllowed": ride.noFoodAllowed!,
                "animalsAllowed": ride.animalsAllowed!,
                "baggageSize": ride.baggageSize!,
                "driverRating": ride.driverRating!

                
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    self.docRefFullRides.updateData(["passengers.\(self.selectedRequest.requesterid)": true])

                  //  print("Document added with ID: \(self.docRefFullRides.document)")

                }

            }
            docRefRide.delete()
        } else {

            docRefRide.updateData(["availableSeats": updatedAvailableSeats, "passengers.\(selectedRequest.requesterid)": true]) {(error) in
            if let err = error {
                print("Error getting documents: \(err)")
            }
        }
        }
    }
    
    func deleteRequest() {
    docRefRequest = Firestore.firestore().collection("Requests").document(selectedRequest.docid)
        
        docRefRequest.delete()

    }
    
}

extension RequestDetailCoordinator: RequestDetailViewControllerDelegate {
    func acceptButtonTapped(ride: RideRecord) {
        self.ride = ride
        changeRequestStatus()
        changeChannelStatus()
        updateAvailableSeats()
        navigationController?.popViewController(animated: true)

    }
    
    func declineButtonTapped() {
        deleteRequest()
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
