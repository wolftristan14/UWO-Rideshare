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
import NMessenger

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
        let chatVC = storyboard.instantiateViewController(withIdentifier: "chat") as! ChatViewController
        chatVC.delegate = self as? ChatViewControllerDelegate
        chatVC.selectedChannel = selectedChannel
        chatVC.senderUID = Auth.auth().currentUser?.uid ?? ""
        chatVC.senderName = Auth.auth().currentUser?.displayName ?? ""
        navigationController.pushViewController(chatVC, animated: true)
        
        
        
        
    }
    
    func imageTestStart() {
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let imageTestVC = storyboard.instantiateViewController(withIdentifier: "imagetest") as! ImageTestViewController

        navigationController.pushViewController(imageTestVC, animated: true)
        
    }
    
    
}
