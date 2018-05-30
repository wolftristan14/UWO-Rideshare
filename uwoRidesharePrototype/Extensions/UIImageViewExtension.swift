//
//  UIImageViewExtension.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-02-25.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

let imageCache = NSCache<NSString, AnyObject>()
var storage: Storage!
var storageRef: StorageReference!
var image: UIImage!

extension UIImageView {
    
    
    func loadImageFromCache(downloadURLString: String, finished: @escaping (UIImage) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: downloadURLString as NSString) {
            image = cachedImage as? UIImage
            //return cachedImage as! UIImage
            //viewController.imageView.image = cachedImage as? UIImage
            finished(self.image!)
        } else {
        
        storage = Storage.storage()
        storageRef = storage.reference(forURL: downloadURLString)
        print("about to get image data")
        storageRef.getData(maxSize: 1 * 2000 * 2000) { (data, error) -> Void in
            print("got image data")
            let downloadedImage = UIImage(data: data!)
            //viewController.imageView.image = downloadedImage
            self.image = downloadedImage
            imageCache.setObject(downloadedImage!, forKey: downloadURLString as NSString)
            finished(self.image!)

        }
        }
        //finished(image!)
    }
}

extension ChatViewController {
    
    func loadImageFromCache(downloadURLString: String, finished: @escaping (UIImage) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: downloadURLString as NSString) {
            image = cachedImage as? UIImage
            //return cachedImage as! UIImage
            //viewController.imageView.image = cachedImage as? UIImage
            finished(self.image!)
        } else {
            
            storage = Storage.storage()
            storageRef = storage.reference(forURL: downloadURLString)
            print("about to get image data")
            storageRef.getData(maxSize: 1 * 2000 * 2000) { (data, error) -> Void in
                print("got image data")
                let downloadedImage = UIImage(data: data!)
                //viewController.imageView.image = downloadedImage
                self.image = downloadedImage
                imageCache.setObject(downloadedImage!, forKey: downloadURLString as NSString)
                finished(self.image!)
                
            }
        }
        //finished(image!)
    }
    
}


