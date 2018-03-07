//
//  SearchViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    //probably change to just passing ride
    func didSelectRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, passengers: [String], createdOn: Date)
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var rideArray = [Ride]()
    weak var delegate: SearchViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 129
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "Search"
        self.navigationController?.isNavigationBarHidden = false

        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("search vc rows in section hit")
        return rideArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("searchvc cell for row hit")
        let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchTableViewCell
        
        if rideArray.count > 0 {
            let ride = rideArray[indexPath.row]
            cell.destinationLabel.text = ride.destination
            cell.originLabel.text = ride.origin
            cell.dateLabel.text = ride.date
            cell.priceLabel.text = ride.price
            cell.availableSeatsLabel.text = "\(ride.availableSeats)"
            //cell.accessibilityHint = ride.driver
            //cell.accessibilityElements = ride.passengers

        }
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let ride = rideArray[indexPath[1]]
        
        delegate?.didSelectRide(docid: ride.docid, origin: ride.origin, destination: ride.destination, date: ride.date, price: ride.price, availableSeats: ride.availableSeats, driverEmail: ride.driverEmail, driverName: ride.driverName, passengers: ride.passengers, createdOn: ride.createdOn)
    }
    


}
