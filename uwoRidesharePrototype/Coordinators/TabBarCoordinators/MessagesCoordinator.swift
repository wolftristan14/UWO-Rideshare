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
    var loadChannelsQuery: Query!
    var channel: Channel!
    var channelArray = [Channel]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        messagesViewController = navigationController?.visibleViewController?.childViewControllers[3] as!MessagesViewController
        messagesViewController.delegate = self as? MessagesViewControllerDelegate
        loadChannelsFromFirebase()
    }
    
    func loadChannelsFromFirebase() {
        
        
        let userUID = Auth.auth().currentUser?.uid ?? ""
        loadChannelsQuery = Firestore.firestore().collection("Channels").whereField("members.\(userUID)", isEqualTo: true)
        
        loadChannelsQuery.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("total document count:\(querySnapshot?.documents.count)")
                for document in querySnapshot!.documents {
                //print("\(document.documentID) => \(document.data())")
                let data = document.data()
                print(data.keys)
                print(data.count)
                if data.count > 0 {
                    self.channel  = Channel(name: document.data()["name"] as! String, members: document.data()["members"] as! [String: Bool], rideid: document.data()["rideid"] as! String, channelid: document.documentID)
                    
                    self.channelArray.append(self.channel)
                    //print("added ride")
                    self.messagesViewController.channelArray = self.channelArray
                    self.messagesViewController.tableView.reloadData()
                   
            
                }
                 }
            }
        }
    }
    
    func goToChatCoordinator(channel: Channel) {
        let chatCoordinator = ChatCoordinator(navigationController: navigationController!)
        chatCoordinator.delegate = self as? ChatCoordinatorDelegate
        chatCoordinator.selectedChannel = channel
        chatCoordinator.start()
        childCoordinators.append(chatCoordinator)
    }
}

extension MessagesCoordinator: MessagesViewControllerDelegate {
    func didSelectChannel(channel: Channel) {
        goToChatCoordinator(channel: channel)
        
    }
    
    
}
