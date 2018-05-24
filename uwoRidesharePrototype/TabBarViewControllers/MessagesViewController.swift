//
//  MessagesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Firebase

protocol MessagesViewControllerDelegate: class {
    func didSelectChannel(channel: Channel)
}

class MessagesViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var channelArray = [Channel]()
    
    weak var delegate: MessagesViewControllerDelegate?
    
    var loadChannelsQuery: Query!
    var channel: Channel!


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadChannelsFromFirebase()
        tableView.reloadData()
        self.tabBarController?.navigationItem.title = "Messages"
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messages", for: indexPath) as! MessagesTableViewCell
        
        
        let channel = channelArray[indexPath.row]
    
        cell.channelLabel.text = channel.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = channelArray[indexPath[1]]
        delegate?.didSelectChannel(channel: channel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadChannelsFromFirebase() {
        
        
        let userUID = Auth.auth().currentUser?.uid ?? ""
        loadChannelsQuery = Firestore.firestore().collection("Channels").whereField("members.\(userUID)", isEqualTo: true)
        
        loadChannelsQuery.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.channelArray.removeAll()
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
                        self.tableView.reloadData()
                        
                        
                    }
                }
            }
        }
    }
    
    


}
