//
//  GameScene.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 4/16/24.
//

// Umesh's comment

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var player = SKSpriteNode()
    var gameCamera = SKCameraNode()
    var moveLeft = false
    var moveRight = false
    var jump = false
    var x = 0
    var y = 0
    var w = 0
    var h = 0
    var block = SKSpriteNode()
    var winBlock = SKSpriteNode()
    var playingGame = false
    var playLabel = SKLabelNode ()
    override func didMove(to view: SKView) {
        //this stuff happens when game opens
        let extendedFrame = CGRect(x: frame.origin.x - 500,
                                   y: frame.origin.y - 50,
                                   width: frame.size.width + 1000,
                                   height: frame.size.height + 100)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: extendedFrame)
        physicsWorld.contactDelegate = self
        physicsBody?.restitution = 0.0
        
        camera = gameCamera
        addChild(gameCamera)
        
        resetGame()
    }
    
    func resetGame() {
        //this stuff happens before every game
        makePlayer()
        addControlButton()
        createBlocks()
        makeWinBlock()
    }
    func createBlocks(){
        makeBlock(x: 0, y: -150, w : 180, h : 20)
        makeBlock(x: -150, y: -150, w : 180, h : 20)
    }
    func addControlButton() {
        let moveLeftButton = UIButton(type: .system)
        moveLeftButton.setTitle("Move Left", for: .normal)
        moveLeftButton.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        moveLeftButton.addTarget(self, action: #selector(moveLeftPressed), for: .touchDown)
        moveLeftButton.addTarget(self, action: #selector(moveLeftReleased), for: [.touchUpInside, .touchUpOutside])
        
        let moveRightButton = UIButton(type: .system)
        moveRightButton.setTitle("Move Right", for: .normal)
        moveRightButton.frame = CGRect(x: 50, y: 150, width: 200, height: 50)
        moveRightButton.addTarget(self, action: #selector(moveRightPressed), for: .touchDown)
        moveRightButton.addTarget(self, action: #selector(moveRightReleased), for: [.touchUpInside, .touchUpOutside])
        
        
        let jumpButton = UIButton(type: .system)
        jumpButton.setTitle("Jump", for: .normal)
        jumpButton.frame = CGRect(x: 630, y: 200, width: 200, height: 50)
        jumpButton.addTarget(self, action: #selector(jumpPressed), for: .touchDown)
        
        if let gameView = view {
            gameView.addSubview(moveLeftButton)
            gameView.addSubview(moveRightButton)
            gameView.addSubview(jumpButton)
        }
    }
    
    @objc func moveLeftPressed() {
        moveLeft = true
    }
    
    @objc func moveLeftReleased() {
        moveLeft = false
    }
    
    @objc func moveRightPressed() {
        moveRight = true
    }
    
    @objc func moveRightReleased() {
        moveRight = false
    }
    
    @objc func jumpPressed() {
        if jump {
            player.physicsBody?.applyForce(CGVector(dx: 0, dy: 2600))

            jump = false

        }
    }
    func makeWinBlock() {
        winBlock = SKSpriteNode(color: .green, size: CGSize(width: 200, height: 30))
        winBlock.position = CGPoint(x: 200, y: -75)
        winBlock.name = "winBlock"
        winBlock.physicsBody = SKPhysicsBody (rectangleOf: winBlock.size)
        winBlock.physicsBody?.isDynamic = false
        addChild(winBlock)
    }
    func makePlayer() {
        player.removeFromParent()
        
        
        let playerSize = CGSize(width: 40, height: 40)
        player = SKSpriteNode(color: .red, size: playerSize)
        
        
        player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        player.position = CGPoint(x: -200, y: -100)
        player.physicsBody?.restitution = 0.0
        
        player.physicsBody?.contactTestBitMask = (player.physicsBody?.collisionBitMask)!
        player.physicsBody?.affectedByGravity = true
        
        
        addChild(player)
        
    }
    func makeBlock(x: CGFloat, y: CGFloat, w : CGFloat, h : CGFloat) {
        let leather = SKTexture(imageNamed: "images-3")
        block = SKSpriteNode(texture: leather, size: CGSize(width: w, height: h))
        
        block.position = CGPoint(x: x, y: y)
        block.name = "Block"
        block.physicsBody = SKPhysicsBody (rectangleOf: block.size)
        block.physicsBody?.isDynamic = false
        block.physicsBody?.restitution = 0.0
        
        addChild(block)
    }
    
    override func update (_ currentTime: TimeInterval) {
        
        
        if (player.physicsBody?.velocity.dy == 0) {
            jump = true
        }
        
        
        if moveLeft {
            player.physicsBody?.velocity.dx = -250
        }
        else if moveRight {
            player.physicsBody?.velocity.dx = 250
        }
        else {
            player.physicsBody?.velocity.dx = 0
        }
        
        
        gameCamera.position = player.position
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name ==
            "winBlock" ||
            contact.bodyB.node?.name == "winBlock"{
            gameOver(winner: false)
        }
    }
    func gameOver (winner: Bool) {
        playingGame = false
        playLabel.alpha = 1
        resetGame()
        if winner {
            playLabel.text = "You win! Tap to play again"
        }
    }
}
