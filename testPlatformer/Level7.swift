//
//  Level7.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 12/10/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class Level7: Scene, SKPhysicsContactDelegate {
    
    let playerController = PlayerController()
    var cameraNode: SKCameraNode!
    var arrayHexagonEnemy: [() -> ()] = []
    var addEnemyTimer: Timer!
    var addChangeColor: Timer!
    var addDoraemonBagColor: Timer!
    var background: View!
    var alreadyCalledReplay = false
    
    var player: AVAudioPlayer?
    
    deinit {
        print("Level7 deinited")
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
<<<<<<< HEAD:testPlatformer/Level7.swift
        addNextButton()
        configPlayer()
        backGroundMusic()
        addSevenColor()
        addProtectTriangle()

    }
    
    func addSevenColor() {
        let sevenColor = SevenColorsController(color: UIColor.randColor())
        sevenColor.config(position: CGPoint(x: self.size.width / 2, y: self.size.height * 0.8), parent: self, shootAction: nil, moveAction: nil)
        sevenColor.activate7Colors()
        //        sevenColor.view.physicsBody?.velocity = CGVector(dx: 0, dy: -700)
        sevenColor.view.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
    }
    
    func addProtectTriangle() {
        let triangle = ProtectTriangleController(color: cPROTECTED)
        triangle.config(position: CGPoint(x: self.size.width * 0.1, y: self.size.height / 2), parent: self, shootAction: nil, moveAction: nil)
        triangle.view.physicsBody?.velocity = CGVector(dx: 60, dy: 0)
    }
    
=======
        arrayHexagonEnemy.append(addEnemyTop)
        arrayHexagonEnemy.append(addEnemyLeft)
        arrayHexagonEnemy.append(addEnemyRight)
        addNextButton()
        configPlayer()
        backGroundMusic()
        
        addEnemyTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
        addChangeColor = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(spawnTriangle), userInfo: nil, repeats: true)
        
//        addDoraemonBagColor = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(spawnDoraemonBag), userInfo: nil, repeats: true)
        
        //        let pauseMenu = SKSpriteNode(color: UIColor.black, size: self.frame.size)
        //        pauseMenu.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        //        pauseMenu.alpha = 0.4
        //        pauseMenu.zPosition = 5
        //        addChild(pauseMenu)\
        //fucktest()
    }
    
//    func fucktest()  {
//        let dusa = multiLivesEnemy(shape: Shape.getHexagonPath(), color: UIColor.randColor())
//        dusa.config(position: CGPoint(x: 500, y:300) , parent:self , shootAction: nil, moveAction: nil)
//    }
>>>>>>> 4eb24d87303b366be77dbf10c21b2c948b7ca810:testPlatformer/Level6.swift
    func backGroundMusic()  {
        let url = Bundle.main.url(forResource: "ultraflow", withExtension: "wav")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            print("music")
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                self.playerController.view.contacted = false
            }
        }
    }
    
