//
//  GameOverScene.swift
//  Session1
//
//  Created by Nguyen Bach on 11/12/16.
//  Copyright © 2016 Nguyen Bach. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    var restartButtonNode:SKSpriteNode!
    var rain :SKEmitterNode!
    override func didMove(to view: SKView) {
        restartButtonNode = self.childNode(withName: "RestartButton") as! SKSpriteNode
        restartButtonNode.texture = SKTexture(imageNamed: "RestartButton")
        
//        rain = SKEmitterNode(fileNamed:"Rain")
//        rain.position = CGPoint(x: 0    , y : 1472 )
//        rain.advanceSimulationTime(10)
//        self.run(SKAction.playSoundFileNamed("gameover.mp3", waitForCompletion: false))
//        self.addChild(rain)
//        rain.zPosition = -1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let node = self.nodes(at: location)
            
            if node[0].name == "RestartButton"{
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let level = UserDefaults.standard.object(forKey: "mylevel") as! String
                let gameScene = SKScene(fileNamed: level)
                self.view!.presentScene(gameScene!, transition: transition)
                
            }
        }
    }
    
}
