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
        polygonPath.move(to: CGPoint(x: 35, y: 70))
        polygonPath.addLine(to: CGPoint(x: 68.29, y: 45.82))
        polygonPath.addLine(to: CGPoint(x: 55.57, y: 6.68))
        polygonPath.addLine(to: CGPoint(x: 14.43, y: 6.68))
        polygonPath.addLine(to: CGPoint(x: 1.71, y: 45.82))
        polygonPath.close()
        
        return polygonPath.cgPath
    }
    
    static func getTrianglePath() -> CGPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0, y: 0))
        trianglePath.addCurve(to: CGPoint(x: 37.5, y: 74.95), controlPoint1: CGPoint(x: 39.82, y: 79.58), controlPoint2: CGPoint(x: 37.5, y: 74.95))
        trianglePath.addLine(to: CGPoint(x: 75, y: 0))
        trianglePath.addLine(to: CGPoint(x: 0, y: 0))
        
        return trianglePath.cgPath
    }
    
    static func getStarPath() -> CGPath {
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 35, y: 0))
        starPath.addLine(to: CGPoint(x: 47.34, y: 18.01))
        starPath.addLine(to: CGPoint(x: 68.29, y: 24.18))
        starPath.addLine(to: CGPoint(x: 54.97, y: 41.49))
        starPath.addLine(to: CGPoint(x: 55.57, y: 63.32))
        starPath.addLine(to: CGPoint(x: 35, y: 56))
        starPath.addLine(to: CGPoint(x: 14.43, y: 63.32))
        starPath.addLine(to: CGPoint(x: 15.03, y: 41.49))
        starPath.addLine(to: CGPoint(x: 1.71, y: 24.18))
        starPath.addLine(to: CGPoint(x: 22.66, y: 18.01))
        starPath.close()
        
        return starPath.cgPath
    }
}
