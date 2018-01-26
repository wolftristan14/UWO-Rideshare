//
//  HomeCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-20.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol HomeCoordinatorDelegate: class {
    
}


class HomeCoordintor: NSObject, UITabBarDelegate, UITabBarControllerDelegate {
    
    
    
    var navigationController: UINavigationController?
    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators = [NSObject]()
    
    var collRef: CollectionReference!
    var storage: Storage!
    var storageRef: StorageReference!
    var yourRidesViewController: YourRidesViewController!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.flatPurple
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.flatWhite, NSAttributedStringKey.font: UIFont.init(name: "Times New Roman", size: 20) ?? UIFont.boldSystemFont(ofSize: 25)]
        //back item is nil at this point
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "home")
        //doing this to get reference to tab bar controller, might be a better way
        let tabBarController = homeViewController.childViewControllers[0].tabBarController
        tabBarController?.delegate = self
        tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        
        navigationController?.pushViewController(homeViewController, animated: true)
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController.view.tag {
        case 0:
            let searchCoordinator = SearchCoordinator(navigationController: navigationController!)
            searchCoordinator.delegate = self as SearchCoordinatorDelegate
            searchCoordinator.start()
            childCoordinators.append(searchCoordinator)
            
        case 1:
            let yourRidesCoordinator = YourRidesCoordinator(navigationController: navigationController!)
            yourRidesCoordinator.delegate = self as YourRidesCoordinatorDelegate
            yourRidesCoordinator.start()
            childCoordinators.append(yourRidesCoordinator)

            
        case 2:
            let profileCoordinator = ProfileCoordinator(navigationController: navigationController!)
            profileCoordinator.delegate = self as ProfileCoordinatorDelegate
            profileCoordinator.start()
            childCoordinators.append(profileCoordinator)
            
        case 3:
            let messagesCoordinator = MessagesCoordinator(navigationController: navigationController!)
            messagesCoordinator.delegate = self as MessagesCoordinatorDelegate
            messagesCoordinator.start()
            childCoordinators.append(messagesCoordinator)
            
        default:
            print("shi")
        }
    }
}

extension HomeCoordintor: SearchCoordinatorDelegate {
   
    
}

extension HomeCoordintor: YourRidesCoordinatorDelegate {
    
    
}

extension HomeCoordintor: ProfileCoordinatorDelegate {
    
    
}

extension HomeCoordintor: MessagesCoordinatorDelegate {
    
    
}



