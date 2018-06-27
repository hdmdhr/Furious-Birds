//
//  Enemy.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/26.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

enum EnemyType: String {
    case orange  // can add more enemy types later
}

class Enemy: SKSpriteNode {

    let type: EnemyType
    var health: Int
    let damageThreshold: Int
    let animationFrames: [SKTexture]
    
    init(type: EnemyType = .orange) {
        self.type = type
        switch type {
        case .orange:
            health = 200
        }
        damageThreshold = health/2
        
        animationFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: type.rawValue), withName: type.rawValue)
        
        let texture = SKTexture(imageNamed: type.rawValue + "1")
        super.init(texture: texture, color: .clear, size: .zero)
        animateEnemy()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPhysicsBody(){
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = PhysicsCategory.enemy
        physicsBody?.contactTestBitMask = PhysicsCategory.all
        physicsBody?.collisionBitMask = PhysicsCategory.all
    }
    
    func animateEnemy(healthy: Bool = true) {
        if healthy {
            run(SKAction.repeatForever(SKAction.animate(with: animationFrames, timePerFrame: 0.25, resize: false, restore: true)))
        } else {
            run(SKAction.repeatForever(SKAction.animate(with: animationFrames, timePerFrame: 0.45, resize: false, restore: true)))
        }
    }
    
    func impact(with force: CGFloat) -> Bool {
        health -= Int(force)
        if health < 1 {
            removeFromParent()
            return true
        } else if health <= damageThreshold {
            alpha = 0.75
            animateEnemy(healthy: false)
        }
        return false
    }
    
}