<<<<<<< HEAD:testPlatformer/Level7.swift
=======
    func addEnemy() {
        arrayHexagonEnemy = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayHexagonEnemy) as! [() -> ()]
        arrayHexagonEnemy[0]()
    }
    
    lazy var addEnemyTop : () -> () = { [unowned self] in
        let PolygonEnemyController = multiLivesEnemy(shape: Shape.getHexagonPath(), color: UIColor.randColor())
        
        let randPosX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.width.convertToInt / 5, highestValue: self.size.width.convertToInt * 9 / 10)
        PolygonEnemyController.config(position: CGPoint(x: randPosX.nextInt(), y: self.size.height.convertToInt), parent: self, shootAction: nil, moveAction: nil)
        PolygonEnemyController.view.physicsBody?.velocity = CGVector.goDown(velocity: Speed.CHANGECOLOR)
    }
    
    lazy var addEnemyLeft : () -> () = { [unowned self] in
        let PolygonEnemyController = multiLivesEnemy(shape: Shape.getHexagonPath(), color: UIColor.randColor())
        
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        PolygonEnemyController.config(position: CGPoint(x: 0, y: randPosY.nextInt()), parent: self, shootAction: nil, moveAction: nil)
        PolygonEnemyController.view.physicsBody?.velocity = CGVector.goRight(velocity: Speed.CHANGECOLOR)
    }
    
    lazy var addEnemyRight : () -> () = { [unowned self] in
        let PolygonEnemyController = multiLivesEnemy(shape: Shape.getHexagonPath(), color: UIColor.randColor())
        
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        PolygonEnemyController.config(position: CGPoint(x: self.size.width.convertToInt, y: randPosY.nextInt()), parent: self, shootAction: nil, moveAction: nil)
        PolygonEnemyController.view.physicsBody?.velocity = CGVector.goLeft(velocity: Speed.CHANGECOLOR)
    }
    
    
    
    func spawnTriangle() {
        
        let randPosX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.width.convertToInt / 5, highestValue: self.size.width.convertToInt * 9 / 10)
        let randPosY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: self.size.height.convertToInt / 5, highestValue: self.size.height.convertToInt * 9 / 10)
        
        let trianglePosition = CGPoint(x: randPosX.nextInt(), y: randPosY.nextInt())
        
        let triangleController = ChangeColorController(color: UIColor.randColor())
        triangleController.config(position: trianglePosition, parent: self, shootAction: nil, moveAction: nil)
        //            triangleController.selfDestroy()
        let destroy = SKAction.run {
            triangleController.view.removeFromParent()
        }
        
        triangleController.view.run(.sequence([.wait(forDuration: 3.2), destroy]))
        
        //            enemyController.activateAutoChangeColor()
        
    }
    
>>>>>>> 4eb24d87303b366be77dbf10c21b2c948b7ca810:testPlatformer/Level6.swift
    override func update(_ currentTime: TimeInterval) {
        
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
        wall.physicsBody?.contactTestBitMask = BitMask.PLAYER | BitMask.ENEMY | BitMask.CHANGE_COLOR | BitMask.ENEMY_MUTILLIVES
        wall.name = "wall"
        wall.handleContact = { otherView in
            otherView.removeFromParent()
        }
        addChild(wall)
        
    }
    
    func addBackground() {
        background = View(rect: self.frame)
        background.fillColor = cBACKGROUND
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        background.physicsBody?.categoryBitMask = BitMask.WALL_FOR_PLAYER
        background.physicsBody?.contactTestBitMask = BitMask.PLAYER | BitMask.SEVEN_COLORS
        background.physicsBody?.collisionBitMask = BitMask.SEVEN_COLORS
        background.zPosition = -1
        background.handleContact = { [unowned self] otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.PLAYER {
                //                background.contacted = true
                                ExplosionController.makeShatter(position: self.playerController.position, parent: self)
                otherView.removeFromParent()
                //
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //                    self.replay()
                //                }
                self.replay()
            }
            
        }
        addChild(background)
    }
    
    func replay() {
<<<<<<< HEAD:testPlatformer/Level7.swift

=======
        //self.addEnemyTimer.invalidate()
>>>>>>> 4eb24d87303b366be77dbf10c21b2c948b7ca810:testPlatformer/Level6.swift
        //        self.addChangeColor.invalidate()
        // Access UserDefaults
        //        let defaults = UserDefaults.standard
        //
        //        // Get "currentLevel"
        //        let currentLevel = defaults.integer(forKey: "currentlevel")
        //        print(currentLevel)
        // load scene with the "currentLevel"
        if alreadyCalledReplay != true {
            alreadyCalledReplay = true
            player?.stop()
            let newGameScene = Level7(size: self.frame.size)
            newGameScene.size = self.frame.size
            newGameScene.scaleMode = .aspectFill
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
                self.view?.presentScene(newGameScene)
                self.removeAllChildren()
                self.removeAllActions()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let touchePos = touch.location(in: self)
            let tappedNode = atPoint(touchePos)
            let nameOfTappedNode = tappedNode.name
            
            // check if we click on something that don't have a 'NAME'
            guard nameOfTappedNode != nil else {return}
            
            if nameOfTappedNode == "next" {
<<<<<<< HEAD:testPlatformer/Level7.swift
                let newGameScene = Level7(size: self.frame.size)
=======
                let newGameScene = Level6(size: self.frame.size)
>>>>>>> 4eb24d87303b366be77dbf10c21b2c948b7ca810:testPlatformer/Level6.swift
                newGameScene.scaleMode = .aspectFill
                self.view!.presentScene(newGameScene)
            }
        }
    }
}
