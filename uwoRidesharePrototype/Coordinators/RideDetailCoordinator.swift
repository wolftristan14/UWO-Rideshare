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
    var selectedRide: RideRecord!
    var isParentSearchVC: Bool!
    
    weak var delegate: RideDetailCoordinatorDelegate?
    //var loadImagedocRef: DocumentReference!
    var addPassengerdocRef: DocumentReference!
    var docRefPastRides: DocumentReference!
    var docRefFullRides: DocumentReference!
    var channelQuery: Query!
    var channelDocRef: DocumentReference!

    var docRefRequests: DocumentReference!
    var queryRequestsToDelete: Query!
    var deleteRideDocRef: DocumentReference!
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
        rideDetailVC.selectedRide = selectedRide
        navigationController?.pushViewController(rideDetailVC, animated: true)

        if isParentSearchVC == true {
            rideDetailVC.isJoinRideButtonHidden = false
            rideDetailVC.isEndRideButtonHidden = true

        } else if isParentSearchVC == false {
            rideDetailVC.isJoinRideButtonHidden = true
            rideDetailVC.isEndRideButtonHidden = false

        }
        
    }
    
    
    func addPassengerToRide(ride: RideRecord) {
        print(ride.docid!)
        addPassengerdocRef = Firestore.firestore().collection("Rides").document(ride.docid!)
        //var passengerArray = ride.passengers
        //passengerArray?.append((Auth.auth().currentUser?.email)!)
        let userUID = Auth.auth().currentUser?.uid ?? ""
        addPassengerdocRef.updateData(["passengers.\(userUID)": false]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(self.addPassengerdocRef.documentID)")
                        }
                    }

        docRefRequests = Firestore.firestore().collection("Requests").addDocument(data: [
            "docid": "",
            "requesterid": Auth.auth().currentUser?.uid ?? "",
            "requesterName": Auth.auth().currentUser?.displayName ?? "Failed to load",
            "rideid": ride.docid ?? "",
            "driverEmail": ride.driverEmail ?? "",
            "driverName": ride.driverName ?? "",
            "driverUID": ride.driverUID ?? "",
            "createdOn": Date.init(timeIntervalSinceNow: 0),
            "requestStatus": false,
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.docRefRequests.documentID)")
            }
        }
        

    }
    
    func addPassengerToRideChannel(ride: RideRecord) {
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
        
        channelDocRef.updateData(["members.\(Auth.auth().currentUser?.uid ?? "")" : false])
    }
    
    func deleteOldRide(ride: RideRecord) {
        if let docid = ride.docid {
        
            deleteRideDocRef = Firestore.firestore().collection("Rides").document(docid)

            deleteRideDocRef.delete()
        }
    }
    
    func deleteOldFullRide(ride: RideRecord) {
        if let docid = ride.docid {

        docRefFullRides = Firestore.firestore().collection("FullRides").document(docid)
        
        docRefFullRides.delete()
        }
    }
    
    func deleteRequests(ride: RideRecord) {
        print(ride.docid)
       queryRequestsToDelete = Firestore.firestore().collection("Requests").whereField("rideid", isEqualTo: ride.docid!)
        

        queryRequestsToDelete.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("ye")
                let batch = Firestore.firestore().batch()
                print("request document count\(querySnapshot?.documents.count)")
                for document in (querySnapshot?.documents)! {
                    batch.deleteDocument(document.reference)
                }
                batch.commit() { err in
                    if let err = err {
                        print("Error writing batch \(err)")
                    } else {
                        print("Batch write succeeded.")
                    }
                }

            }
        }

        
    }
    
    func addCompletedRideToPastRides(ride: RideRecord) {
        if let docid = ride.docid {
        docRefPastRides = Firestore.firestore().collection("PastRides").document(docid)
        
        docRefPastRides.setData([
            
            "docid": ride.docid!,
            "driverEmail": ride.driverEmail!,
            "driverName": ride.driverName!,
            "driverUID": ride.driverUID!,
            "destination": ride.destination!,
            "origin": ride.origin!,
            "date": ride.date!,
            "price": ride.price!,
            "availableSeats": ride.availableSeats!,
            "createdOn": ride.createdOn!,
            "passengers": ride.passengers!,
            "isSmokingAllowed": ride.isSmokingAllowed!,
            "willThereBeRestStops": ride.willThereBeRestStops!,
            "noFoodAllowed": ride.noFoodAllowed!,
            "animalsAllowed": ride.animalsAllowed!,
            "baggageSize": ride.baggageSize!
            
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                  print("Document added with ID: \(self.docRefPastRides.documentID)")
                
            }
        }
        }
    }
}

extension RideDetailCoordinator: RideDetailViewControllerDelegate {
    func didJoinRide(ride: RideRecord) {
        print("rideid:\(ride.docid)")
        delegate?.didAddUserToRide()
        navigationController?.popViewController(animated: true)
        addPassengerToRide(ride: ride)
        addPassengerToRideChannel(ride: ride)
    }
    
    func didEndRide(ride: RideRecord) {
        deleteOldRide(ride: ride)
        deleteOldFullRide(ride: ride)
        deleteRequests(ride: ride)
        addCompletedRideToPastRides(ride: ride)
        navigationController?.popViewController(animated: true)
    }
    
    
}
