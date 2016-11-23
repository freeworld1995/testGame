//
//  EnemyController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class EnemyController: Controller {
    init() {
        super.init(view: View(color: cRED, size: CGSize(width: 70, height: 70)))
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?, type: String?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction, type: type)
        self.parent = parent
        configPhysics()
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.categoryBitMask = ENEMY_MASK
        view.physicsBody?.contactTestBitMask = PLAYER_MASK
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 1
        view.name = "enemy"
  
    }

}
