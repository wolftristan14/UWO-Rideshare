//
//  ChatCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-05-17.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol ChatCoordinatorDelegate: class {
    
}


class ChatCoordinator: NSObject {
    
    var navigationController: UINavigationController!
    var selectedChannel: Channel!
    
    weak var delegate: ChatCoordinatorDelegate?

    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let chatVC = storyboard.instantiateViewController(withIdentifier: "chat")
        //chatVC.delegate = self as? ChatViewControllerDelegate
        //chatVC.selectedChannel = selectedChannel
        navigationController.pushViewController(chatVC, animated: true)
        
        
        
    }
    
}
