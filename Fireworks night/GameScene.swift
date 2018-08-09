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
    private let rightEdge = -22
    private let bottomEdge = 1024 + 22
    
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
    
    @objc private func launchFireworks() {
        
    }
}
