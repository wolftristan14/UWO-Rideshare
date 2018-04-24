//
//  RatingsCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-23.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol RatingsCoordinatorDelegate: class {
    func didFinishUpdatingDriverRating()
}

class RatingsCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    var driverid: String!
    var updateDriverRatingDocRef: DocumentReference!
    
    
    weak var delegate: RatingsCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let ratingStoryboard = UIStoryboard.init(name: "Ratings", bundle: nil)
        let ratingsVC = ratingStoryboard.instantiateViewController(withIdentifier: "ratings") as! RatingsViewController
        ratingsVC.delegate = self
        ratingsVC.driverid = driverid
        navigationController?.pushViewController(ratingsVC, animated: true)

    }
    
    func updateDriverRating(rating: Double, driverid: String) {
        updateDriverRatingDocRef = Firestore.firestore().collection("users").document(driverid)
        updateDriverRatingDocRef.updateData(["rating": rating]) {(error) in
            if let err = error {
                print("Error getting documents: \(err)")
            }
            
        }
        delegate?.didFinishUpdatingDriverRating()
    }
    
    func updateRating(rating: Double, driverid: String) {
                updateDriverRatingDocRef = Firestore.firestore().collection("users").document(driverid)
        
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            do {
                let userDocument = try transaction.getDocument(self.updateDriverRatingDocRef).data()
                guard var userData = userDocument else { return nil }
                self.delegate?.didFinishUpdatingDriverRating()
                // Compute new number of ratings
                let numRatings = userData["numRatings"] as! Int
                let newNumRatings = numRatings + 1
                
                // Compute new average rating
                let avgRating = userData["rating"] as! Double
                let oldRatingTotal = avgRating * Double(numRatings)
                let newAvgRating = (oldRatingTotal + rating) / Double(newNumRatings)
                
                // Set new info
                userData["numRatings"] = newNumRatings
                userData["rating"] = newAvgRating
                
                // Commit to Firestore
                transaction.setData(userData, forDocument: self.updateDriverRatingDocRef)
            } catch {
                // Error getting restaurant data
                // ...
            }
            
            return nil
        }) { (object, err) in
            // ...
        }
        //self.delegate?.didFinishUpdatingDriverRating()

    }
    
}

extension RatingsCoordinator: RatingsViewControllerDelegate {
    
    func didDismissRatingsViewController(rating: Double, driverid: String) {
        updateRating(rating: rating, driverid: driverid)
        //updateDriverRating(rating: rating, driverid: driverid)
    }
}
