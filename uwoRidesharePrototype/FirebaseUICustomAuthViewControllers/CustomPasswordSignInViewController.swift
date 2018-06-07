//
//  CustomPasswordSignInViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-06-07.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//


import Foundation
import UIKit
import FirebaseUI


class CustomPasswordSignInViewController: FUIPasswordSignInViewController  {


    
    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth, email: String?) {
        print("bundle:\(bundle)")
        super.init(nibName: "FUIPasswordSignInViewController", bundle: bundle, authUI: authUI, email: email)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = view.subviews[0]
        
        tableView.backgroundColor = UIColor.flatPurpleDark
        
        
        
        
    }



}
