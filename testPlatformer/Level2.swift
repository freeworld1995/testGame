
//  GameScene.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class Level2: Scene, SKPhysicsContactDelegate{
    var spawnTriangle : Timer!
    let playerController = PlayerController()
    var cameraNode: SKCameraNode!
    let tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
    var changeColor : SKNode!
    var firstTap: Bool = false
    
    override func didMove(to view: SKView) {
        makeCameraShake = { [unowned self] in
            self.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.4, amplitudeX: 14, amplitudeY: 9))
        }
        addBackground()
        addPhysics()
        addGestureRecognizer(to: view)
        addWall()
        addCamera()
        addChangColorController()
        addPlayer()
        
        tapToStartNode.position = CGPoint(x: self.size.width / 2 , y: 300)
        
        addChild(tapToStartNode)
        let enemyController1 = EnemyController(shape: Shape.getStarPath(), color: cRED)
        enemyController1.view.fillColor = cRED
        enemyController1.config(position: CGPoint(x: 700, y: 550), parent: self, shootAction: nil, moveAction: nil)
        
        let enemyController2 = EnemyController(shape: Shape.getStarPath(), color: cBLUE)
        enemyController2.view.fillColor = cGREEN
        enemyController2.config(position: CGPoint(x: 300, y: 350), parent: self, shootAction: nil, moveAction: nil)
        
        let enemyController3 = EnemyController(shape: Shape.getStarPath(), color: cGREEN)
        enemyController3.view.fillColor = cBLUE
        enemyController3.config(position: CGPoint(x: 130, y: 250), parent: self, shootAction: nil, moveAction: nil)
        
        spawnTriangle = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(addChangColorController), userInfo: nil, repeats: true)
        //
        //        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(activateAutoChangeColor), userInfo: nil, repeats: true)
        
        //        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(randColor), userInfo: nil, repeats: true)
    }
    
    //    override func update(_ currentTime: TimeInterval) {
    //        cameraNode.position = playerController.position
    //    }
    
    
    func addPlayer()  {
        let playerPosition = CGPoint(x: self.frame.midX , y: self.frame.midY / 2)
        playerController.config(position: playerPosition, parent: self, shootAction: nil, moveAction: nil)
        self.playerController.didDestroyEnemy = { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                self.playerController.view.contacted = false
            }
        }
    }
    
    func addChangColorController()  {
        let changeColorController = ChangeColorController(color: UIColor.randColor())
        // changeColorController.view.physicsBody?.isDynamic = true
        let array = ["BLUE","GREEN","RED"]
        changeColorController.view.fillColor = UIColor.fromString(name: array.random3Colors())
        let changeColorControllerPosition = CGPoint(x: random(min: self.size.width * 0.1, max: self.size.width * 0.9) , y: self.size.height)
        let path = UIBezierPath.setPath(positionX: changeColorControllerPosition.x, positionY: changeColorControllerPosition.y, view: self.view!)
        
        let random1 = random_Int(min: 0, max: path.count - 1 )
        let trianglePath = SKAction.follow(path[random1].cgPath, duration: 10)
        changeColorController.view.run(SKAction.sequence([trianglePath, SKAction.removeFromParent()]))
        
        changeColorController.config(position: changeColorControllerPosition , parent: self, shootAction: nil, moveAction: trianglePath)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let viewA = contact.bodyA.node as? View, let viewB = contact.bodyB.node as? View
            else {
                return
        }
        
        // if contacted turn ON -> object cannot contact anymore for a while
        if viewA.contacted || viewB.contacted {
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
        
        background.handleContact = { [unowned self] otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.PLAYER {
                otherView.removeFromParent()
                self.spawnTriangle.invalidate()
                let pauseMenu = SKSpriteNode(color: cBACKGROUND, size: self.frame.size)
                pauseMenu.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
                pauseMenu.alpha = 0.05
                pauseMenu.run(SKAction.fadeAlpha(to: 0.4, duration: 4))
                pauseMenu.zPosition = 5
                self.addChild(pauseMenu)
                
                            let sceneToMoveTo = Level2(size: self.size)
                            sceneToMoveTo.scaleMode = self.scaleMode
                            let sceneTransition = SKTransition.doorsOpenVertical(withDuration: 0.4)
                            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                
                //                ExplosionController.makeShatter(position: self.playerController.position, parent: self)
                //                self.physicsWorld.speed = 0.3
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !firstTap {
            tapToStartNode.removeFromParent()
            playerController.view.physicsBody?.isDynamic = true
            playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: 150)
            firstTap = true
            
            for touch: AnyObject in touches {
                let touchPos = touch.location(in: self)
                let tappedNode = atPoint(touchPos)
                let nameOfTappedNode = tappedNode.name
                
                if nameOfTappedNode == "TTTA" {
                    tappedNode.alpha = 0.5
                    
                }
            }
        }
    }
}

func random_Int(min : Int, max : Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}

func random(min : CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(max - min + 1))) + min
}



