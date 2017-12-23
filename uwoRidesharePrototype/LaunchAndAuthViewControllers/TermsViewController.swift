//
//  TermsViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-19.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol TermsViewControllerDelegate {
    func didDismissTerms(didAccept: Bool)
}

class TermsViewController: UIViewController {
    
    var didAcceptTerms: Bool!
    var delegate: TermsViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didAcceptTerms(_ sender: Any) {
        didAcceptTerms = true
        self.delegate?.didDismissTerms(didAccept: self.didAcceptTerms)

    }
    
    @IBAction func didDeclineTerms(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "You must accept the terms.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    
}
