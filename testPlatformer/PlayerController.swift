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
    var border: SKShapeNode!
    
    private init() {
        super.init(view: View(rectOf: CGSize(width: 75, height: 75), cornerRadius: 8), color: cBLUE)
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        self.parent = parent
        configPhysics()
        
        border = SKShapeNode(rectOf: view.frame.size, cornerRadius: 8)
        border.fillColor = view.fillColor
        border.alpha = 0.2
        let enlargeAction = SKAction.scale(to: 1.18, duration: 1)
        let shrinkAction = SKAction.scale(to: 1, duration: 1)
        let foreverBorderAction = SKAction.repeatForever(SKAction.sequence([enlargeAction, shrinkAction]))
        border.run(foreverBorderAction)
        view.addChild(border)
        
//        let emitter = SKEmitterNode(fileNamed: "FireParticles")
//        emitter?.zPosition = 1
//        view.addChild(emitter!)
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
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
            if otherView.fillColor != self.view.fillColor {
                self.view.fillColor = otherView.fillColor
                self.border.fillColor = otherView.fillColor
            }
        }
        
    }
}
