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
        view.backgroundColor = UIColor.flatPurpleDark
        self.navigationItem.leftBarButtonItem = nil
        //self.title = "UWORideshare"

        
        
        // Get the superview's layout
        let margins = view.layoutMarginsGuide
        //let myView = UIButton()
        let termsAndConditionsPrivatePolicyTextView = UITextView.init(frame: CGRect.init(x: 0, y: 50, width: view.frame.width, height: 40))
        let attributedString = NSMutableAttributedString(string: "By signing up you are agreeing to the Terms & Conditions and Private Policy")

        attributedString.addAttribute(.link, value: "https://wolftristan14.github.io/UWORidesharePrivatePolicy", range: NSRange(location: 61, length: 14))
        attributedString.addAttribute(.link, value: "https://wolftristan14.github.io/UWORideshareTermsAndConditions", range: NSRange(location: 38, length: 19))
        termsAndConditionsPrivatePolicyTextView.attributedText = attributedString
        termsAndConditionsPrivatePolicyTextView.textColor = UIColor.flatWhiteDark
        
        termsAndConditionsPrivatePolicyTextView.font = UIFont(name: "TimesNewRoman", size: 14)
        termsAndConditionsPrivatePolicyTextView.isEditable = false
        termsAndConditionsPrivatePolicyTextView.backgroundColor = view.backgroundColor
        view.addSubview(termsAndConditionsPrivatePolicyTextView)
        termsAndConditionsPrivatePolicyTextView.translatesAutoresizingMaskIntoConstraints = false
        termsAndConditionsPrivatePolicyTextView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        termsAndConditionsPrivatePolicyTextView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
       // myView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true

        termsAndConditionsPrivatePolicyTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        termsAndConditionsPrivatePolicyTextView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "car-25-256"))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        
        let titleLabel = UILabel.init()
        titleLabel.text = "UWORideshare"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.flatWhite
        //titleLabel.font = UIFont(name: "TimesNewRoman", size: 72)
        
        view.addSubview(titleLabel)
        //titleLabel.font = UIFont(name: "TimesNewRoman", size: 72.0)
        titleLabel.font = titleLabel.font.withSize(36)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        
        

        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationItem.title = "UWORideshare"
        self.title = "UWORideshare"
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.flatPurpleDark
        self.navigationItem.titleView?.backgroundColor = UIColor.flatPurpleDark
    }
    

    
    
}

