//
//  PlayerController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class PlayerController: Controller {
    
    static let instance = PlayerController()
    
    private init() {
        super.init(view: View(color: cBLUE, size: CGSize(width: 70, height: 70)))
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?, type: String?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction, type: type)
        self.parent = parent
        configPhysics()
        
        let blue = UIColor.blue
        
        if view.color == blue {
            print("fuck yeah")
        }
        
        let border = SKSpriteNode(color: view.color, size: view.size)
        border.alpha = 0.2
        let enlargeAction = SKAction.scale(to: 1.28, duration: 1.5)
        let shrinkAction = SKAction.scale(to: 1, duration: 1.5)
        let foreverBorderAction = SKAction.repeatForever(SKAction.sequence([enlargeAction, shrinkAction]))
        border.run(foreverBorderAction)
        view.addChild(border)
        
//        let emitter = SKEmitterNode(fileNamed: "FireParticles")
//        emitter?.zPosition = 1
//        view.addChild(emitter!)
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.categoryBitMask = PLAYER_MASK
        view.physicsBody?.contactTestBitMask = ENEMY_MASK
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 2
        view.name = "player"
     
        view.handleContact = { [unowned self] otherView in
            if otherView.color != self.view.color {
                self.view.color = otherView.color
            }
        }
        
    }
}
