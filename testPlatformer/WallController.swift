//
//  ChangeColorController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/25/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class WallController: Controller {
    
    var arrayColor: [UIColor] = [cRED, cGREEN, cBLUE]
    
    init(color: UIColor) {
        super.init(view: View(path: Shape.getDoraemonBagPath()), color: color)
    }
    
    deinit {
        print("ChangeColor deinited")
    }
    
    override func config(position: CGPoint, parent: Scene, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        configPhysics()
    }
    
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(polygonFrom: view.path!)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.categoryBitMask = BitMask.ANOTHER_WALL
        view.physicsBody?.contactTestBitMask = BitMask.PLAYER
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 1
        view.name = "Another WALL"
        
        //        view.handleContact = { [unowned self] otherView in
        //            if otherView.physicsBody?.categoryBitMask == BitMask.PLAYER {
        //                self.view.removeFromParent()
        //            }
        //        }
    }
    
}
