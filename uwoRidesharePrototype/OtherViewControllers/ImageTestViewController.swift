//
//  ImageTestViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-05-30.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit

class ImageTestViewController: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let image = generateImageWithText(text: "Tr")
        let image = textToImage(drawText: "Tr")
        imageView.image = image
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        let textFont = UIFont(name: "Helvetica Bold", size: 30)!
        
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
