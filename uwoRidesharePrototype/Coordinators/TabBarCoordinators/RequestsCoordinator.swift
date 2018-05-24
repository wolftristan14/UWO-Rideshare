//
//  RequestsCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-03.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol RequestsCoordinatorDelegate: class {
    
}

class RequestsCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var requestsViewController: RequestsViewController!
    var childCoordinators = [NSObject]()

    
    
    weak var delegate: RequestsCoordinatorDelegate?
    
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        requestsViewController = navigationController?.visibleViewController?.childViewControllers[4] as! RequestsViewController
        requestsViewController.delegate = self
        
    }
    
    
    func showRequestDetail(request: RideRequest, didUseRequestsArray: Bool) {
        print("request: \(request.requesterid)")
    let requestDetailCoordinator = RequestDetailCoordinator(navigationController: navigationController!)
    requestDetailCoordinator.selectedRequest = request
    requestDetailCoordinator.didUseRequestsArray = didUseRequestsArray
    requestDetailCoordinator.delegate = self as? RequestDetailCoordinatorDelegate
    requestDetailCoordinator.start()
    childCoordinators.append(requestDetailCoordinator)
    }
}

extension RequestsCoordinator: RequestsViewControllerDelegate {
    
    func didSelectRequest(request: RideRequest, didUseRequestsArray: Bool) {
        showRequestDetail(request: request, didUseRequestsArray: didUseRequestsArray)
    }
    
}

