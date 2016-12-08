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
}

extension CGFloat {
    var convertToInt: Int { return Int(self) }
}

//extension CGPath {
//    var getPolygonPath: CGPath {
//        let polygonPath = UIBezierPath()
//        polygonPath.move(to: CGPoint(x: 0, y: 37.5))
//        polygonPath.addLine(to: CGPoint(x: 35.66, y: 11.59))
//        polygonPath.addLine(to: CGPoint(x: 22.04, y: -30.34))
//        polygonPath.addLine(to: CGPoint(x: -22.04, y: -30.34))
//        polygonPath.addLine(to: CGPoint(x: -35.66, y: 11.59))
//        polygonPath.close()
//        
//        return polygonPath.cgPath
//    }
//    
//    var getTrianglePath: CGPath {
//        let trianglePath = UIBezierPath()
//        trianglePath.move(to: CGPoint(x: -37.5, y: -31.5))
//        trianglePath.addCurve(to: CGPoint(x: 0, y: 43.5), controlPoint1: CGPoint(x: -0.58, y: 42.35), controlPoint2: CGPoint(x: 0, y: 43.5))
//        trianglePath.addLine(to: CGPoint(x: 37.5, y: -31.5))
//        trianglePath.addLine(to: CGPoint(x: -37.5, y: -31.5))
//        return trianglePath.cgPath
//    }
//}

extension SKAction {
    static func moveToPath(position: CGPoint,  rect: CGRect, duration: TimeInterval) -> SKAction {
        let bezier = UIBezierPath(rect: CGRect(x: position.x, y: position.y, width: 100, height: 100))
        return SKAction.follow(bezier.cgPath, asOffset: true, orientToPath: false, duration: duration)
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



