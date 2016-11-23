//
//  GameScene.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let playerController = PlayerController.instance
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        
        let playerPosition = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playerController.config(position: playerPosition, parent: self, shootAction: nil, moveAction: nil, type: "blue")
        
        let enemyController = EnemyController()
        enemyController.config(position: CGPoint(x: 700, y: 550), parent: self, shootAction: nil, moveAction: nil, type: "blue")
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let viewA = contact.bodyA.node as? View, let viewB = contact.bodyB.node as? View else { return }
        
        print(viewA.name!)
        print(viewB.name!)
        
        viewA.handleContact?(viewB)
        viewB.handleContact?(viewA)
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        print("swiped right")
        playerController.view.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
//        playerController.view.physicsBody?.applyForce(CGVector(dx: 800, dy: 0))
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        print("swiped left")
        playerController.view.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
//        playerController.view.physicsBody?.applyForce(CGVector(dx: -800, dy: 0))
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        print("swiped up")
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
//        playerController.view.physicsBody?.applyForce(CGVector(dx: 0, dy: 800))
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        print("swiped down")
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: -500)
//        playerController.view.physicsBody?.applyForce(CGVector(dx: 0, dy: -800))
    }
    
}
