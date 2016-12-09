//
//  Utils.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/26/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

extension SKAction {
    class func shake(initialPosition:CGPoint, duration:Float, amplitudeX:Int = 12, amplitudeY:Int = 3) -> SKAction {
        let startingX = initialPosition.x
        let startingY = initialPosition.y
        let numberOfShakes = duration / 0.015
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let newXPos = startingX + CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let newYPos = startingY + CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            actionsArray.append(SKAction.move(to: CGPoint(x: newXPos, y: newYPos), duration: 0.015))
        }
        actionsArray.append(SKAction.move(to: initialPosition, duration: 0.015))
        return SKAction.sequence(actionsArray)
    }
    
    static func moveToPath(position: CGPoint,  rect: CGRect, duration: TimeInterval) -> SKAction {
        let bezier = UIBezierPath(rect: CGRect(x: position.x, y: position.y, width: 100, height: 100))
        return SKAction.follow(bezier.cgPath, asOffset: true, orientToPath: false, duration: duration)
    }

}

extension CGFloat {
    var convertToInt: Int { return Int(self) }
}

extension SKScene {
    static func sceneWithClassNamed(className: String, fileNamed fileName: String) -> SKScene? {
        guard let SceneClass = NSClassFromString("testPlatformer.\(className)") as? SKScene.Type,
            let scene = SceneClass.init(fileNamed: fileName) else {
                return nil
        }
        
        return scene
    }
}

extension CGVector {
    static func goUp(velocity: Int) -> CGVector {
        return CGVector(dx: 0, dy: velocity)
    }
    
    static func goDown(velocity: Int) -> CGVector {
        return CGVector(dx: 0, dy: -velocity)
    }
    
    static func goLeft(velocity: Int) -> CGVector {
        return CGVector(dx: -velocity, dy: 0)
    }
    
    static func goRight(velocity: Int) -> CGVector {
        return CGVector(dx: velocity, dy: 0)
    }
}



