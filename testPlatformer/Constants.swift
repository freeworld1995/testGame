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
<<<<<<< HEAD
    static let SEVEN_COLORS = UInt32(1 << 9)
    static let PROTECT_TRIANGLE = UInt32(1 << 10)
=======
    static let ENEMY_MUTILLIVES = UInt32(1 << 8)
>>>>>>> 4eb24d87303b366be77dbf10c21b2c948b7ca810
}

struct Speed {
    static let PLAYER = 415
    static let ENEMY = 365
    static let CHANGECOLOR = 325
}

