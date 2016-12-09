//
//  Controller.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class Controller {
    let view: View
    weak var parent: Scene!
    var shootAction: SKAction?
    var moveAction: SKAction?
    init(view: View, color: UIColor) {
        self.view = view
        self.view.fillColor = color
    }
    
    deinit {
        print("Controller deinited")
    }

    
    func config(position: CGPoint, parent: Scene, shootAction: SKAction?, moveAction: SKAction?) {
        self.view.position = position
        self.parent = parent
        self.shootAction = shootAction
        self.moveAction = moveAction
        parent.addChild(self.view)
    }
    
    func configExplosion(parent: Scene) {
        self.parent = parent
        parent.addChild(self.view)
    }
    
    var width: CGFloat {
        get {
            return self.view.frame.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.view.frame.size.height
        }
    }
    
    var position: CGPoint {
        get {
            return self.view.position
        }
    }
}
