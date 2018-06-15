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
    
    var mapNode = SKTileMapNode()
    let gameCamera = GameCamera()
    var panRecognizer = UIPanGestureRecognizer()
    
    override func didMove(to view: SKView) {
        setupLevel()
        setupGestureRecognizer()
    }
    

    
    // MARK: - Setup level(获得指向TileMapNode的var,用于setup camera constraint)
    
    func setupLevel(){
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
        }
        setupCamera()
    }
    
    // MARK: - Setup Camera
    
    func setupCamera() {
        gameCamera.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameCamera)
        
        camera = gameCamera
        gameCamera.setConstraints(with: self, frame: mapNode.frame)
    }
    
    // MARK: - Setup Gesture Recognizers
    
    func setupGestureRecognizer(){
        guard let gameSceneView = view else { fatalError("no view in the GameScene") }
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        
        gameSceneView.addGestureRecognizer(panRecognizer)
    }
    
}

// MARK: - Gesture Methods

extension GameScene {
    @objc func pan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        sender.setTranslation(.zero, in: view)
    }
}
