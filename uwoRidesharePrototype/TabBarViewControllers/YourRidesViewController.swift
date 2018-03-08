//
//  YourRidesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

protocol YourRidesViewControllerDelegate: class {
    func didTapAddRideButton()
    
    //probably change to just passing ride
    func didSelectRide(ride: Ride)
}


class YourRidesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postedRideArray = [Ride]()
    var joinedRidesArray = [Ride]()
    
    weak var delegate: YourRidesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 129

    }
    
    override func viewWillAppear(_ animated: Bool) {

    self.tabBarController?.navigationItem.title = "Your Rides"
    self.tableView.isEditing = false
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("your rides vc number of rows hit")
        if section == 0 {
        return postedRideArray.count
        } else {
        return joinedRidesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("your rides vc cell for row method hit")

        let cell = tableView.dequeueReusableCell(withIdentifier: "yourrides", for: indexPath) as! YourRidesTableViewCell
        
        
        if postedRideArray.count > 0 && indexPath[0] == 0 {
        let ride = postedRideArray[indexPath.row]
        cell.destinationLabel.text = ride.destination
        cell.originLabel.text = ride.origin
        cell.dateLabel.text = ride.date
        cell.priceLabel.text = ride.price
        cell.availableSeatsLabel.text = "\(ride.availableSeats)"
            return cell

        } else if joinedRidesArray.count > 0 && indexPath[0] == 1 {
            let ride = joinedRidesArray[indexPath.row]
            cell.destinationLabel.text = ride.destination
            cell.originLabel.text = ride.origin
            cell.dateLabel.text = ride.date
            cell.priceLabel.text = ride.price
            cell.availableSeatsLabel.text = "\(ride.availableSeats)"
            return cell

        } else {
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath[0] == 0 {
        let ride = postedRideArray[indexPath[1]]
        delegate?.didSelectRide(ride: ride)
        } else {
            let ride = joinedRidesArray[indexPath[1]]
            delegate?.didSelectRide(ride: ride)
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
    
    
}
