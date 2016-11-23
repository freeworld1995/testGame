//
//  View.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

typealias HandleContactType = (View) -> ()

typealias HandleHeart = () -> ()

class View: SKSpriteNode {
    var handleContact: HandleContactType?
    var handleHeart: HandleHeart?
}
