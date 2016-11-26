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
    var cameraNode: SKCameraNode!
    
    override func didMove(to view: SKView) {
        addBackground()
        addPhysics()
        addGestureRecognizer(to: view)
        addWall()
        // if addCarera() -> please uncomment update() also !!
//        addCamera()
        
        let playerPosition = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playerController.config(position: playerPosition, parent: self, shootAction: nil, moveAction: nil)
        
        let enemyController = EnemyController()
        enemyController.config(position: CGPoint(x: 700, y: 550), parent: self, shootAction: nil, moveAction: nil)

        let changeColorController = ChangeColorController()
        changeColorController.config(position: CGPoint(x: 300, y: 600), parent: self, shootAction: nil, moveAction: nil)
    }

//    override func update(_ currentTime: TimeInterval) {
//        cameraNode.position = playerController.position
//    }
    
    func convert(point: CGPoint)->CGPoint {
        return self.view!.convert(CGPoint(x: point.x, y:self.view!.frame.height-point.y), to:self)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let viewA = contact.bodyA.node as? View, let viewB = contact.bodyB.node as? View
            else {
                return
        }
        
        if let handleContactA = viewA.handleContact {
            handleContactA(viewB)
        }
        
        if let hanldeContactB = viewB.handleContact {
            hanldeContactB(viewA)
        }
    }
    
    func addCamera() {
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    }
    
    func addWall() {
        let wall = View(rect: self.frame.insetBy(dx: self.frame.size.width * -0.2, dy: self.frame.size.height * -0.2))
        wall.position = CGPoint.zero
        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: wall.frame)
        wall.physicsBody?.categoryBitMask = BitMask.WALL
        wall.physicsBody?.contactTestBitMask = BitMask.PLAYER | BitMask.ENEMY | BitMask.CHANGE_COLOR
        wall.name = "wall"
        wall.handleContact = { otherView in
            otherView.removeFromParent()
        }
        addChild(wall)
    }
    
    func addBackground() {
        let background = View(rect: self.frame)
        background.fillColor = cBACKGROUND
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        background.physicsBody?.categoryBitMask = BitMask.WALL_FOR_PLAYER
        background.physicsBody?.contactTestBitMask = BitMask.PLAYER
        background.zPosition = -1
        background.handleContact = { otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.PLAYER {
                print("Touch PLAYER !!!")
            }
        }
        addChild(background)
    }
    
    func addPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func addGestureRecognizer(to view: SKView) {
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
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
//        print("swiped right")
        playerController.view.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
//        print("swiped left")
        playerController.view.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
//        print("swiped up")
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
//        print("swiped down")
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: -500)
    }
    
}
