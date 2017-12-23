//
//  TermsCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol TermsCoordinatorDelegate: class {
   func didAcceptTerms()
}

class TermsCoordinator: NSObject, TermsViewControllerDelegate {
    
    
    var navigationController: UINavigationController?
    var delegate: TermsCoordinatorDelegate?
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let authStoryboard = UIStoryboard.init(name: "Terms", bundle: nil)
        let termsVC = authStoryboard.instantiateViewController(withIdentifier: "terms") as! TermsViewController
        termsVC.delegate = self
        navigationController?.pushViewController(termsVC, animated: true)
        //launchVC.present(termsVC, animated: true, completion: nil)
    }
    
    func didDismissTerms(didAccept: Bool) {
        if didAccept == true {
            print("termsAccepted")
            navigationController?.popViewController(animated: true)
            self.delegate?.didAcceptTerms()
 
        } else {
            fatalError()
        }
    }

    
}
