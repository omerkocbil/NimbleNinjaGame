//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by Ömer Koçbil on 8.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: MLMovingGround!
    var hero: MLHero!
    var cloudGenerator: MLCloudGenerator!
    var wallGenerator: MLWallGenerator!
    
    var isStarted = false
    var isGameOver = false
    
    var currentLevel = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 150.0/255.0, green: 241.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        // add ground
        movingGround = MLMovingGround(size: CGSize(width: view.frame.width, height: kMLGroundHeight))
        movingGround.position = CGPoint(x: 0, y: view.frame.size.height/2)
        addChild(movingGround)
    
        // add hero
        hero = MLHero()
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2 )
        addChild(hero)
        hero.breathe()
        
        // add cloud generator
        cloudGenerator = MLCloudGenerator(color: UIColor.clear, size: view.frame.size)
        cloudGenerator.position = view.center
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 7)
        cloudGenerator.startGeneratingWithSpawnTime(seconds: 5)
        
        // add wall generator
        wallGenerator = MLWallGenerator(color: UIColor.clear, size: view.frame.size)
        wallGenerator.position = view.center
        addChild(wallGenerator)
        
        // start label
        let tapToStartLabel = SKLabelNode(text: "Tap to start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view.center.x
        tapToStartLabel.position.y = view.center.y + 40
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontColor = UIColor.black
        tapToStartLabel.fontSize = 22.0
        addChild(tapToStartLabel)
        tapToStartLabel.run(blinkAnimation())
        
        // add point labels
        let pointsLabel = MLPointsLabel(num: 0)
        pointsLabel.position = CGPoint(x: 20.0, y: view.frame.size.height-35)
        pointsLabel.name = "pointsLabel"
        addChild(pointsLabel)
        
        let highScoreLabel = MLPointsLabel(num: 0)
        highScoreLabel.position = CGPoint(x: view.frame.size.width-30, y: view.frame.size.height-35)
        highScoreLabel.name = "highScoreLabel"
        addChild(highScoreLabel)
        
        let highScoreTextLabel = SKLabelNode(text: "High")
        highScoreTextLabel.fontColor = UIColor.black
        highScoreTextLabel.fontSize = 14.0
        highScoreTextLabel.fontName = "Helvetica"
        highScoreTextLabel.position = CGPoint(x: 0, y: -20)
        highScoreLabel.addChild(highScoreTextLabel)
        
        // add physics world
        physicsWorld.contactDelegate = self
        
        // load high score
        let defaults = UserDefaults.standard
        let highScore = childNode(withName: "highScoreLabel") as! MLPointsLabel
        highScore.setTo(number: defaults.integer(forKey: "highScore"))
    }
    
    func start() {
        isStarted = true
        
        let tapToStartLabel = childNode(withName: "tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        
        hero.stop()
        hero.startRunning()
        movingGround.start()
        
        wallGenerator.startGeneratingWallsEvery(seconds: 1)
    }
    
    func gameOver() {
        isGameOver = true
        
        hero.fall()
        wallGenerator.stopWall()
        movingGround.stop()
        hero.stop()
        
        // create game over label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.position.x = (view?.center.x)!
        gameOverLabel.position.y = (view?.center.y)! + 40
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.fontColor = UIColor.black
        gameOverLabel.fontSize = 22.0
        addChild(gameOverLabel)
        gameOverLabel.run(blinkAnimation())
        
        // save current points label value
        let pointsLabel = childNode(withName: "pointsLabel") as! MLPointsLabel
        let highScoreLabel = childNode(withName: "highScoreLabel") as! MLPointsLabel
        
        if highScoreLabel.number < pointsLabel.number {
            highScoreLabel.setTo(number: pointsLabel.number)
            
            let defaults = UserDefaults.standard
            defaults.set(highScoreLabel.number, forKey: "highScore")
        }
    }
    
    func restart() {
        cloudGenerator.stopGenerating()
        
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .aspectFill
        
        // Present the scene
        view!.presentScene(newScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver {
            restart()
        }
        else if !isStarted {
            start()
        }
        else {
            hero.flip()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if wallGenerator.wallTrackers.count > 0 {
            let wall = wallGenerator.wallTrackers[0] as MLWall
            let wallLocation = wallGenerator.convert(wall.position, to: self)
            
            if wallLocation.x < hero.position.x {
                wallGenerator.wallTrackers.remove(at: 0)
                let pointsLabel = childNode(withName: "pointsLabel") as! MLPointsLabel
                pointsLabel.increment()
                
                if pointsLabel.number % kNumberOfPointsPerLevel == 0 {
                    currentLevel += 1
                    wallGenerator.stopGenerating()
                    wallGenerator.startGeneratingWallsEvery(seconds: kLevelGenerationTimes[currentLevel])
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if !isGameOver{
            gameOver()
        }
    }
    
    func blinkAnimation() -> SKAction {
        let duration = 0.4
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }
    
}
