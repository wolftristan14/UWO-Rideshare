//
//  RideDetailViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-02-02.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase

protocol RideDetailViewControllerDelegate: class {
    func didJoinRide(ride: RideRecord)
}

class RideDetailViewController: UIViewController {
    @IBOutlet weak var joinRideButton: UIButton!
    
    var selectedRide: RideRecord!
    
    weak var delegate: RideDetailViewControllerDelegate?
    
    @IBOutlet weak var imageView: ProfileImageStyleManager!
    
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var availableSeatsLabel: UILabel!
    
    @IBOutlet weak var driverLabel: UILabel!
    
    var isJoinRideButtonHidden: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isJoinRideButtonHidden == true {
            joinRideButton.isHidden = true
        }
        //imageView.image = #imageLiteral(resourceName: "default-user")
        originLabel.text = selectedRide.origin
        destinationLabel.text = selectedRide.destination
        dateLabel.text = selectedRide.date
        priceLabel.text = selectedRide.price
        availableSeatsLabel.text = "\(selectedRide.availableSeats ?? 0)"
        driverLabel.text = selectedRide.driverName
        print(joinRideButton.isHidden)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinRideButtonTapped(_ sender: Any) {
        
        delegate?.didJoinRide(ride: selectedRide)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
