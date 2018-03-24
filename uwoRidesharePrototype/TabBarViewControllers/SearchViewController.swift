//
//  SearchViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import InstantSearch
import InstantSearchCore

protocol SearchViewControllerDelegate: class {
    //probably change to just passing ride
    func didSelectRide(ride: RideRecord)
    func didSearchForRide(origin: String, destination: String)
}

class SearchViewController: HitsTableViewController {

    @IBOutlet weak var tableView: HitsTableWidget!
    
    var rideArray = [RideRecord]()
    //var filteredRideArray = [Ride]()
    weak var delegate: SearchViewControllerDelegate!
    let searchController = UISearchController(searchResultsController: nil)


    
    override func viewDidLoad() {
        super.viewDidLoad()
    //InstantSearch.shared
    InstantSearch.shared.registerAllWidgets(in: self.view)
        hitsTableView = tableView
        tableView.rowHeight = 129


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print(searchController)
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Rides"
//        searchController.searchBar.tintColor = UIColor.flatWhite
//        if #available(iOS 11.0, *) {
//            print("iOS 11 available")
//            self.tableView.tableHeaderView = self.searchController.searchBar
//        } else {
//            print("iOS 11 not available")
//
//            // Fallback on earlier versions
//        }
        self.tabBarController?.navigationItem.title = "Search"
        self.navigationController?.isNavigationBarHidden = false

        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchTableViewCell
        
        cell.ride = RideRecord(json: hit)
        if let ride = cell.ride {
        rideArray.append(ride)
        }
        return cell
    }
    
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredRideArray.count
//        }
//
//        return rideArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //print("searchvc cell for row hit")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchTableViewCell
//        let ride: Ride
//
//        if rideArray.count > 0 && isFiltering() {
//            ride = filteredRideArray[indexPath.row]
//            cell.destinationLabel.text = ride.destination
//            cell.originLabel.text = ride.origin
//            cell.dateLabel.text = ride.date
//            cell.priceLabel.text = ride.price
//            cell.availableSeatsLabel.text = "\(ride.availableSeats)"
//            //cell.accessibilityHint = ride.driver
//            //cell.accessibilityElements = ride.passengers
//
//        } else if rideArray.count > 0 && !isFiltering() {
//            ride = rideArray[indexPath.row]
//            cell.destinationLabel.text = ride.destination
//            cell.originLabel.text = ride.origin
//            cell.dateLabel.text = ride.date
//            cell.priceLabel.text = ride.price
//            cell.availableSeatsLabel.text = "\(ride.availableSeats)"
//        }
//
//
//
//
//
//
//        return cell
//    }
//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, containing hit: [String : Any]) {
        let ride = rideArray[indexPath[1]]
        delegate?.didSelectRide(ride: ride)
        
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    //let ride = rideArray[indexPath[1]]
//
//        //delegate?.didSelectRide(ride: ride)
//    }

//    func searchBarIsEmpty() -> Bool {
//        // Returns true if the text is empty or nil
//        return searchController.searchBar.text?.isEmpty ?? true
//
//    }
//
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredRideArray = rideArray.filter({( ride : Ride) -> Bool in
//            return ride.destination.lowercased().contains(searchText.lowercased())
//            // make this a lot better
//
//        })
//
//        tableView.reloadData()
//    }
//
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }


}

//extension SearchViewController: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//}

