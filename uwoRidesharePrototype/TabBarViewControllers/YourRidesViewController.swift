//
//  YourRidesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase

protocol YourRidesViewControllerDelegate: class {
    func didTapAddRideButton()
    
    func didSelectRide(ride: RideRecord, postedRide: Bool)
}


class YourRidesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postedRidesArray = [RideRecord]()
    var joinedRidesArray = [RideRecord]()
    
    var postedRidesCollRef: CollectionReference!
    var fullRidesCollRef: CollectionReference!
    var joinedRidesQuery: Query!
    var joinedFullRidesQuery: Query!

    weak var delegate: YourRidesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 129
    }
    
    override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.navigationItem.title = "Your Rides"
        loadPostedRides()
        loadPostedFullRides()
        loadJoinedRides()
        tableView.reloadData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("your rides vc number of rows hit")
        if section == 0 {
            return postedRidesArray.count
        } else {
        return joinedRidesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("your rides vc cell for row method hit")

        let cell = tableView.dequeueReusableCell(withIdentifier: "yourrides", for: indexPath) as! YourRidesTableViewCell
        
        
        if postedRidesArray.count > 0 && indexPath[0] == 0 {
        let ride = postedRidesArray[indexPath.row]

        cell.destinationLabel.text = ride.destination
        cell.originLabel.text = ride.origin
        cell.dateLabel.text = ride.date
        cell.priceLabel.text = ride.price
        cell.availableSeatsLabel.text = "\(ride.availableSeats ?? 0)"
            if ride.isSmokingAllowed == false {
                cell.smokingAllowedImageView.isHidden = true
            } else {
                cell.smokingAllowedImageView.isHidden = false

            }
            if ride.willThereBeRestStops == false {
                cell.restStopsImageView.isHidden = true
            } else {
                cell.restStopsImageView.isHidden = false

            }
            if ride.noFoodAllowed == false {
                cell.noFoodImageView.isHidden = true
            } else {
                cell.noFoodImageView.isHidden = false

            }
            if ride.animalsAllowed == false {
                cell.animalsAllowedImageView.isHidden = true
            } else {
                cell.animalsAllowedImageView.isHidden = false

            }
            return cell

        } else if joinedRidesArray.count > 0 && indexPath[0] == 1 {
            let ride = joinedRidesArray[indexPath.row]
            cell.destinationLabel.text = ride.destination
            cell.originLabel.text = ride.origin
            cell.dateLabel.text = ride.date
            cell.priceLabel.text = ride.price
            cell.availableSeatsLabel.text = "\(ride.availableSeats ?? 0)"
            if ride.isSmokingAllowed == false {
                cell.smokingAllowedImageView.isHidden = true
            } else {
                cell.smokingAllowedImageView.isHidden = false
                
            }
            if ride.willThereBeRestStops == false {
                cell.restStopsImageView.isHidden = true
            } else {
                cell.restStopsImageView.isHidden = false
            }
            if ride.noFoodAllowed == false {
                cell.noFoodImageView.isHidden = true
            } else {
                cell.noFoodImageView.isHidden = false
                
            }
            
            if ride.animalsAllowed == false {
                cell.animalsAllowedImageView.isHidden = true
            } else {
                cell.animalsAllowedImageView.isHidden = false
                
            }
            return cell

        } else {
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath[0] == 0 {
        let ride = postedRidesArray[indexPath[1]]
            delegate?.didSelectRide(ride: ride, postedRide: true)
        } else {
            let ride = joinedRidesArray[indexPath[1]]
            delegate?.didSelectRide(ride: ride, postedRide: false)
        }
        

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
        return "Posted"
        } else {
            return "Joined"
        }

    }
    

    @IBAction func addRideButtonTapped(_ sender: Any) {
        self.delegate?.didTapAddRideButton()
    }
    
    func loadPostedRides()  {
       // self.yourRidesViewController.postedRideArray = self.postedRidesArray
        postedRidesCollRef = Firestore.firestore().collection("Rides")
        
        postedRidesCollRef.whereField("driverEmail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        
                        let newRide = RideRecord(json: document.data(), id: document.documentID)
                        //ride.docid = document.documentID
                        
                        //self.postedRidesArray.append(newRide)
                        var index = 0
                        for ride in self.postedRidesArray {
                            if ride.docid == newRide.docid {
                                self.postedRidesArray.remove(at: index)
                            } else {
                                index += 1
                            }
                        }
                        self.postedRidesArray.append(newRide)
                        
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        
    }
    
    func loadPostedFullRides() {
        fullRidesCollRef = Firestore.firestore().collection("FullRides")
        
        fullRidesCollRef.whereField("driverEmail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {

                
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        
                        let newRide = RideRecord(json: document.data(), id: document.documentID)
                        //ride.docid = document.documentID
                        var index = 0
                        for ride in self.postedRidesArray {
                            if ride.docid == newRide.docid {
                                self.postedRidesArray.remove(at: index)
                            } else {
                                index += 1
                            }
                        }
                        
                        self.postedRidesArray.append(newRide)
                        //print("added ride")
                        //self.yourRidesViewController.postedRideArray = self.postedRidesArray
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func loadJoinedRides() {
        let userUID = Auth.auth().currentUser?.uid ?? ""
        joinedRidesQuery = Firestore.firestore().collection("Rides").whereField("passengers.\(userUID)", isEqualTo: true)
        //print("userDisplayName:\(userDisplayName)")
        
        joinedRidesQuery.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let newRide = RideRecord(json: document.data(), id: document.documentID)
                    
                    var index = 0
                    for ride in self.joinedRidesArray {
                        if ride.docid == newRide.docid {
                            self.joinedRidesArray.remove(at: index)
                        } else {
                            index += 1
                        }
                    }
                    
                    self.joinedRidesArray.append(newRide)
                    //print("added ride")
                    self.tableView.reloadData()
                    //print(document.data())
                    
                }
            }
        }
        
        joinedFullRidesQuery = Firestore.firestore().collection("FullRides").whereField("passengers.\(userUID)", isEqualTo: true/*[userUID: true]*/)
        //print("userDisplayName:\(userDisplayName)")
        
        joinedFullRidesQuery.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let newRide = RideRecord(json: document.data(), id: document.documentID)
                    
                    var index = 0
                    for ride in self.joinedRidesArray {
                        if ride.docid == newRide.docid {
                            self.joinedRidesArray.remove(at: index)
                        } else {
                            index += 1
                        }
                    }
                    
                    self.joinedRidesArray.append(newRide)
                    //print("added ride")
                    self.tableView.reloadData()
                    //print(document.data())
                    
                }
            }
        }
        
        
    }
    
    
}
