//
//  MenuScene.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/19.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var sceneManagerDelegate: SceneManagerDelegate?
    
    override func didMove(to view: SKView) {
        setupMenu()
    }
    
    func setupMenu() {
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.aspectScaleToSize(frame.size, width: true, multiplier: 1.0)
        background.zPosition = ZPosition.hudBackground
        addChild(background)
        
        let button = SpriteKitButton(defaultButtonImage: "playButton", action: goToLevelScene, index: 0)
        button.position = CGPoint(x: frame.midX, y: frame.midY/2)
        button.aspectScaleToSize(size, width: false, multiplier: 0.2)
        button.zPosition = ZPosition.hudLabel
        addChild(button)
    }
    
    func goToLevelScene(_: Int) {
        sceneManagerDelegate?.presentLevelScene()
    }
    
}
