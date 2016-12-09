//
//  Utils.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/26/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import UIKit
import GameKit

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
    
    static func moveToRight (position : CGPoint, rect : CGRect, speed : CGFloat) -> SKAction{
        let dx = rect.width
        let dy = position.y
        let distance = sqrt(dx*dx+dy*dy)
        let time = distance/speed
        return SKAction.move(to: CGPoint(x:rect.width, y:0), duration: TimeInterval(time))
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

extension Array{
    func random3Colors() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
    
}

extension UIColor{
   
    enum ColorEnum: String {
        case RED
        case GREEN
        case BLUE
        
        func toColor() -> UIColor {
            switch self {
            case .RED:
                
                return .init(red:0.86, green:0.21, blue:0.13, alpha:1.0)
            case .BLUE:
                return .init(red:0.13, green:0.33, blue:0.47, alpha:1.0)
            case .GREEN:
                return .init(red:0.35, green:0.56, blue:0.15, alpha:1.0)
                
                
            }
        }
    }
    
    static func fromString(name: String) ->UIColor{
        return (ColorEnum(rawValue: name)?.toColor())!
        
    }
   static func randColor() -> UIColor {
        var arrayColor: [UIColor] = [cRED, cGREEN, cBLUE]
        arrayColor = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: arrayColor) as! [UIColor]
        
        return arrayColor[0]
    }
    
}

extension UIBezierPath{
    
    static   func setPath(positionX: CGFloat, positionY: CGFloat, view: UIView) -> [UIBezierPath] {
        let path1: UIBezierPath = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: 0))
        path1.addLine(to: CGPoint(x: -100, y: -view.frame.size.height * 0.7))
        path1.addLine(to: CGPoint(x: 100, y: -view.frame.size.height * 0.3))
        path1.addLine(to: CGPoint(x: 50, y : -view.frame.size.height * 0.1))
        path1.addLine(to: CGPoint(x: 0, y: -view.frame.size.height - 30))
        
        
        let path2: UIBezierPath = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: 0))
        path2.addLine(to: CGPoint(x: -100, y: -view.frame.size.height * 0.7))
        path2.addLine(to: CGPoint(x: 100, y: -view.frame.size.height * 0.3))
        path2.addLine(to: CGPoint(x: 50, y : -view.frame.size.height * 0.1))
        path2.addLine(to: CGPoint(x: 0, y: -view.frame.size.height - 30))
        
        let path3Left: UIBezierPath = UIBezierPath()
        path3Left.move(to: CGPoint(x: 0, y: 0))
        path3Left.addCurve(to: CGPoint(x: 0, y: -view.frame.size.height), controlPoint1: CGPoint(x: view.frame.size.width * 0.8, y : -view.frame.size.height * 0.3) , controlPoint2: CGPoint(x: -view.frame.size.width * 0.8, y: -view.frame.size.height * 0.7))
        
        let path3Right: UIBezierPath = UIBezierPath()
        path3Right.move(to: CGPoint(x: 0, y: 0))
        path3Right.addCurve(to: CGPoint(x: 0, y: -view.frame.size.height), controlPoint1: CGPoint(x: -view.frame.size.width * 0.8, y : -view.frame.size.height * 0.3) , controlPoint2: CGPoint(x: view.frame.size.width * 0.8, y: -view.frame.size.height * 0.7))
        
        
        if (positionX < view.frame.size.width / 2) {
            return [path1, path2, path3Right]
        }
        else {
            return [path1, path2, path3Left]
        }
    }
}

