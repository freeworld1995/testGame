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

class View: SKShapeNode {
    var handleContact: HandleContactType?
    var handleChangeColor: HandleChangeColor?
}
