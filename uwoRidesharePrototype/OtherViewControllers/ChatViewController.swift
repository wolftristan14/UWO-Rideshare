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
        self.inputBarView.textInputAreaView.subviews[1].isHidden = true
         messagesCollRef = Firestore.firestore().collection("Channels").document(selectedChannel.channelid ?? "").collection("Messages")
        messageCounter = 0
        getMessagesFromFirebase()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func sendText(_ text: String, isIncomingMessage:Bool) -> GeneralMessengerCell {
        writeMessageToFirebase(text: text)
        return self.postText(text,isIncomingMessage: isIncomingMessage)
    }
    
//    override func sendImage(_ image: UIImage, isIncomingMessage: Bool) -> GeneralMessengerCell {
//        //writeImageToFirebase()
//    }
    
    func writeMessageToFirebase(text: String) {

        
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
        
        
    }
    
    func getMessagesFromFirebase() {
        messagesCollRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in (querySnapshot?.documents)! {
                    
                    let message = Message(text: document.data()["text"] as! String, senderid: document.data()["senderid"] as! String)
                    
                    
                    if message.senderid == Auth.auth().currentUser?.uid {
                    self.postText(message.text, isIncomingMessage: false)
                    } else if message.senderid != Auth.auth().currentUser?.uid {
                    self.postText(message.text, isIncomingMessage: true)

                    }
                    
                    self.messageCounter! += 1
                }
            }
        }
    }
    
    
    
}
