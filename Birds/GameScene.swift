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
    var pinchRecognizer = UIPinchGestureRecognizer()
    var maxScale : CGFloat = 0
    
    override func didMove(to view: SKView) {
        setupLevel()
        setupGestureRecognizer()
    }
    
    
    
    // MARK: - Setup level(获得指向TileMapNode的var,用于setup camera constraint)
    
    func setupLevel(){
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
            maxScale = mapNode.mapSize.width / frame.width
            print(maxScale)
        }
        setupCamera()
    }
    
    // MARK: - Setup Camera
    
    func setupCamera() {
        gameCamera.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gameCamera)
        
        camera = gameCamera
        gameCamera.xScale = maxScale  // 开始时将相机缩放至最小，显示整个场景
        gameCamera.yScale = maxScale
        gameCamera.setConstraints(with: self, frame: mapNode.frame)
    }
    
    // MARK: - Setup Gesture Recognizers
    
    func setupGestureRecognizer(){
        guard let gameSceneView = view else { fatalError("no view in the GameScene") }
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        gameSceneView.addGestureRecognizer(panRecognizer)
        
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        gameSceneView.addGestureRecognizer(pinchRecognizer)
    }
    
}

// MARK: - Gesture Methods

extension GameScene {
    @objc func pan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view) * gameCamera.yScale  // configure to allow CGPoint * CGFloat
        //        print("translation: \(translation)")  手指向左下↙移动时，translation值为(-, +)
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        sender.setTranslation(.zero, in: view)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        if sender.numberOfTouches == 2 {
            // move the camera, so it zooms from where you pinch
            let locationInView = sender.location(ofTouch: 1, in: view)
            let locationB4 = convertPoint(fromView: locationInView)
            
            if sender.state == .changed {
                let newScale = gameCamera.xScale / sender.scale  // 相机的xScale和sender.scale相反，缩小数值拉近镜头
                if newScale <= maxScale && newScale >= 0.75 {  // 设置相机缩放的上下限
                    gameCamera.setScale(newScale)
                }
                
                let locationAfter = convertPoint(fromView: locationInView)
                let locationDelta = locationB4 - locationAfter  // configure to allow +- CGPoint
                let newPostion = gameCamera.position + locationDelta
                gameCamera.position = newPostion
                
                sender.scale = 1.0
                gameCamera.setConstraints(with: self, frame: mapNode.frame)
            }
        }
    }
}
