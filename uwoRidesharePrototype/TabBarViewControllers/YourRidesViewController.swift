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
    func didSelectRide(origin: String, destination: String, date: String, price: String, availableSeats: Int, driver: String, passengers: [String])
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
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        let currentCell = tableView.cellForRow(at: indexPath) as! YourRidesTableViewCell
        let availableSeats = Int(currentCell.availableSeatsLabel.text!)

        
        
        delegate?.didSelectRide(origin: currentCell.originLabel.text ?? "", destination: currentCell.destinationLabel.text ?? "", date: currentCell.dateLabel.text ?? "", price: currentCell.priceLabel.text ?? "", availableSeats: availableSeats ?? 0, driver: currentCell.accessibilityHint!, passengers: currentCell.accessibilityElements as! [String])
    }

    @IBAction func addRideButtonTapped(_ sender: Any) {
        self.delegate?.didTapAddRideButton()
    }
    
    
}
