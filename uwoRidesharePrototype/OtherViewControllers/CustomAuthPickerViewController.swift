//
//  CustomAuthPickerViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-13.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

class CustomAuthPickerViewController: FUIAuthPickerViewController {
    
    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth) {
        print("bundle:\(bundle)")
        super.init(nibName: "FUIAuthPickerViewController", bundle: bundle, authUI: authUI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.flatPurpleDark
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationController?.navigationBar.backgroundColor = 
        // Get the superview's layout
        let margins = view.layoutMarginsGuide
        //let myView = UIButton()
        let myView = UITextView.init(frame: CGRect.init(x: 0, y: 50, width: view.frame.width, height: 40))
        let attributedString = NSMutableAttributedString(string: "By signing up you are agreeing to the Terms & Conditions and Private Policy")

        attributedString.addAttribute(.link, value: "https://wolftristan14.github.io/UWORidesharePrivatePolicy", range: NSRange(location: 61, length: 14))
        attributedString.addAttribute(.link, value: "https://wolftristan14.github.io/UWORideshareTermsAndConditions", range: NSRange(location: 38, length: 19))
        myView.attributedText = attributedString
        myView.textColor = UIColor.flatWhiteDark
        
        myView.font = UIFont(name: "TimesNewRoman", size: 14)
        myView.isEditable = false
        myView.backgroundColor = view.backgroundColor
        view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
       // myView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true

        myView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        //myView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        

        
        
        
        
        
        
    }
}

