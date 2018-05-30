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
    var senderName: String!
    var messagesCollRef: CollectionReference!
    
    var image: UIImage!
    
    
    var messageCounter: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.messengerView.messengerNode
        self.inputBarView.textInputAreaView.subviews[1].isHidden = true
         messagesCollRef = Firestore.firestore().collection("Channels").document(selectedChannel.channelid ?? "").collection("Messages")
        messageCounter = 0
        getMessagesFromFirebase()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func sendText(_ text: String, isIncomingMessage:Bool, avatarImage: UIImage?) -> GeneralMessengerCell {
        writeMessageToFirebase(text: text)
        let startOfName = senderName.prefix(2)
        //let newImage = self.generateImageWithText(text: String(senderNamePrefix))
        let newImage = self.textToImage(drawText: String(startOfName))

        return self.postText(text,isIncomingMessage: isIncomingMessage, avatarImage: newImage)
    }
    
    
    
//    override func sendImage(_ image: UIImage, isIncomingMessage: Bool) -> GeneralMessengerCell {
//        //writeImageToFirebase()
//    }
    
    func writeMessageToFirebase(text: String) {

        
        messagesCollRef.document("message\(messageCounter!)").setData(["text": text, "senderid": senderUID, "senderName": senderName]) { err in
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
                    
                    let message = Message(text: document.data()["text"] as! String, senderid: document.data()["senderid"] as! String, senderName: document.data()["senderName"] as! String)
                    
                    
                    
                    if message.senderid == Auth.auth().currentUser?.uid {
                        let startOfName = message.senderName.prefix(2)
                        let newImage = self.textToImage(drawText: String(startOfName))
                        //let newImage = self.generateImageWithText(text: String(startOfName))
                        self.postText(message.text, isIncomingMessage: false, avatarImage: newImage)
                    } else if message.senderid != Auth.auth().currentUser?.uid {
                        let startOfName = message.senderName.prefix(2)
                        let newImage = self.textToImage(drawText: String(startOfName))
                        //let newImage = self.generateImageWithText(text: String(startOfName))
                        self.postText(message.text, isIncomingMessage: true, avatarImage: newImage)

                    }
                    
                    self.messageCounter! += 1
                }
            }
        }
    }
    
//    func textToImage(drawText: String, inImage: UIImage) -> UIImage{
//
//        // Setup the font specific variables
//        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
//
//        // Setup the image context using the passed image
//        let scale = UIScreen.main.scale
//        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
//
//        // Setup the font attributes that will be later used to dictate how the text should be drawn
////        let textFontAttributes = [
////            NSFontAttributeName: textFont,
////            NSForegroundColorAttributeName: textColor,
////            ]
//
//        // Put the image into a rectangle as large as the original image
//        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
//
//        // Create a point within the space that is as bit as the image
//        let rect = CGRect(x: inImage.size.width / 2, y: inImage.size.height / 2, width: inImage.size.width, height: inImage.size.height)
//
//        drawText.draw(in: rect, withAttributes: [
//            NSAttributedStringKey.font: textFont
//                        ])
//
//        // Create a new image out of the images we have created
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//
//        // End the context now that we have the image we need
//        UIGraphicsEndImageContext()
//
//        //Pass the image back up to the caller
//        return newImage!
//
//    }
    
//    func generateImageWithText(text: String) -> UIImage
//    {
//        let image = #imageLiteral(resourceName: "default-user")
//
//        let imageView = UIImageView(image: image)
//        imageView.backgroundColor = UIColor.clear
//        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
//
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
//        label.backgroundColor = UIColor.clear
//        label.textAlignment = .center
//        label.textColor = UIColor.darkText
//        label.text = text
//
//        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
//        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        label.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return imageWithText!
//    }
    
    func textToImage(drawText text: String) -> UIImage {
        let image = #imageLiteral(resourceName: "lightgraycircle")
        let textColor = UIColor.darkText
        let textFont = UIFont(name: "Helvetica Bold", size: 36)!



        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let rect = CGRect(x: image.size.width / 4, y: image.size.height / 4, width: image.size.width, height: image.size.height)
        //let rect = CGRect(x: 10, y: 10, width: 20, height: 20)
        //let rect = CGRect(origin: image.size.width, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
}
