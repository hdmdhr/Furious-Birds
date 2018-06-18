//
//  Bird.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/16.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

enum BirdType: String {
    case red, blue, yellow, grey  // "red", "blue", "yellow", "grey"
}

class Bird: SKSpriteNode {
    
    let birdType: BirdType
    var grabbed = false
    var flying = false {
        didSet {
            if flying {
                physicsBody?.isDynamic = true
                constraints?.removeAll()
            }
        }
    }
    
    init(type: BirdType) {
        birdType = type
        
        let color: UIColor!
        switch type {
        case .red:
                color = .red
        case .blue:
                color = .blue
        case .yellow:
            color = .yellow
        case .grey:
            color = .lightGray
        }
        super.init(texture: nil, color: color, size: CGSize(width: 40, height: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
