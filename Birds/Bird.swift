//
//  Bird.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/16.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

enum BirdType: String {
    case red, blue, yellow, gray  // "red", "blue", "yellow", "gray"
}

class Bird: SKSpriteNode {
    
    let birdType: BirdType
    var grabbed = false {
        didSet {
            if grabbed {
                animateFlight(active: true)
            }
        }
    }
    var flying = false {
        didSet {
            if flying {
                physicsBody?.isDynamic = true
                constraints?.removeAll()
                animateFlight(active: true)
            } else {
                animateFlight(active: false)
            }
        }
    }
    
    let flyingFrames: [SKTexture]
    
    init(type: BirdType) {
        birdType = type
        flyingFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: birdType.rawValue), withName: type.rawValue)
        
        let texture = SKTexture(imageNamed: birdType.rawValue + "1")
        
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateFlight(active: Bool) {
        if active {
            run(SKAction.repeatForever(SKAction.animate(with: flyingFrames, timePerFrame: 0.1, resize: true, restore: true)))
        } else {
            removeAllActions()
        }
    }
    
}
