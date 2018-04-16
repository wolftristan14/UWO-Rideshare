//
//  AddRidePreferencesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-06.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol AddRidePreferencesViewControllerDelegate: class {
    func didAddRide(ride: Ride)
}


class AddRidePreferencesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var smokingAllowedButton: UIButton!
    
    @IBOutlet weak var takingReststopsButton: UIButton!
    
    @IBOutlet weak var noFoodAllowedButton: UIButton!
    
    @IBOutlet weak var animalsAllowedButton: UIButton!
    
    @IBOutlet weak var baggageSizePickerView: UIPickerView!
    
    weak var delegate: AddRidePreferencesViewControllerDelegate?
    var baggageSizesArray = ["Small", "Medium", "Large"]
    var ride: Ride?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func smokingAllowedButtonSelected(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            print("sender selected")
            sender.setImage(#imageLiteral(resourceName: "uncheked box"), for: .normal)

        } else {
            print("sender not selected")
            sender.isSelected = true
            sender.setImage(#imageLiteral(resourceName: "checked box"), for: .normal)

        }
    }
    
    @IBAction func takingRestStopsButtonSelected(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(#imageLiteral(resourceName: "uncheked box"), for: .normal)

        } else {
            sender.isSelected = true

            sender.setImage(#imageLiteral(resourceName: "checked box"), for: .normal)

        }
    }
    
    @IBAction func noFoodAllowedButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(#imageLiteral(resourceName: "uncheked box"), for: .normal)


        } else {
            sender.isSelected = true

            sender.setImage(#imageLiteral(resourceName: "checked box"), for: .normal)

        }
    }
    
    @IBAction func animalsAllowedButtonPressed(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false

            sender.setImage(#imageLiteral(resourceName: "uncheked box"), for: .normal)
        } else {
            sender.isSelected = true

            sender.setImage(#imageLiteral(resourceName: "checked box"), for: .normal)
        }
    }
    
    
    @IBAction func continueAddRideProcess(_ sender: Any) {
        let baggageSizePickerViewRow = baggageSizePickerView.selectedRow(inComponent: 0)
        ride?.baggageSize = baggageSizesArray[baggageSizePickerViewRow]
        ride?.animalsAllowed = animalsAllowedButton.isSelected
        ride?.willThereBeRestStops = takingReststopsButton.isSelected
        ride?.noFoodAllowed = noFoodAllowedButton.isSelected
        ride?.isSmokingAllowed = smokingAllowedButton.isSelected
        
        delegate?.didAddRide(ride: ride!)
    }
    

    
    // MARK: pickerview delegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("hit")
        return baggageSizesArray.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("hit")
    return baggageSizesArray[row]
    
}
}
