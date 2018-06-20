//
//  LevelScene.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/19.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

class LevelScene: SKScene {
    
    var sceneManagerDelegate: SceneManagerDelegate?

    override func didMove(to view: SKView) {
        setupLevel()
    }
    
    func setupLevel() {
        var level = 1
        let columnStartingPoint = frame.midX / 2
        let rowStartingPoint = frame.midY + frame.midY/2
        
        for row in 0...2 {
            for column in 0...2 {
                let levelBoxButton = SpriteKitButton(defaultButtonImage: "woodButton", action: goToGameSceneFor, index: level)
                levelBoxButton.position = CGPoint(x: columnStartingPoint + CGFloat(column) * columnStartingPoint, y: rowStartingPoint - CGFloat(row) * frame.midY/2)
                addChild(levelBoxButton)
                
                let levelLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
                levelLabel.fontSize = 200.0
                levelLabel.verticalAlignmentMode = .center
                levelLabel.text = "\(level)"
                levelLabel.zPosition = ZPosition.hudLabel
                levelLabel.aspectScaleToSize(levelBoxButton.size, width: false, multiplier: 0.5)
                levelBoxButton.addChild(levelLabel)
                
                levelBoxButton.zPosition = ZPosition.hudBackground
                levelBoxButton.aspectScaleToSize(size, width: false, multiplier: 0.2)
                
                level += 1
            }
        }
    }
    
    func goToGameSceneFor(level: Int) {
        sceneManagerDelegate?.presentGameScene(level: level)
    }
    
}
