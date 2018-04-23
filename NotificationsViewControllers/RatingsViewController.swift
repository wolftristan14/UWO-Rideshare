//
//  RatingsViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-23.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController {
    
    var notification: [String:AnyObject]!

    @IBOutlet weak var notificationTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notificationTextView.text = "\(notification ?? [:])"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
