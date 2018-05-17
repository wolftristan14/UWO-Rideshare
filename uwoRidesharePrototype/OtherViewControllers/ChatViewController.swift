//
//  ChatViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-05-17.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase
import NMessenger

protocol ChatViewControllerDelegate: class {
    
}

class ChatViewController: NMessengerViewController {
    
    weak var delegate: ChatViewControllerDelegate?
    var selectedChannel: Channel!
    var senderUID: String!
    var messagesCollRef: CollectionReference!
    
    var messageCounter: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageCounter = self.messengerView.allMessages().count
        
        // Do any additional setup after loading the view.
    }
    
    override func sendText(_ text: String, isIncomingMessage:Bool) -> GeneralMessengerCell {
        writeMessageToFirebase(text: text)
        return self.postText(text,isIncomingMessage: isIncomingMessage)
    }
    
    func writeMessageToFirebase(text: String) {
        messagesCollRef = Firestore.firestore().collection("Channels").document(selectedChannel.channelid ?? "").collection("Messages")
        
        
        messagesCollRef.document("message\(messageCounter!)").setData(["text": text, "senderid": senderUID]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                
                self.messageCounter! += 1
                //self.navigationController?.popViewController(animated: true)
                //self.navigationController?.popToRootViewController(animated: true)
                //self.delegate?.didWriteRideToFirebase()
                
            }
            
        }
        
        //        messagesCollRef.document("message\(messageCounter)").setData(data: ["text": text, "senderid": senderUID]) { err in
        //            if let err = err {
        //                print("Error adding document: \(err)")
        //            } else {
        //
        //                self.messageCounter! += 1
        //                //self.navigationController?.popViewController(animated: true)
        //                //self.navigationController?.popToRootViewController(animated: true)
        //                //self.delegate?.didWriteRideToFirebase()
        //
        //            }
        //
        //        }
        
        
        
        
        
        
        
    }
    
    
    
}
