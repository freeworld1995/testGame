//
//  ChangeColorController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/25/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class ChangeColorController: Controller {
    init() {
        super.init(view: View(path: Shape.getTrianglePath()), color: cRED)
    }
    
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        self.parent = parent
        configPhysics()
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.categoryBitMask = BitMask.CHANGE_COLOR
        view.physicsBody?.contactTestBitMask = BitMask.PLAYER
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 1
        view.name = "ChangeColorObject"
        
        view.handleContact = { otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.PLAYER {
                self.view.removeFromParent()
            }
        }
        
    }

}
