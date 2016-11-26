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
        super.init(view: View(path: Shape.getStarPath()), color: cRED)
//        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeColor), userInfo: nil, repeats: false)
    }
    
    @objc func changeColor() {  
        view.fillColor = cGREEN
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        self.parent = parent
        configPhysics()
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(edgeChainFrom: self.view.path!)
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
