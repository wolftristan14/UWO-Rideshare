//
//  AppDelegate.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-06.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuthUI
import FBSDKCoreKit
import FirebaseFacebookAuthUI
import UserNotifications
import SafariServices
import InstantSearch


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var rootViewController: UINavigationController?
    var appCoordinator: AppCoordinator?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow.init(frame: UIScreen.main.bounds)
        rootViewController = UINavigationController()
        
        window?.rootViewController = rootViewController
        rootViewController?.view.backgroundColor = UIColor.white
        
        appCoordinator = AppCoordinator(navigationController: rootViewController!)
        window?.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "appFirstTimeOpend") == nil {
            //if app is first time opened then it will be nil
            userDefaults.setValue(true, forKey: "appFirstTimeOpend")
            // signOut from FIRAuth
            do {
                try Auth.auth().signOut()
            }catch {
                
            }
            appCoordinator?.start()
        } else {
            appCoordinator?.start()
        }
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            let token = Messaging.messaging().fcmToken
            print("FCM token: \(token ?? "")")
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        //move api key to server
        InstantSearch.shared.configure(appID: "NB1PXG4WJM", apiKey: "6132710f15ba25f5b14971533c42c209", index: "Rides")
//        InstantSearch.shared.params.attributesToRetrieve = ["origin", "destination", "date", "price", "availableSeats"]
        InstantSearch.shared.searcher.params.attributesToHighlight = ["origin", "destination", "date", "price", "availableSeats"]


        return true
    }
    
    //might have to move this stuff
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        UserDefaults.standard.setValue(fcmToken, forKey: "devicetoken")
        UserDefaults.standard.synchronize()
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    

    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

    
}

