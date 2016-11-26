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
        starPath.move(to: CGPoint(x: 35, y: 70))
        starPath.addLine(to: CGPoint(x: 47.34, y: 51.99))
        starPath.addLine(to: CGPoint(x: 68.29, y: 45.82))
        starPath.addLine(to: CGPoint(x: 54.97, y: 28.51))
        starPath.addLine(to: CGPoint(x: 55.57, y: 6.68))
        starPath.addLine(to: CGPoint(x: 35, y: 14))
        starPath.addLine(to: CGPoint(x: 14.43, y: 6.68))
        starPath.addLine(to: CGPoint(x: 15.03, y: 28.51))
        starPath.addLine(to: CGPoint(x: 1.71, y: 45.82))
        starPath.addLine(to: CGPoint(x: 22.66, y: 51.99))
        starPath.close()
        
        return starPath.cgPath
    }
    
    static func getOvalPath() -> CGPath {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 87, y: 34, width: 70, height: 70))
        return ovalPath.cgPath
    }
    
    static func getRectanglePath() -> CGPath {
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 70, height: 70), cornerRadius: 8)
        return rectanglePath.cgPath
    }
}
