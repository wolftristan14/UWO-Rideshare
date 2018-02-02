//
//  ProfileImageStyleManager.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-02-02.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class ProfileImageStyleManager: UIImageView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width/2
    }
    
    
}
