//
//  EnemyController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class EnemyController: Controller {
    
    var timer: Timer!
    
    init() {
        super.init(view: View(path: Shape.getStarPath()), color: cRED)
    }
    
    deinit {
        print("enemyController deinited")
    }
    
    func activateAutoChangeColor() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(randColor), userInfo: nil, repeats: true)
    }
    
    var arrayColor: [UIColor] = [cRED, cGREEN, cBLUE]
    
    @objc func randColor() {
        arrayColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayColor) as! [UIColor]
        
        view.fillColor = arrayColor[0]
    }

    override func config(position: CGPoint, parent: Scene, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        configPhysics()
    }
    
    func configMove(action: SKAction) {
        view.run(.repeatForever(action))
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(polygonFrom: view.path!)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.restitution = 80
        view.physicsBody?.categoryBitMask = BitMask.ENEMY
        view.physicsBody?.contactTestBitMask = BitMask.PLAYER
        view.physicsBody?.collisionBitMask = BitMask.ENEMY
        view.zPosition = 1
        view.name = "enemy"
        if moveAction != nil {
            configMove(action: moveAction!)
        }

    }
    
}
