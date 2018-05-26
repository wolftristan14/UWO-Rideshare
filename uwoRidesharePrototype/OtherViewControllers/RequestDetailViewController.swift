//
//  RequestDetailViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-07.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
import Firebase

protocol RequestDetailViewControllerDelegate: class {
    func acceptButtonTapped(ride: RideRecord)
    func declineButtonTapped()
}

class RequestDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originAndDestinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    weak var delegate: RequestDetailViewControllerDelegate?
    var requesterName: String!
    var didUseRequestsArray: Bool!

    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var declineButton: UIButton!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    var docRefRide: DocumentReference!
    var docRefUser: DocumentReference!
    var selectedRequest: RideRequest!
    var ride: RideRecord!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = selectedRequest.requesterName
        loadFirebaseData()
        loadRequesterImage()
        
        if didUseRequestsArray == false {
            acceptButton.isHidden = true
            declineButton.isHidden = true
        }
    }
    
    @IBAction func acceptRequestButtonTapped(_ sender: Any) {
        delegate?.acceptButtonTapped(ride: ride)
    }
    
    @IBAction func declineRequestButtonTapped(_ sender: Any) {
        delegate?.declineButtonTapped()
    }
    
    func loadFirebaseData() {
        docRefRide = Firestore.firestore().collection("Rides").document(selectedRequest.rideid)
        docRefRide.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let snapshotData = querySnapshot?.data() {
                    self.ride = RideRecord(json: snapshotData, id: (querySnapshot?.documentID)!)
                }
                self.originAndDestinationLabel.text = "\(self.ride.origin ?? "") to \(self.ride.destination ?? "")"
                self.dateLabel.text = self.ride.date
                self.priceLabel.text = self.ride.price
                
                
                
                
            }
        }
    }
    
    func loadRequesterImage() {
        docRefUser = Firestore.firestore().collection("users").document(selectedRequest.requesterid)
        docRefUser.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //print(querySnapshot?.documentID)
                self.ratingView.rating = querySnapshot?.data()?["rating"] as! Double
                let downloadURLString = querySnapshot?.data()?["imageDownloadURL"] as? String
                if let downloadURL = downloadURLString {
                    self.imageView.loadImageFromCache(downloadURLString: downloadURL) { image in
                        
                        self.imageView.image = image
                        
                    }
                    
                }
            }
        }
    }
    
}
