//
//  GameScene.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class Level1: Scene, SKPhysicsContactDelegate {
    
    let playerController = PlayerController()
    var cameraNode: SKCameraNode!
    var arrayEnemyPosition: [CGPoint] = []
    var maxSpawningTurn: Int = 0
    var maxEnemyInScene: Int = 3
    var arrayAddChangeColor: [() -> ()] = []
    var addChangeColorTimer: Timer!
    var arrayExstingEnemies: [EnemyController] = []
    var player: AVAudioPlayer?
    var alreadyCalledReplay = false
    
    deinit {
        print("Level1 deinited")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        
        makeCameraShake = { [unowned self] in
            self.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.4, amplitudeX: 14, amplitudeY: 9))
        }
        
        makeReplay = { [unowned self] in
            self.replay()
        }
        
        addBackground()
        addPhysics()
        addGestureRecognizer(to: view)
        addWall()
        addCamera()
        arrayAddChangeColor.append(addChangeColorTop)
        arrayAddChangeColor.append(addChangeColorLeft)
        arrayAddChangeColor.append(addChangeColorRight)
        configPlayer()
        addNextButton()
        spawnEnemy()
        backGroundMusic()
        
        addChangeColorTimer = Timer.scheduledTimer(timeInterval: 2.3, target: self, selector: #selector(addChangeColor), userInfo: nil, repeats: true)
        //
        //        let pauseMenu = SKSpriteNode(color: UIColor.black, size: self.frame.size)
        //        pauseMenu.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        //        pauseMenu.alpha = 0.4
        //        pauseMenu.zPosition = 5
        //        addChild(pauseMenu)
        
    }
    
    
    
    func addNextButton() {
        let nextButton = SKSpriteNode(imageNamed: "next")
        nextButton.name = "next"
        nextButton.position = CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.9)
        addChild(nextButton)
    }
    
    func configPlayer() -> Void {
        let playerPosition = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playerController.config(position: playerPosition, parent: self, shootAction: nil, moveAction: nil)
        self.playerController.didDestroyEnemy = { [unowned self] in
            self.maxEnemyInScene -= 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.playerController.view.contacted = false
            }
        }
    }
    
    func addChangeColor() {
        arrayAddChangeColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayAddChangeColor) as! [() -> ()]
        arrayAddChangeColor[0]()
    }
    
    lazy var addChangeColorTop : () -> () = { [unowned self] in
        let changeColorController = ChangeColorController(color: UIColor.randColor())
        let randPosX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.width.convertToInt / 5, highestValue: self.size.width.convertToInt * 9 / 10)
        changeColorController.config(position: CGPoint(x: randPosX.nextInt(), y: self.size.height.convertToInt), parent: self, shootAction: nil, moveAction: nil)
        changeColorController.view.physicsBody?.velocity = CGVector.goDown(velocity: Speed.CHANGECOLOR)
    }
    
    lazy var addChangeColorLeft : () -> () = { [unowned self] in
        let changeColorController = ChangeColorController(color: UIColor.randColor())
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        changeColorController.config(position: CGPoint(x: 0, y: randPosY.nextInt()), parent: self, shootAction: nil, moveAction: nil)
        changeColorController.view.physicsBody?.velocity = CGVector.goRight(velocity: Speed.CHANGECOLOR)
    }
    
    lazy var addChangeColorRight : () -> () = { [unowned self] in
        let changeColorController = ChangeColorController(color: UIColor.randColor())
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        changeColorController.config(position: CGPoint(x: self.size.width.convertToInt, y: randPosY.nextInt()), parent: self, shootAction: nil, moveAction: nil)
        changeColorController.view.physicsBody?.velocity = CGVector.goLeft(velocity: Speed.CHANGECOLOR)
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
        
        for i in 1...2 {
            let xPos = fabs(arrayEnemyPosition[0].x - arrayEnemyPosition[i].x)
            let yPos = fabs(arrayEnemyPosition[0].y - arrayEnemyPosition[i].y)
            
            if ((xPos < 70) || (yPos < 70)) {
                randomEnemyPosition()
            }
        }
    }
    
    func spawnEnemy() {
        randomEnemyPosition()
        
        for i in 1...3 {
            let enemyController = EnemyController(shape: Shape.getStarPath() , color: UIColor.randColor())
            enemyController.view.physicsBody?.affectedByGravity = true
            enemyController.view.physicsBody?.restitution = 1.0
            enemyController.config(position: arrayEnemyPosition[i - 1], parent: self, shootAction: nil, moveAction: nil)
            enemyController.activateAutoChangeColor()
            arrayExstingEnemies.append(enemyController)
        }
        maxSpawningTurn += 1
        self.maxEnemyInScene = 3
    }
    
    override func update(_ currentTime: TimeInterval) {
        if maxSpawningTurn != 3 {
            if self.maxEnemyInScene == 0 {
                spawnEnemy()
            }
        }
        if maxSpawningTurn == 3 {
            replay()
        }
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
                //                background.contacted = true
                ExplosionController.makeShatter(position: self.playerController.position, parent: self)
                otherView.removeFromParent()
                for enemy in self.arrayExstingEnemies {
                    enemy.timer.invalidate()
                    //                    enemy.view.removeFromParent()
                }
                
                self.replay()
            }
        }
        addChild(background)
    }
    
    func backGroundMusic()  {
        let url = Bundle.main.url(forResource: "ultraflow", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            print("music")
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func replay() {
        self.addChangeColorTimer.invalidate()
        
        player?.stop()
        
        for enemy in self.arrayExstingEnemies {
            enemy.timer.invalidate()
        }
        
        if alreadyCalledReplay != true {
            alreadyCalledReplay = true
            player?.stop()
            // Access UserDefaults
            let defaults = UserDefaults.standard
            
            // Get "currentLevel"
            let currentLevel = defaults.integer(forKey: "currentlevel")
            // load scene with the "currentLevel"
            let newGameScene = SKScene(fileNamed: "Level\(currentLevel)")
            //        let newGameScene = Level1(size: self.frame.size)
            newGameScene?.size = self.frame.size
            newGameScene?.scaleMode = .aspectFill
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [unowned self] in
                self.view?.presentScene(newGameScene)
     
            }
        }
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
        playerController.view.physicsBody?.velocity = CGVector(dx: Speed.PLAYER, dy: 0)
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        playerController.view.physicsBody?.velocity = CGVector(dx: -Speed.PLAYER, dy: 0)
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: Speed.PLAYER)
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        playerController.view.physicsBody?.velocity = CGVector(dx: 0, dy: -Speed.PLAYER)
    }
    
    func changeScene() {
        for enemy in self.arrayExstingEnemies {
            enemy.timer.invalidate()
        }
        
        let defaults = UserDefaults.standard
        let currentLevel = defaults.integer(forKey: "currentlevel")
        let newGameScene = SKScene(fileNamed: "Level\(currentLevel+1)")
        newGameScene?.size = self.frame.size
        newGameScene?.scaleMode = .aspectFill
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [unowned self] in
            self.view?.presentScene(newGameScene)
            self.removeAllChildren()
            self.removeAllActions()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let touchePos = touch.location(in: self)
            let tappedNode = atPoint(touchePos)
            let nameOfTappedNode = tappedNode.name
            
            // check if we click on something that don't have a 'NAME'
            guard nameOfTappedNode != nil else {return}
            
            if nameOfTappedNode == "next" {
                for enemy in self.arrayExstingEnemies {
                    enemy.timer.invalidate()
                }
                
                let defaults = UserDefaults.standard
                let currentLevel = defaults.integer(forKey: "currentlevel")
                let newGameScene = SKScene(fileNamed: "Level\(currentLevel+1)")
                newGameScene?.size = self.frame.size
                newGameScene?.scaleMode = .aspectFill
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [unowned self] in
                    self.view?.presentScene(newGameScene)
                    self.removeAllChildren()
                    self.removeAllActions()
                }
            }
        }
    }
}
