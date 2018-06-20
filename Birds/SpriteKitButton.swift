//
//  SpriteKitButton.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/20.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

class SpriteKitButton: SKSpriteNode {

    var defaultButton: SKSpriteNode
    var action: (Int) -> ()
    var index: Int
    
    init(defaultButtonImage: String, action: @escaping (Int) -> (), index: Int) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        self.action = action
        self.index = index
        
        super.init(texture: nil, color: .clear, size: defaultButton.size)
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defaultButton.alpha = 0.75
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if defaultButton.contains(location) {
                defaultButton.alpha = 0.75
            } else {
                defaultButton.alpha = 1.0
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if defaultButton.contains(location) {
                action(index)
            }
            defaultButton.alpha = 1.0
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        defaultButton.alpha = 1.0
    }
}
