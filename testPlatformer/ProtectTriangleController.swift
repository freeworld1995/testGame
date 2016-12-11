//
//  ProtectTriangleController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 12/10/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//
//
//  EnemyController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class ProtectTriangleController: Controller {
    
    init(color: UIColor) {
        super.init(view: View(path: Shape.getTrianglePath()), color: color)
    }
    
    deinit {
        print("Protect Triangle deinited")
    }
    
    override func config(position: CGPoint, parent: Scene, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        configPhysics()
        addProtectSign()
    }
    
    func configMove(action: SKAction) {
        view.run(.repeatForever(action))
    }
    
    func addProtectSign() {
        let protectSign = SKSpriteNode(imageNamed: "protectSign")
        protectSign.position = CGPoint(x: 0, y: view.frame.size.height / 2 + 5)
        protectSign.zRotation = CGFloat(-20.degreesToRadians)
        let rotateLeft = SKAction.rotate(toAngle: CGFloat(20.degreesToRadians), duration: 2)
        let rorateRight = SKAction.rotate(toAngle: CGFloat(-20.degreesToRadians), duration: 2)
        let sequence = SKAction.sequence([rotateLeft, rorateRight])
        protectSign.run(.repeatForever(sequence))
        view.addChild(protectSign)
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(polygonFrom: view.path!)
        view.physicsBody?.usesPreciseCollisionDetection = true
        view.setScale(1.5)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.friction = 0
        view.physicsBody?.restitution = 1.0
        view.physicsBody?.categoryBitMask = BitMask.PROTECT_TRIANGLE
        view.physicsBody?.contactTestBitMask = BitMask.SEVEN_COLORS
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 1
        view.name = "Protect"
        if moveAction != nil {
            configMove(action: moveAction!)
        }
        
   
        
    }
    
}
