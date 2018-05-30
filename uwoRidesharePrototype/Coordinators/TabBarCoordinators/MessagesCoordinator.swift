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
    var childCoordinators = [NSObject]()

    
    weak var delegate: MessagesCoordinatorDelegate?
    var messagesViewController: MessagesViewController!
    var channel: Channel!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        messagesViewController = navigationController?.visibleViewController?.childViewControllers[3] as!MessagesViewController
        messagesViewController.delegate = self as MessagesViewControllerDelegate
    }
    

    
    func goToChatCoordinator(channel: Channel) {
        let chatCoordinator = ChatCoordinator(navigationController: navigationController!)
        chatCoordinator.delegate = self as? ChatCoordinatorDelegate
        chatCoordinator.selectedChannel = channel
        chatCoordinator.start()
        //chatCoordinator.imageTestStart()
        childCoordinators.append(chatCoordinator)
    }
}

extension MessagesCoordinator: MessagesViewControllerDelegate {
    func didSelectChannel(channel: Channel) {
        goToChatCoordinator(channel: channel)
        
    }
    
    
}
