//
//  RideDetailViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-02-02.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase
import Cosmos

protocol RideDetailViewControllerDelegate: class {
    func didJoinRide(ride: RideRecord)
    func didEndRide(ride: RideRecord)
}

class RideDetailViewController: UIViewController {
    @IBOutlet weak var joinRideButton: UIButton!
    
    @IBOutlet weak var endRideButton: UIButton!
    
    var selectedRide: RideRecord!
    
    weak var delegate: RideDetailViewControllerDelegate?
    
    @IBOutlet weak var imageView: ProfileImageStyleManager!
    
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var availableSeatsLabel: UILabel!
    
    @IBOutlet weak var driverLabel: UILabel!
    
    @IBOutlet weak var baggageSizeLabel: UILabel!
    
    @IBOutlet weak var isSmokingAllowedImageView: UIImageView!
    
    @IBOutlet weak var willThereBeRestStopsImageView: UIImageView!
    
    @IBOutlet weak var noFoodAllowedImageView: UIImageView!
    
    
    @IBOutlet weak var animalsAllowedImageView: UIImageView!
    
    var isJoinRideButtonHidden: Bool!
    var isEndRideButtonHidden: Bool!
    
    @IBOutlet weak var cosmosRatingView: CosmosView!
    
    var loadImagedocRef: DocumentReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isJoinRideButtonHidden == true {
            joinRideButton.isHidden = true
        } else {
            joinRideButton.isHidden = false
        }
        if isEndRideButtonHidden == true {
            endRideButton.isHidden = true
        } else {
            endRideButton.isHidden = false
        }
        originLabel.text = selectedRide.origin
        destinationLabel.text = selectedRide.destination
        dateLabel.text = selectedRide.date
        priceLabel.text = selectedRide.price
        availableSeatsLabel.text = "\(selectedRide.availableSeats ?? 0)"
        driverLabel.text = selectedRide.driverName
        baggageSizeLabel.text = selectedRide.baggageSize
        
        //cosmosRatingView.rating = Double(selectedRide.driverRating!)
        
        print(joinRideButton.isHidden)
        checkPreferences()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDriverImage(selectedRide: selectedRide)
        print("driver rating:\(selectedRide.driverRating)")
        //cosmosRatingView.rating = Double(selectedRide.driverRating!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinRideButtonTapped(_ sender: Any) {
        
        delegate?.didJoinRide(ride: selectedRide)
    }
    
    
    @IBAction func endRideButtonTapped(_ sender: Any) {
        delegate?.didEndRide(ride: selectedRide)
    }
    
    
    func checkPreferences() {
        
        if selectedRide.isSmokingAllowed == true {
            isSmokingAllowedImageView.image = #imageLiteral(resourceName: "green")
        } else {
            isSmokingAllowedImageView.image = #imageLiteral(resourceName: "red")
        }
        
        if selectedRide.willThereBeRestStops == true {
            willThereBeRestStopsImageView.image = #imageLiteral(resourceName: "green")
        } else {
            willThereBeRestStopsImageView.image = #imageLiteral(resourceName: "red")
        }
        
        if selectedRide.noFoodAllowed == true {
            noFoodAllowedImageView.image = #imageLiteral(resourceName: "green")
        } else {
            noFoodAllowedImageView.image = #imageLiteral(resourceName: "red")
        }
        
        if selectedRide.animalsAllowed == true {
            animalsAllowedImageView.image = #imageLiteral(resourceName: "green")
        } else {
            animalsAllowedImageView.image = #imageLiteral(resourceName: "red")
        }
    }
    
    func loadDriverImage(selectedRide: RideRecord) {
        loadImagedocRef = Firestore.firestore().collection("users").document(selectedRide.driverUID!)
        loadImagedocRef.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.cosmosRatingView.rating = querySnapshot?.data()!["rating"] as! Double
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
