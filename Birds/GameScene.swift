//
//  GameScene.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/14.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit
import GameplayKit

enum RoundState {
    case ready, flying, finished
}

class GameScene: SKScene {
    
    var mapNode = SKTileMapNode()
    let gameCamera = GameCamera()
    var panRecognizer = UIPanGestureRecognizer()
    var pinchRecognizer = UIPinchGestureRecognizer()
    var maxScale : CGFloat = 0
    
    var bird = Bird(type: .red)
    var birds = [Bird(type: .red), Bird(type: .blue), Bird(type: .yellow)]
    let anchor = SKNode()
    
    var roundState: RoundState = .ready
    
    override func didMove(to view: SKView) {
        setupLevel()
        setupGestureRecognizer()
    }
    
    // MARK: - Setup level(获得实际的TileMapNode变量,用于set camera constraint)
    
    func setupLevel(){
        if let mapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = mapNode
            maxScale = mapNode.mapSize.width / frame.width
            print(maxScale)
        }
        setupCamera()
        
        let rect = CGRect(x: 0, y: mapNode.tileSize.height, width: mapNode.frame.width, height: mapNode.frame.height - mapNode.tileSize.height)
        physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        physicsBody?.categoryBitMask = PhysicsCategory.edge
//        physicsBody?.contactTestBitMask = PhysicsCategory.bird | PhysicsCategory.block
//        physicsBody?.collisionBitMask = PhysicsCategory.all
        
        anchor.position = CGPoint(x: mapNode.frame.midX/2, y: mapNode.frame.midY/2)
        addChild(anchor)
        addBird()
    }
    
    // MARK: - User touches and moves the bird
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch roundState {
        case .ready:
            if let touch = touches.first {
                let location = touch.location(in: self)
                if bird.contains(location) {
                    // 1.disable pan 2.change grabbed to true 3.change bird position to finger's location
                    panRecognizer.isEnabled = false
                    bird.grabbed = true
                    bird.position = location
                }
            }
        case .flying:
            break
        case .finished:
            let moveCameraBackAction = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY), duration: 2.0)
            moveCameraBackAction.timingMode = .easeInEaseOut
            gameCamera.run(moveCameraBackAction) {
                self.panRecognizer.isEnabled = true
                self.addBird()
                self.roundState = .ready
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if bird.grabbed {
                let location = touch.location(in: self)
                bird.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bird.grabbed {
            gameCamera.setConstraints(with: self, frame: mapNode.frame, to: bird)
            bird.grabbed = false
            bird.flying = true
            
            let impulse = CGVector(dx: anchor.position.x - bird.position.x, dy: anchor.position.y - bird.position.y)
            bird.physicsBody?.applyImpulse(impulse)
//            bird.isUserInteractionEnabled = false
            roundState = .flying
        }
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
    
    // MARK: - Add bird and Constraint Bird to Anchor
    
    func addBird(){
        if birds.isEmpty {
            print("No more birds")
        } else {
            bird = birds.removeFirst()
            
            bird.physicsBody = SKPhysicsBody(rectangleOf: bird.size)
            bird.physicsBody?.categoryBitMask = PhysicsCategory.bird
            bird.physicsBody?.contactTestBitMask = PhysicsCategory.all
            bird.physicsBody?.collisionBitMask = PhysicsCategory.block | PhysicsCategory.edge
            bird.physicsBody?.isDynamic = false
            bird.position = anchor.position
            
            addChild(bird)
            constraintToAnchor()
        }
    }
    
    func constraintToAnchor() {
            let slingRange = SKRange(lowerLimit: 0.0, upperLimit: bird.size.width * 4)
            let birdConstraint = SKConstraint.distance(slingRange, to: anchor)  // a circular range
            bird.constraints = [birdConstraint]
    }
    
    // MARK: - Setup Gesture Recognizers
    
    func setupGestureRecognizer(){
        guard let gameSceneView = view else { fatalError("no view in the GameScene") }
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        gameSceneView.addGestureRecognizer(panRecognizer)
        
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        gameSceneView.addGestureRecognizer(pinchRecognizer)
    }
    
    // MARK: - When bird come to rest
    
    override func didSimulatePhysics() {
        guard let birdBody = bird.physicsBody else { return }
        if roundState == .flying && birdBody.isResting {
            gameCamera.setConstraints(with: self, frame: mapNode.frame)
            bird.removeFromParent()
            roundState = .finished
        }
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
