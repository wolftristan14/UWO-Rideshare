//
//  UIViewControllerDismissKeyboardExtension.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-11.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//
import Foundation
import UIKit

extension UIViewController
    
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
