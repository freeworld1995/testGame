//
//  EnemyController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class SevenColorsController: Controller {
    
    var timer: Timer!
    
    init(color: UIColor) {
        super.init(view: View(path: Shape.getStarPath()), color: color)
    }
    
    deinit {
        print("7Colors deinited")
    }

    func activate7Colors() {
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(rand7Colors), userInfo: nil, repeats: true)
    }
    
    @objc func rand7Colors() {
        var arrayColor: [UIColor] = [cRED, cGREEN, cGRAY, cBROWN, cSEA, cPINK, cPURPLE]
        
        arrayColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayColor) as! [UIColor]
        let dx = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: -40, highestValue: 40)
        let dy = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: -40, highestValue: 40)
        view.fillColor = arrayColor[0]
        view.physicsBody?.applyImpulse(CGVector(dx: dx.nextInt(), dy: dy.nextInt()))
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
        view.physicsBody?.usesPreciseCollisionDetection = true
        view.setScale(1.5)
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.restitution = 1.0
        view.physicsBody?.categoryBitMask = BitMask.SEVEN_COLORS
        view.physicsBody?.contactTestBitMask = BitMask.PLAYER | BitMask.PROTECT_TRIANGLE
        view.physicsBody?.collisionBitMask = BitMask.WALL_FOR_PLAYER | BitMask.PLAYER
        view.zPosition = 1
        view.name = "7Colors"
        if moveAction != nil {
            configMove(action: moveAction!)
        }
        
        view.handleContact = { [unowned self] otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.PROTECT_TRIANGLE {
                otherView.removeFromParent()
                self.parent.makeReplay?()
            }
            if otherView.physicsBody?.categoryBitMask == BitMask.WALL_FOR_PLAYER {
                self.parent.makeCameraShake!()
                self.view.run(SKAction.playSoundFileNamed("ping6.wav", waitForCompletion: false))
                ExplosionController.makeShatter(position: self.position, parent: self.parent!)
            }
            if otherView.physicsBody?.categoryBitMask == BitMask.PROTECT_TRIANGLE {
                self.parent.makeCameraShake!()
                ExplosionController.makeShatter(position: self.position, parent: self.parent!)
            }
        }
        
    }
    
}
