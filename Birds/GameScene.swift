//
//  GameScene.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/14.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let gameCamera = SKCameraNode()
    
    override func didMove(to view: SKView) {
       addCamera()
    }
    
    func addCamera() {
        gameCamera.position = CGPoint(x: frame.midX, y: frame.midY)
//        gameCamera.position = CGPoint(x: view!.bounds.size.width/2, y: view!.bounds.size.height/2)
        addChild(gameCamera)
        
        camera = gameCamera
    }
    
}
