//
//  GameOver.swift
//  testPlatformer
//
//  Created by Nguyen Bach on 12/1/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    override func didMove(to view: SKView) {
        let pauseMenu = SKSpriteNode(color: cBACKGROUND, size: self.frame.size)
        pauseMenu.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        pauseMenu.alpha = 0.05
        pauseMenu.run(SKAction.fadeAlpha(to: 0.2, duration: 4))
        pauseMenu.zPosition = 5
        self.addChild(pauseMenu)
        
        
        let tryAgain = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        tryAgain.fontSize = 30
        tryAgain.fontColor = SKColor.black
        tryAgain.position = CGPoint(x: self.frame.size.width / 2, y: 140)
        tryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        tryAgain.text = "Tap To Try Again"
        tryAgain.name = "TTTA"
        
        tryAgain.run(SKAction.fadeIn(withDuration: 5))
        self.addChild(tryAgain)
        
//        let myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        
//        let gesture = UITapGestureRecognizer(target: self.parent, action: #selector(transition))
//        gesture.numberOfTapsRequired = 1
//        myView.addGestureRecognizer(gesture)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let reveal = SKTransition.fade(withDuration: 0.5)
//        let gameScene = GameScene(size: self.frame.size)
//        gameScene.view?.presentScene(gameScene, transition: reveal)
        let touch = touches.first
//        if let location = touch?.location(in: self){
//            let node = self.nodes(at: location)
//            
//            if node[0].name == "TTTA"{
//                        let reveal = SKTransition.fade(withDuration: 0.5)
//                        let gameScene = GameScene(size: self.frame.size)
//                        self.view?.presentScene(gameScene, transition: reveal)
//                
//            }
//        }
    }
}
    
    

