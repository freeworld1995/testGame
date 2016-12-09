//
//  View.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

typealias HandleContactType = (View) -> ()

typealias HandleChangeColor = () -> ()

typealias DestroyType = () -> ()

class View: SKShapeNode {
    var handleContact: HandleContactType?
    var handleChangeColor: HandleChangeColor?
    var contacted = false
    var destroy: DestroyType?
    
    deinit {
        print("View deinited")
    }
}
