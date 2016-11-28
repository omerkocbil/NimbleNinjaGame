//
//  MLWallGenerator.swift
//  Nimble Ninja
//
//  Created by Ömer Koçbil on 9.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation
import SpriteKit

class MLWallGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var walls = [MLWall]()
    var wallTrackers = [MLWall]()
    
    func startGeneratingWallsEvery(seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(MLWallGenerator.generateWall), userInfo: nil, repeats: true)
    }
    
    func stopGenerating() {
        generationTimer?.invalidate()
    }
    
    func generateWall() {
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0 {
            scale = -1.0
        }
        else {
            scale = 1.0
        }
        
        let wall = MLWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kMLGroundHeight/2 + wall.size.height/2)
        walls.append(wall)
        wallTrackers.append(wall)
        addChild(wall)
    }
    
    func stopWall() {
        stopGenerating()
        
        for wall in walls {
            wall.stopMoving()
        }
    }
    
}
