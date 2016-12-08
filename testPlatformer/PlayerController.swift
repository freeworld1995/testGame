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

    weak var border: SKShapeNode!
    
    private init() {
        super.init(view: View(path: Shape.getRectanglePath()), color: cBLUE)
        border = SKShapeNode(path: view.path!)
        border.fillColor = view.fillColor
        border.alpha = 0.2
        let enlargeAction = SKAction.scale(to: 1.18, duration: 0.5)
        let shrinkAction = SKAction.scale(to: 1, duration: 0.5)
        let foreverBorderAction = SKAction.repeatForever(SKAction.sequence([enlargeAction, shrinkAction]))
        border.run(foreverBorderAction)
        view.addChild(border)

    }
    
    deinit {
        print("playerController deinited")
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        self.parent = parent
        configPhysics()
        
        if moveAction != nil {
            configMove(action: moveAction!)
        }
        
        
        //        let emitter = SKEmitterNode(fileNamed: "FireParticles")
        //        emitter?.zPosition = 1
        //        view.addChild(emitter!)
    }
    
    func configMove(action: SKAction) {
                view.run(.repeatForever(action))
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(polygonFrom: view.path!)
        view.physicsBody?.usesPreciseCollisionDetection = true
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.categoryBitMask = BitMask.PLAYER
        view.physicsBody?.contactTestBitMask = BitMask.ENEMY | BitMask.CHANGE_COLOR | BitMask.WALL_FOR_PLAYER
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 1
        view.name = "player"
        
        view.handleContact = { [unowned self] otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.ENEMY && otherView.fillColor == self.view.fillColor {
                self.view.contacted = true
                otherView.removeFromParent()
                Level1.minusMaxEnemy()
                
                Level1.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.parent.frame.size.width / 2, y: self.parent.frame.size.height / 2), duration: 0.5, amplitudeX: 11, amplitudeY: 5))
                
                ExplosionController.makeShatter(parent: self.parent, color: self.view.fillColor)
            }
            
            if otherView.physicsBody?.categoryBitMask == BitMask.CHANGE_COLOR {
                otherView.removeFromParent()
                self.border.fillColor = otherView.fillColor
                self.view.fillColor = otherView.fillColor
            }
        }
        
    }
}
