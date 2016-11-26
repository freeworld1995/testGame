//
//  Shape.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/25/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class Shape {
    static func getPolygonPath() -> CGPath {
        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 0, y: 37.5))
        polygonPath.addLine(to: CGPoint(x: 35.66, y: 11.59))
        polygonPath.addLine(to: CGPoint(x: 22.04, y: -30.34))
        polygonPath.addLine(to: CGPoint(x: -22.04, y: -30.34))
        polygonPath.addLine(to: CGPoint(x: -35.66, y: 11.59))
        polygonPath.close()
        
        return polygonPath.cgPath
    }
    
    static func getTrianglePath() -> CGPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: -37.5, y: -31.5))
        trianglePath.addCurve(to: CGPoint(x: 0, y: 43.5), controlPoint1: CGPoint(x: -0.58, y: 42.35), controlPoint2: CGPoint(x: 0, y: 43.5))
        trianglePath.addLine(to: CGPoint(x: 37.5, y: -31.5))
        trianglePath.addLine(to: CGPoint(x: -37.5, y: -31.5))
        return trianglePath.cgPath
    }

    static func getStarPath() -> CGPath {
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 0, y: 37.5))
        starPath.addLine(to: CGPoint(x: 13.23, y: 18.2))
        starPath.addLine(to: CGPoint(x: 35.66, y: 11.59))
        starPath.addLine(to: CGPoint(x: 21.4, y: -6.95))
        starPath.addLine(to: CGPoint(x: 22.04, y: -30.34))
        starPath.addLine(to: CGPoint(x: 0, y: -22.5))
        starPath.addLine(to: CGPoint(x: -22.04, y: -30.34))
        starPath.addLine(to: CGPoint(x: -21.4, y: -6.95))
        starPath.addLine(to: CGPoint(x: -35.66, y: 11.59))
        starPath.addLine(to: CGPoint(x: -13.23, y: 18.2))
        starPath.close()
        
        
        return starPath.cgPath
    }
    
    static func getOvalPath() -> CGPath {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: -38, y: -38, width: 75, height: 75))
        return ovalPath.cgPath
    }
    
    static func getRectanglePath() -> CGPath {
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: -38, y: -38, width: 75, height: 75), cornerRadius: 8)
        return rectanglePath.cgPath
    }
}
