//
//  UIButtonClass.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 6..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import Foundation
import UIKit

class UIRoundPrimaryButton: UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 1)
        self.tintColor = UIColor.white
    }
}



