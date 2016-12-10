//
//  PlayerController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import AVFoundation
typealias DidDestroyEnemyType = () -> ()

class PlayerController: Controller {
    
    var border: SKShapeNode!
    var didDestroyEnemy: DidDestroyEnemyType?
    var explosion : AVAudioPlayer!
    init() {
        super.init(view: View(path: Shape.getRectanglePath()), color: cBLUE)
        
        // Add border effect for player
        border = SKShapeNode(path: view.path!)
        border.fillColor = view.fillColor
        border.alpha = 0.2
        let enlargeAction = SKAction.scale(to: 1.18, duration: 0.5)
        let shrinkAction = SKAction.scale(to: 1, duration: 0.5)
        let foreverBorderAction = SKAction.repeatForever(SKAction.sequence([enlargeAction, shrinkAction]))
        border.run(foreverBorderAction)
        view.addChild(border)
        
    }
    
    deinit {
        print("playerController deinited")
    }
    
    override func config(position: CGPoint, parent: Scene, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
//        self.parent = parent
        configPhysics()
        
        // Check if moveAction nil -> don't run configMove
        if moveAction != nil {
            configMove(action: moveAction!)
        }
        
//        self.view.destroy = destroy
    }
    
    func configMove(action: SKAction) {
        view.run(.repeatForever(action))
    }
    
    func destroy() -> Void {
        self.view.removeAllChildren()
        self.view.removeAllActions()
        self.view.removeFromParent()
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(polygonFrom: view.path!)
        view.physicsBody?.usesPreciseCollisionDetection = true
        view.physicsBody?.isDynamic = true
        view.physicsBody?.affectedByGravity = true
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.angularDamping = 0
        view.physicsBody?.categoryBitMask = BitMask.PLAYER
        view.physicsBody?.contactTestBitMask = BitMask.ENEMY | BitMask.CHANGE_COLOR | BitMask.WALL_FOR_PLAYER
        view.physicsBody?.collisionBitMask = 0
        view.zPosition = 1
        view.name = "player"
        
        view.handleContact = { [unowned self] otherView in
            if otherView.physicsBody?.categoryBitMask == BitMask.ENEMY &&
                otherView.fillColor == self.view.fillColor {
                
                // contacted turn ON -> player will no longer contact with other object anymore -> will turn off later
                self.view.contacted = true
                otherView.removeFromParent()
                self.didDestroyEnemy?()
                self.parent.makeCameraShake!()
                ExplosionController.makeShatter(position: self.position, parent: self.parent)
                
                let url = Bundle.main.url(forResource: "ping1", withExtension: "wav")!
                
                do {
                    self.explosion = try AVAudioPlayer(contentsOf: url)
                    guard let player = self.explosion else { return }
                   
                    player.prepareToPlay()
                    player.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
            if otherView.physicsBody?.categoryBitMask == BitMask.WALL_FOR_PLAYER {
                self.parent.makeCameraShake!()
            }
            
            if otherView.physicsBody?.categoryBitMask == BitMask.CHANGE_COLOR {
                otherView.removeFromParent()
                self.border.fillColor = otherView.fillColor
                self.view.fillColor = otherView.fillColor
                self.parent.makeChangeColor?()
            }
        }
        
        
//        view.destroy = { [unowned self] in
//            self.destroy()
//        }
        
    }
}
