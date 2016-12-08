//
//  GameScene.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class Level1: SKScene, SKPhysicsContactDelegate {
    
    let playerController = PlayerController.instance
    static var cameraNode: SKCameraNode!
    //    var arrayColor: [UIColor] = [cRED, cGREEN, cBLUE]
    //
    //    func randColor() {
    //        arrayColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayColor) as! [UIColor]
    //        print(arrayColor[0])
    //    }
    
    var arrayEnemyPosition: [CGPoint] = []
    var maxSpawningTurn: Int = 0
    static var maxEnemyInScene: Int = 3
    var arrayAddChangeColor: [() -> ()] = []
    
    override init(size: CGSize) {
        super.init(size: size)
        
        //        spawnEnemy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("GameScene deinited")
    }
    
    override func didMove(to view: SKView) {
        self.removeAllChildren()
        
        if let recognizers = view.gestureRecognizers {
            for recognizer in recognizers {
                view.removeGestureRecognizer(recognizer)
                
            }
        }
        addBackground()
        addPhysics()
        addGestureRecognizer(to: view)
        addWall()
        addCamera()
        arrayAddChangeColor.append(addChangeColorTop)
        arrayAddChangeColor.append(addChangeColorLeft)
        arrayAddChangeColor.append(addChangeColorRight)
        
//        let enemyController = EnemyController()
//        enemyController.config(position: CGPoint(x: 300, y: 500), parent: self, shootAction: nil, moveAction: nil)
        let playerPosition = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playerController.config(position: playerPosition, parent: self, shootAction: nil, moveAction: nil)
        spawnEnemy()
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(addChangeColor), userInfo: nil, repeats: true)
        //        let pauseMenu = SKSpriteNode(color: UIColor.black, size: self.frame.size)
        //        pauseMenu.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        //        pauseMenu.alpha = 0.4
        //        pauseMenu.zPosition = 5
        //        addChild(pauseMenu)
    }
    
    func addChangeColor() {
        arrayAddChangeColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayAddChangeColor) as! [() -> ()]
        arrayAddChangeColor[0]()
    }
//    
//    func changeScene() {
//        playerController.view.removeFromParent()
//        self.removeAllActions()
//        self.removeAllChildren()
//        self.removeFromParent()
//        self.scene?.removeFromParent()
//        self.scene?.removeAllChildren()
//        let newGameScene = GameScene(size: self.frame.size)
//        newGameScene.scaleMode = .aspectFill
//        
//        self.view!.presentScene(newGameScene)
//
//    }
    
    func addChangeColorTop() {
        let changeColorController = ChangeColorController()
        changeColorController.randColor()
        let randPosX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.width.convertToInt / 5, highestValue: self.size.width.convertToInt * 9 / 10)
        changeColorController.config(position: CGPoint(x: randPosX.nextInt(), y: self.size.height.convertToInt), parent: self, shootAction: nil, moveAction: nil)
        changeColorController.view.physicsBody?.velocity = CGVector.goDown(velocity: 500)
    }
    
    func addChangeColorLeft() {
        let changeColorController = ChangeColorController()
        changeColorController.randColor()
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        changeColorController.config(position: CGPoint(x: 0, y: randPosY.nextInt()), parent: self, shootAction: nil, moveAction: nil)
        changeColorController.view.physicsBody?.velocity = CGVector.goRight(velocity: 500)
    }
    
    func addChangeColorRight() {
        let changeColorController = ChangeColorController()
        changeColorController.randColor()
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        changeColorController.config(position: CGPoint(x: self.size.width.convertToInt, y: randPosY.nextInt()), parent: self, shootAction: nil, moveAction: nil)
        changeColorController.view.physicsBody?.velocity = CGVector.goLeft(velocity: 500)
    }
    
    func randomEnemyPosition() {
        arrayEnemyPosition.removeAll()
        
        for _ in 1...3 {
            let randPosX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.width.convertToInt / 5, highestValue: self.size.width.convertToInt * 9 / 10)
            let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
            
            let enemyPosition = CGPoint(x: randPosX.nextInt(), y: randPosY.nextInt())
            arrayEnemyPosition.append(enemyPosition)
        }
        
        for enemyPos in arrayEnemyPosition {
            let xPos = fabs(playerController.position.x - enemyPos.x)
            let yPos = fabs(playerController.position.y - enemyPos.y)
            
            if ((xPos < 40) || (yPos < 40)) {
                randomEnemyPosition()
            }
        }
        
//        for i in 1...2 {
//            let xPos = fabs(arrayEnemyPosition[0].x - arrayEnemyPosition[i].x)
//            let yPos = fabs(arrayEnemyPosition[0].y - arrayEnemyPosition[i].y)
//            
//            if ((xPos < 70) || (yPos < 70)) {
//                randomEnemyPosition()
//            }
//        }
    }
    
    static func minusMaxEnemy() {
        Level1.maxEnemyInScene -= 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            PlayerController.instance.view.contacted = false
        }
    }
    
    func spawnEnemy() {
        randomEnemyPosition()
        
        for i in 1...3 {
            let enemyController = EnemyController()
            enemyController.config(position: arrayEnemyPosition[i - 1], parent: self, shootAction: nil, moveAction: nil)
            enemyController.activateAutoChangeColor()
        }
        maxSpawningTurn += 1
        Level1.maxEnemyInScene = 3
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //        cameraNode.position = playerController.position
        if maxSpawningTurn != 3 {
            if Level1.maxEnemyInScene == 0 {
                spawnEnemy()
            }
        }
    }
    
    func convert(point: CGPoint)->CGPoint {
        return self.view!.convert(CGPoint(x: point.x, y:self.view!.frame.height-point.y), to:self)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let viewA = contact.bodyA.node as? View, let viewB = contact.bodyB.node as? View
            else {
                return
        }
        
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
        Level1.cameraNode = SKCameraNode()
        addChild(Level1.cameraNode)
        camera = Level1.cameraNode
        Level1.cameraNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
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
                background.contacted = true
                Level1.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.5, amplitudeX: 11, amplitudeY: 5))
                
                ExplosionController.makeShatter(parent: self, color: UIColor(red:0.56, green:0.55, blue:0.63, alpha:1.0))
                otherView.removeFromParent()
                let newGameScene = Level1(size: self.frame.size)
                newGameScene.scaleMode = .aspectFill
                
                self.view!.presentScene(Level1(size: self.frame.size))

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
    
}
