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
    func didSelectRide(ride: Ride)
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var rideArray = [Ride]()
    var filteredRideArray = [Ride]()
    weak var delegate: SearchViewControllerDelegate!
    let searchController = UISearchController(searchResultsController: nil)


    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Rides"
//        searchController.searchBar.tintColor = UIColor.flatWhite
//        if #available(iOS 11.0, *) {
//        print("iOS 11 available")
//
//        self.tabBarController?.navigationItem.searchController = searchController
//        } else {
//            print("iOS 11 not available")
//
//            // Fallback on earlier versions
//        }
//        self.tabBarController?.definesPresentationContext = true
        tableView.rowHeight = 129
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Rides"
        searchController.searchBar.tintColor = UIColor.flatWhite
        if #available(iOS 11.0, *) {
            print("iOS 11 available")
            
            self.tabBarController?.navigationItem.searchController = searchController
        } else {
            print("iOS 11 not available")
            
            // Fallback on earlier versions
        }
        self.tabBarController?.definesPresentationContext = true
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
        
        delegate?.didSelectRide(ride: ride)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
        
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRideArray = rideArray.filter({( ride : Ride) -> Bool in
            return ride.destination.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }


}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

