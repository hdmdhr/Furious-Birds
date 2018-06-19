//
//  Block.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/18.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

enum BlockType: String {
    case wood, stone, glass
}

class Block: SKSpriteNode {
    
    let type: BlockType
    var health: Int
    let damageThreshold: Int
    
    init(type: BlockType) {
        self.type = type
        switch type {
        case .wood:
            health = 200
        case .stone:
            health = 500
        case .glass:
            health = 50
        }
        damageThreshold = health/2
        super.init(texture: nil, color: .clear, size: .zero)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPhysicsBody(){
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.block
        physicsBody?.contactTestBitMask = PhysicsCategory.all
        physicsBody?.collisionBitMask = PhysicsCategory.all
    }
    
    func impact(with force: CGFloat) {
        health -= Int(force)
        print("Block \(type.rawValue) Health left: \(health)")
        if health < 1 {
            removeFromParent()
        } else if health <= damageThreshold {
            // TODO: - change texture
            color = .red
        }
    }
    
}
