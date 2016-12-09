//
//  ExplosionController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/27/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class ExplosionController {
    static func makeShatter(position: CGPoint, parent: SKNode) {
        if let shatter = SKEmitterNode(fileNamed: "shatter") {
            shatter.position = position
            let addShatterAction = SKAction.run {
                parent.addChild(shatter)
            }
            let wait = SKAction.wait(forDuration: 1.5)
            let removeShatterFromNode = SKAction.run {
                shatter.removeFromParent()
            }
            let sequence = SKAction.sequence([addShatterAction, wait, removeShatterFromNode])
            
            parent.run(sequence)
        }
    }
    
    
}
