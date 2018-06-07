//
//  CustomPasswordRecoveryViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-06-07.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit
import FirebaseUI

class CustomPasswordRecoveryViewController: FUIPasswordRecoveryViewController {

    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth, email: String?) {
        print("bundle:\(bundle)")
        super.init(nibName: "FUIPasswordRecoveryViewController", bundle: bundle, authUI: authUI, email: email)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = view.subviews[0]
        
        tableView.backgroundColor = UIColor.flatPurpleDark
        
        
        
        
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
