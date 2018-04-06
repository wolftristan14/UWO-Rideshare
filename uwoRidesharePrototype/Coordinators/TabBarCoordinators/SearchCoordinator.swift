//
//  SearchCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-22.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AlgoliaSearch

protocol SearchCoordinatorDelegate: class {
    
}

class SearchCoordinator: NSObject {
    
    //move api key to server for security
    let client = Client(appID: "NB1PXG4WJM", apiKey: "6132710f15ba25f5b14971533c42c209")
    //let index = client.index(withName: "Rides")

    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    //var allRidesArray = [Ride]()
    
    var collRef: CollectionReference!
    var searchViewController: SearchViewController!
    var counter: Bool!
    var timer: Timer!
    
    weak var delegate: SearchCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {

            searchViewController = navigationController?.visibleViewController?.childViewControllers[0] as! SearchViewController
        print(searchViewController)

        searchViewController.delegate = self

        searchViewController.tabBarController?.navigationItem.title = "Search"

        
       // loadFirebaseData()
        
    }
    
    func loadFirebaseData()  {
        print("search vc loadFirebaseData hit")
        
//        collRef = Firestore.firestore().collection("Rides")
//
//        collRef.addSnapshotListener { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//               // print("add snapshotlistener hit")
//                if querySnapshot?.documents.count == 0 {
//                    self.searchViewController.rideArray = self.allRidesArray
//                    self.searchViewController.tableView.reloadData()
//                }
//
//                for document in querySnapshot!.documents {
//                    print(querySnapshot?.documents.count)
//                    //print("\(document.documentID) => \(document.data())")
//                    let driverEmail = document.data()["driverEmail"] as! String
//                    if document.data().count > 0 && driverEmail != Auth.auth().currentUser?.email {
//                        let ride = Ride(docid: document.documentID, origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSeats"] as! Int, driverEmail: document.data()["driverEmail"] as! String, driverName: document.data()["driverName"] as! String,  passengers: document.data()["passengers"] as! Array, createdOn: document.data()["createdOn"] as! Date)
//
//
//                    self.allRidesArray.append(ride)
//                    print("added ride")
//                    self.searchViewController.rideArray = self.allRidesArray
//                    self.searchViewController.tableView.reloadData()
//                    }
//
//                    if document == querySnapshot?.documents.last {
//                        self.allRidesArray.removeAll()
//                    }
//
//                }
//            }
//        }
        
//       let index = client.index(withName: "Rides")
//        index.search(Query(query: "brampton"), completionHandler: { (content, error) -> Void in
//            if error == nil {
//                print("Result: \(content!)")
//            }
//        })
        
//        let query = Query(query: "s")
//        query.attributesToRetrieve = ["firstname", "lastname"]
//        query.hitsPerPage = 50
//        index.search(query, completionHandler: { (content, error) -> Void in
//            if error == nil {
//                print("Result: \(content!)")
//            }
//        })
        
    }
    
//   func loadSearchData(origin: String, destination: String) {
//    print("origin: \(origin), destination: \(destination)")
//    let queries = [
//        IndexQuery(indexName: "Rides", query: Query(query: origin)),
//        IndexQuery(indexName: "Rides", query: Query(query: destination))
//    ]
//
//    client.multipleQueries(queries, completionHandler: { (content, error) -> Void in
//        if error == nil {
//            //let allResults = content!["results"]
//
//           // print("Result: \(content!["results"])")
//        }
//    })
//
//    }

    func showRideDetail(ride: RideRecord) {
        let rideDetailCoordinator = RideDetailCoordinator(navigationController: navigationController!)
        rideDetailCoordinator.delegate = self as RideDetailCoordinatorDelegate
        rideDetailCoordinator.selectedRide = ride
        rideDetailCoordinator.isParentSearchVC = true
   
        rideDetailCoordinator.start()
        
        childCoordinators.append(rideDetailCoordinator)
        
        
    }
    
    
}

extension SearchCoordinator: SearchViewControllerDelegate {

    
    func didSelectRide(ride: RideRecord) {
        showRideDetail(ride: ride)
        print("ride when its in search coord:\(ride)")
    }
    

    
}

extension SearchCoordinator: RideDetailCoordinatorDelegate {
    func didAddUserToRide() {
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                print("timer fired")
                self.searchViewController.rideSearcher.search()
            }
        } else {
            // Fallback on earlier versions
        }
        //timer.fire()     // allRidesArray.removeAll()
        //loadFirebaseData()
    }
    
    
}



