//
//  MLWall.swift
//  Nimble Ninja
//
//  Created by Ömer Koçbil on 9.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation
import SpriteKit

class MLWall: SKSpriteNode {
    
    let widthWall: CGFloat = 30.0
    let heightWall: CGFloat = 50.0
    let colorWall = UIColor.black
    
    init() {
        let size = CGSize(width: 32, height: 44)
        super.init(texture: nil, color: colorWall, size: CGSize(width: widthWall, height: heightWall))
        
        loadPhysicsBodyWithSize(size: size)
        startMoving()
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveBy(x: -kDefaultXToMovePerSecond, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
    
}
