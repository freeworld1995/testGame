//
//  Constants.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 11/22/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

struct BitMask {
    static let PLAYER = UInt32(1 << 1)
    static let ENEMY = UInt32(1 << 2)
    static let CHANGE_COLOR = UInt32(1 << 3)
    static let WALL = UInt32(1 << 4)
    static let WALL_FOR_PLAYER = UInt32(1 << 5)
    static let ANOTHER_WALL = UInt32(1 << 7)
}

struct Speed {
    static let PLAYER = 435
    static let ENEMY = 375
    static let CHANGECOLOR = 335
}

