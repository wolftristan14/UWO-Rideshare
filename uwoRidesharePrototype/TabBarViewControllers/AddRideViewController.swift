//
//  AddRideViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-19.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol AddRideViewControllerDelegate: class {
    func didAddRide(origin: String, destination: String, date: String, price: String, availableSeats: String)
}

class AddRideViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var goingToTextField: UITextField!
    
    @IBOutlet weak var fromTextField: UITextField!
    
    
    @IBOutlet weak var dateAndTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var pricePickerView: UIPickerView!
    
    @IBOutlet weak var numberOfSeatsPickerView: UIPickerView!
    
    let pricePickerData = ["Free","$2.50","$5.00","$7.50","$10.00","$15.00", "$20.00"]
    let numberOfSeatsPickerData = ["1","2","3","4","5","6","7","8"]
    
    weak var delegate: AddRideViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    @IBAction func addRideButtonTapped(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: dateAndTimeDatePicker.date)
        let pricePickerViewRow = pricePickerView.selectedRow(inComponent: 0)
        let numberOfSeatsPickerViewRow = numberOfSeatsPickerView.selectedRow(inComponent: 0)

        delegate?.didAddRide(origin: fromTextField.text ?? "", destination: goingToTextField.text ?? "", date: dateString, price: pricePickerData[pricePickerViewRow] ?? "", availableSeats: numberOfSeatsPickerData[numberOfSeatsPickerViewRow] ?? "")
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // make data then get count
        if (pickerView.tag == 1){
            return pricePickerData.count
        }else{
            return numberOfSeatsPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // add 1 tag to pricepickerview
        if (pickerView.tag == 1){
            return "\(pricePickerData[row])"
        }else{
            return "\(numberOfSeatsPickerData[row])"
        }
    }
    
}
