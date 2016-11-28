//
//  MLPointsLabel.swift
//  Nimble Ninja
//
//  Created by Ömer Koçbil on 11.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MLPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.black
        fontName = "Helvetica"
        fontSize = 24.0
        
        number = num
        text = "\(num)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment() {
        number += 1
        text = "\(number)"
    }
    
    func setTo(number: Int) {
        self.number = number
        text = "\(self.number)"
        
    }
    
}
