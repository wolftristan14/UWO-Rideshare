//
//  SearchViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import AlgoliaSearch
import AFNetworking
import InstantSearchCore
import Firebase

protocol SearchViewControllerDelegate: class {
    //probably change to just passing ride
    func didSelectRide(ride: RideRecord)
    func didSearchForRide(origin: String, destination: String)
    func isSearchBarActive(answer: Bool)
}

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, SearchProgressDelegate {


    

    @IBOutlet weak var tableView: UITableView!
    
    var rideArray = [RideRecord]()
    var resultsArray = [JSONObject]()
    var filteredRideArray = [JSONObject]()
    weak var delegate: SearchViewControllerDelegate!
    var searchController = UISearchController(searchResultsController: nil)
    var searchProgressController: SearchProgressController!


    var rideIndex: Index!
    var rideSearcher: Searcher!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiClient = Client(appID: "NB1PXG4WJM", apiKey: "6132710f15ba25f5b14971533c42c209")
        rideIndex = apiClient.index(withName: "Rides")
        rideSearcher = Searcher(index: rideIndex, resultHandler: self.handleSearchResults)
        rideSearcher.params.hitsPerPage = 15
        rideSearcher.params.attributesToRetrieve = ["docid", "origin", "destination", "date", "price", "availableSeats", "passengers", "driverEmail", "driverName", "createdOn"]
        rideSearcher.params.attributesToHighlight = ["origin", "destination"]
        
        //searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = NSLocalizedString("search rides", comment: "")
        
        // Add the search bar
        tableView.tableHeaderView = self.searchController.searchBar
        searchController.definesPresentationContext = true
        
        searchController.searchBar.sizeToFit()
        
        // Configure search progress monitoring.
        searchProgressController = SearchProgressController(searcher: rideSearcher)
        searchProgressController.delegate = self
        
        updateSearchResults(for: searchController)

        tableView.rowHeight = 129


        // Do any additional setup after loading the view.
    }
    
    func handleSearchResults(results: SearchResults?, error: Error?, userInfo: [String: Any]) {
        guard let results = results else { return }
        if results.page == 0 {
            resultsArray = results.hits
        } else {
            resultsArray.append(contentsOf: results.hits)
        }
        //print(resultsArray.count)
        //print(resultsArray[2]["driverEmail"] as! String)
       // print(Auth.auth().currentUser?.email as! String)
        let displayName = Auth.auth().currentUser?.displayName ?? ""
        var filteredResultsArray = resultsArray.filter { $0["driverEmail"] as! String != displayName}
        
        var counter = 0
        

        for result in filteredResultsArray {
            let passengersDictionary = result["passengers"] as! [String:String]
            if passengersDictionary[displayName] == displayName {
                filteredResultsArray.remove(at: counter)
                counter += 1
            } else {
                counter += 1
            }

        }
        
        rideArray.removeAll()
        for object in filteredResultsArray {
            let ride = RideRecord(json: object)
            rideArray.append(ride)
            self.tableView.reloadData()
        }

        print(filteredResultsArray.count)
        
        //originIsLocal = results.content["origin"] as? String == "local"
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        rideSearcher.params.query = searchController.searchBar.text
        rideSearcher.search()
    }
    
    func searchDidStart(_ searchProgressController: SearchProgressController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func searchDidStop(_ searchProgressController: SearchProgressController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchController.searchBar.isHidden = false
        self.tabBarController?.navigationItem.title = "Search"
        self.navigationController?.isNavigationBarHidden = false

        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        self.searchController.searchBar.isHidden = true
        //self.delegate.isSearchBarActive(answer: self.searchController.isActive)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ride = rideArray[indexPath[1]]
        delegate?.didSelectRide(ride: ride)

    }
    

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return rideArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(rideArray)
        let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath) as! SearchTableViewCell
        let ride: RideRecord

        if rideArray.count > 0 {
            ride = rideArray[indexPath.row]
            let availableSeats = ride.availableSeats!
            cell.destinationLabel.text = ride.destination
            cell.originLabel.text = ride.origin
            cell.dateLabel.text = ride.date
            cell.priceLabel.text = ride.price
            cell.availableSeatsLabel.text = String(describing: availableSeats)
            //cell.accessibilityElements = ride.passengers
//
        //        } else if rideArray.count > 0 {
//            ride = rideArray[indexPath.row]
//            cell.destinationLabel.text = ride.destination
//            cell.originLabel.text = ride.origin
//            cell.dateLabel.text = ride.date
//            cell.priceLabel.text = ride.price
//            cell.availableSeatsLabel.text = "\(ride.availableSeats)"
        }
//
//
//
//
//
//
        return cell
    }



}



