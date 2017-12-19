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
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didDismissTerms(didAccept: self.didAcceptTerms)

    }
    
    @IBAction func didDeclineTerms(_ sender: Any) {
        didAcceptTerms = false
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didDismissTerms(didAccept: self.didAcceptTerms)
    }
    
    
    
    
}
