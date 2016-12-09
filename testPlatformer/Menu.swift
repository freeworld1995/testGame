//
//  Menu.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 12/7/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class Menu: Scene, SKPhysicsContactDelegate {
    
    var playerController: PlayerController!
    var cameraNode: SKCameraNode!
    var player: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        self.playerController = PlayerController()
        addBackground()
        addPhysics()
        addCamera()
        backGroundMusic()
        
        makeCameraShake = { [unowned self] in
            self.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.4, amplitudeX: 14, amplitudeY: 9))
        }
        
        
//        let bezier = UIBezierPath(roundedRect: CGRect(x: 125, y: 249, width: 808, height: 276), cornerRadius: 21)
        let bezier = UIBezierPath(roundedRect: CGRect(x: 24, y: 246, width: 982, height: 276), cornerRadius: 21)
        
        
        let action = SKAction.follow(bezier.cgPath, asOffset: false, orientToPath: false, speed: 420)
        playerController.config(position: CGPoint(x: self.size.width / 2, y: self.size.height / 2), parent: self, shootAction: nil, moveAction: action)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let enemy1 = EnemyController(shape: Shape.getStarPath(), color: cRED)
            enemy1.config(position: CGPoint(x: self.size.width / 2, y: self.size.height / 2), parent: self, shootAction: nil, moveAction: action)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let enemy2 = EnemyController(shape: Shape.getPolygonPath(), color: cGREEN)
            enemy2.config(position: CGPoint(x: self.size.width / 2, y: self.size.height / 2), parent: self, shootAction: nil, moveAction: action)
            enemy2.view.fillColor = cGREEN
        }
        
    }
    
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
    
    func addPhysics() {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func addCamera() {
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    }
    
    func addBackground() {
        let background = View(rect: self.frame)
        background.fillColor = cBACKGROUND
        
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        background.physicsBody?.categoryBitMask = BitMask.WALL_FOR_PLAYER
        background.physicsBody?.contactTestBitMask = BitMask.PLAYER
        background.physicsBody?.collisionBitMask = 0
        background.zPosition = -1
        background.handleContact = { [unowned self] otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.PLAYER {

//                Menu.cameraNode.run(SKAction.shake(initialPosition: CGPoint(x: self.size.width / 2, y: self.size.height / 2), duration: 0.4, amplitudeX: 14, amplitudeY: 9))
                
                ExplosionController.makeShatter(position: self.playerController.position, parent: self)
            }
        }
        addChild(background)
     
        let logo = SKSpriteNode(imageNamed: "blocky")
        logo.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.8)
        addChild(logo)
        
        let start = SKSpriteNode(imageNamed: "start")
        start.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2)
        start.name = "start"
        addChild(start)
        
        let option = SKSpriteNode(imageNamed: "option")
        option.position = CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.2)
        option.name = "option"
        addChild(option)
        
        let info = SKSpriteNode(imageNamed: "info")
        info.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.2)
        info.name = "info"
        addChild(info)
        
        let achievement = SKSpriteNode(imageNamed: "achievement")
        achievement.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.2)
        achievement.name = "achievement"
        addChild(achievement)
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
    
    // Click "Start" -> save level number to 1 (Level1)
    func saveCurrentLevel() {
        let defaults = UserDefaults.standard
        defaults.set(1, forKey: "currentlevel")
    }
    
    func moveToLevel1() {
        let sceneToMoveTo = Level1(size: self.frame.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.doorsOpenVertical(withDuration: 0.4)
        self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let touchePos = touch.location(in: self)
            let tappedNode = atPoint(touchePos)
            let nameOfTappedNode = tappedNode.name

            // check if we click on something that don't have a 'NAME'
            guard nameOfTappedNode != nil else {return}
            
            switch nameOfTappedNode! {
            case "start":
                saveCurrentLevel()
                self.removeAllChildren()
                moveToLevel1()
            case "option":
                print("Option scene")
            case "info":
                    print("info scene")
                case "achievement":
                    print("achievement scene")
                default:
                return
            }
            
        }
    }
    
    deinit {
        print("Menu deinited")
    }
}
