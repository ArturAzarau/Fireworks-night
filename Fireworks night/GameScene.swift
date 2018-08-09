//
//  GameScene.swift
//  Fireworks night
//
//  Created by Артур Азаров on 09.08.2018.
//  Copyright © 2018 Артур Азаров. All rights reserved.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    // MARK: - Properties
    
    // Score
    private var gameScore: SKLabelNode = {
        let gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.horizontalAlignmentMode = .center
        gameScore.fontSize = 48
        return gameScore
    }()
    
    private var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    // Timer
    private var gameTimer: Timer!
    private var fireworks = [SKNode]()
    
    // Launching offsets
    private let leftEdge = -22
    private let bottomEdge = -22
    private let rightEdge = 1024 + 22
    
    // MARK: - Scene life cycle
    
    override func didMove(to view: SKView) {
        createBackground()
        createTimer()
    }
    
    // MARK: - Touches handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // MARK: - Methods
    
    // Background creation
    private func createBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    
    // Timer
    private func createTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
    }
    
    // Launch fireworks
    @objc private func launchFireworks() {
        let movementAmount: CGFloat = 1800
        
        switch GKRandomSource.sharedRandom().nextInt(upperBound: 4) {
        case 0:
            // fire five, straight up
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
            
        case 1:
            // fire five, in a fan
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)
            
        case 2:
            // fire five, from the left to the right
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
            
        case 3:
            // fire five, from the right to the left
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
        default:
            break
        }
    }
    
    // Create fireworks
    private func createFirework(xMovement: CGFloat, x: Int, y: Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch GKRandomSource.sharedRandom().nextInt(upperBound: 3) {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .green
        case 2:
            firework.color = .red
        default:
            break
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        
        fireworks.append(node)
        addChild(node)
    }
}
