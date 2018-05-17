//
//  MessagesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

protocol MessagesViewControllerDelegate: class {
    func didSelectChannel(channel: Channel)
}

class MessagesViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var channelArray = [Channel]()
    
    weak var delegate: MessagesViewControllerDelegate?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {


        self.tabBarController?.navigationItem.title = "Messages"
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messages", for: indexPath)
        
        
        let channel = channelArray[indexPath.row]
    
        cell.textLabel?.text = channel.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = channelArray[indexPath[1]]
        delegate?.didSelectChannel(channel: channel)
    }
    
    


}
