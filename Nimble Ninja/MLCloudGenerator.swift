//
//  MLCloudGenerator.swift
//  Nimble Ninja
//
//  Created by Ömer Koçbil on 9.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation
import SpriteKit

class MLCloudGenerator: SKSpriteNode {
    
    let widthCloud: CGFloat = 125.0
    let heightCloud: CGFloat = 55.0
    
    var generationTimer: Timer!
    
    func populate(num: Int) {
        for i in 0 ..< num {
            let cloud = MLCloud(size: CGSize(width: widthCloud, height: heightCloud))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPoint(x: x, y: y)
            cloud.zPosition = -1
            addChild(cloud )
        }
    }
    
    func startGeneratingWithSpawnTime(seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(MLCloudGenerator.generateCloud), userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer.invalidate()
    }
    
    func generateCloud() {
        let x = size.width/2 + widthCloud/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
        let cloud = MLCloud(size: CGSize(width: widthCloud, height: heightCloud))
        cloud.position = CGPoint(x: x, y: y)
        cloud.zPosition = -1
        addChild(cloud )
    }
    
}
