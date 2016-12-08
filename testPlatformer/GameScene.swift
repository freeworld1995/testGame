
//  GameScene.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate{
   static var spawnTriangle : Timer!
    
    
    let playerController = PlayerController.instance
    static var cameraNode: SKCameraNode!
   // var hudNode : SKNode!
    let tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")
//    var player : SKNode!
    var changeColor : SKNode!
//    var foreGround : SKNode!
    static let scene = GameScene()
    
//    var arrayColor: [UIColor] = [cRED, cGREEN, cBLUE]
//    
//    func randColor() {
//        arrayColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayColor) as! [UIColor]
//        print(arrayColor[0])
//    }
    
//    override init(size: CGSize){
//        super.init(size: size)
//        
//        foreGround = SKNode()
//        hudNode = SKNode()
//        addChild(hudNode)
//        addChild(foreGround)
//        player = addPlayer()
//        //foreGround.addChild(player)
//     //   changeColor = addChangColorController()
//        
//        tapToStartNode.position = CGPoint(x: self.size.width / 2 , y: 300)
//        hudNode.addChild(tapToStartNode)
//    
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func didMove(to view: SKView) {
        
        addBackground()
        addPhysics()
        addGestureRecognizer(to: view)
        addWall()
        // if addCarera() -> please uncomment update() also !!
        addCamera()
        addChangColorController()
        addPlayer()
    
        tapToStartNode.position = CGPoint(x: self.size.width / 2 , y: 300)
        
        addChild(tapToStartNode)
        let enemyController1 = EnemyController()
        enemyController1.view.fillColor = cRED
        enemyController1.config(position: CGPoint(x: 700, y: 550), parent: self, shootAction: nil, moveAction: nil)
    
        let enemyController2 = EnemyController()
        enemyController2.view.fillColor = cGREEN
        enemyController2.config(position: CGPoint(x: 300, y: 350), parent: self, shootAction: nil, moveAction: nil)
        
        let enemyController3 = EnemyController()
        enemyController3.view.fillColor = cBLUE
        enemyController3.config(position: CGPoint(x: 130, y: 250), parent: self, shootAction: nil, moveAction: nil)
        
        
        
        
        GameScene.spawnTriangle = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(addChangColorController), userInfo: nil, repeats: true)
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
        playerController.view.physicsBody?.isDynamic = false
        
        
        
    }
    
    
   func addChangColorController()  {
        let changeColorController = ChangeColorController()
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
        GameScene.cameraNode = SKCameraNode()
        addChild(GameScene.cameraNode)
        camera = GameScene.cameraNode
        GameScene.cameraNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
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
            
            let sceneToMoveTo = GameScene(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.doorsOpenVertical(withDuration: 0.4)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
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
//                print("Touch PLAYER !!!")
                
                let pauseMenu = SKSpriteNode(color: cBACKGROUND, size: self.frame.size)
                pauseMenu.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
                pauseMenu.alpha = 0.05
                pauseMenu.run(SKAction.fadeAlpha(to: 0.4, duration: 4))
                pauseMenu.zPosition = 5
                self.addChild(pauseMenu)
                GameScene.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.5, amplitudeX: 11, amplitudeY: 5))
                
                ExplosionController.makeShatter(parent: self)
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
    
    func selfWorldSpeed()  {
    
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
        if playerController.view.physicsBody!.isDynamic {
            return
        }
      //  if changeColor.physicsBody!.isDynamic {
       //     return
        //}
        
       
        
        tapToStartNode.removeFromParent()
        playerController.view.physicsBody?.isDynamic = true
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: 150)
        
        for touch: AnyObject in touches {
            let touchPos = touch.location(in: self)
            let tappedNode = atPoint(touchPos)
            let nameOfTappedNode = tappedNode.name
            
       
            
            if nameOfTappedNode == "TTTA" {
                tappedNode.alpha = 0.5
                
            }
        }
    }

       // changeColor.physicsBody?.isDynamic = true
}
   






   func random_Int(min : Int, max : Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    



    func random(min : CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    


