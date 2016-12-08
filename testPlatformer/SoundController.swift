//
//  SoundController.swift
//  testPlatformer
//
//  Created by Jimmy Hoang on 12/7/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import AVFoundation

struct Sound {
    static let instance = Sound()
    
    static let shatter = SKAudioNode(fileNamed: "ping.wav")
    static let backgroundMusic = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "ultraflow", ofType: "wav")!))
}
