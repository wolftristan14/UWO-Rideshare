//
//  MessagesCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-22.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol MessagesCoordinatorDelegate: class {
    
}

class MessagesCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    //var childCoordinators = [NSObject]()

    
    weak var delegate: MessagesCoordinatorDelegate?
    //var docRef: DocumentReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        
    }
    
}
