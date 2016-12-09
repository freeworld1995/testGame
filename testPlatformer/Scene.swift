//
//  Scene.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 12/9/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

typealias ShakeSceneCamera = () -> ()

class Scene: SKScene {
    var makeCameraShake: ShakeSceneCamera?
}