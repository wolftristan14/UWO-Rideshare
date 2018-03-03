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
    func didSelectRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driver: String, passengers: [String], createdOn: Date)
}


class YourRidesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var rideArray = [Ride]()
    
    weak var delegate: YourRidesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 129

    }
    
    override func viewWillAppear(_ animated: Bool) {

    self.tabBarController?.navigationItem.title = "Your Rides"
    self.tableView.isEditing = false
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("your rides vc number of rows hit")
        return rideArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("your rides vc cell for row method hit")

        let cell = tableView.dequeueReusableCell(withIdentifier: "yourrides", for: indexPath) as! YourRidesTableViewCell
        
        if rideArray.count > 0 {
        let ride = rideArray[indexPath.row]
        cell.destinationLabel.text = ride.destination
        cell.originLabel.text = ride.origin
        cell.dateLabel.text = ride.date
        cell.priceLabel.text = ride.price
        cell.availableSeatsLabel.text = "\(ride.availableSeats)"
        cell.accessibilityHint = ride.driver
        cell.accessibilityElements = ride.passengers
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let currentCell = tableView.cellForRow(at: indexPath) as! YourRidesTableViewCell
//        print(indexPath)
//        print(indexPath.count)
//        let availableSeats = Int(currentCell.availableSeatsLabel.text!)

 
//        delegate?.didSelectRide( origin: currentCell.originLabel.text ?? "", destination: currentCell.destinationLabel.text ?? "", date: currentCell.dateLabel.text ?? "", price: currentCell.priceLabel.text ?? "", availableSeats: availableSeats ?? 0, driver: currentCell.accessibilityHint!, passengers: currentCell.accessibilityElements as! [String], createdOn: Date.init()) // change this when youre passing the date
        
        let ride = rideArray[indexPath[1]]
        
        delegate?.didSelectRide(docid: ride.docid, origin: ride.origin, destination: ride.destination, date: ride.date, price: ride.price, availableSeats: ride.availableSeats, driver: ride.driver, passengers: ride.passengers, createdOn: ride.createdOn)
        

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Created"
        
    }

    @IBAction func addRideButtonTapped(_ sender: Any) {
        self.delegate?.didTapAddRideButton()
    }
    
    
}
