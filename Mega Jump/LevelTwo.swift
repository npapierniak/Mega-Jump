//
//  LevelTwo.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 5/20/24.
//

import SpriteKit
import GameplayKit

class LevelTwo: SKScene, SKPhysicsContactDelegate {
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
    var platform = SKSpriteNode()
    var playingGame = false
    var playLabel = SKLabelNode()
    var startScene: SKScene!
    var moveLeftButton = UIButton()
    var moveRightButton = UIButton()
    var jumpButton = UIButton()
    override func didMove(to view: SKView) {
        let extendedFrame = CGRect(
            x: frame.origin.x - 1000,
            y: frame.origin.y - 200,
            width: frame.size.width + 2000,
            height: frame.size.height + 400
        )
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: extendedFrame)
        physicsWorld.contactDelegate = self
        physicsBody?.restitution = 0.0
        
        camera = gameCamera
        addChild(gameCamera)
        
        resetGame()
    }
    
    func resetGame() {
        makePlayer()
        addControlButton()
        createBlocks()
        makeWinBlock()
    }
    
    func removeAllButtons() {
        if let gameView = view {
            for subview in gameView.subviews {
                if let button = subview as? UIButton {
                    button.removeFromSuperview()
                }
            }
        }
    }
    
    func createBlocks(){
        makeBlock(x: -190, y: -290, w : 55, h : 20, loseBlock: false)
        makeBlock(x: -190, y: 80, w : 55, h : 20, loseBlock: false)
        makeBlock(x: 190, y: 80, w : 55, h : 20, loseBlock: false)
        makeBlock(x: -190, y: -90, w : 55, h : 20, loseBlock: false)
        makeBlock(x: 190, y: -90, w : 55, h : 20, loseBlock: false)
        makeBlock(x: 0, y: -190, w : 55, h : 20, loseBlock: false)
        makeBlock(x: 0, y: -10, w : 55, h : 20, loseBlock: false)
        makeBlock(x: 190, y: -290, w : 55, h : 20, loseBlock: false)
        makeBlock(x: -225, y: -150, w : 20, h : 200, loseBlock: true)
        makeBlock(x: 225, y: -150, w : 20, h : 200, loseBlock: true)
        makeBlock(x: -225, y: 0, w : 20, h : 200, loseBlock: true)
        makeBlock(x: 225, y: 0, w : 20, h : 200, loseBlock: true)
        makeBlock(x: -225, y: -300, w : 20, h : 200, loseBlock: true)
        makeBlock(x: 225, y: -300, w : 20, h : 200, loseBlock: true)
    }
    func makeWinBlock() {
        winBlock = SKSpriteNode(color: .green, size: CGSize(width: 200, height: 30))
        winBlock.position = CGPoint(x: 520, y: -75)
        winBlock.physicsBody = SKPhysicsBody (rectangleOf: winBlock.size)
        winBlock.physicsBody?.isDynamic = false
        platform = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 15))
        platform.position = CGPoint(x: 520, y: -50)
        platform.name = "winBlock"
        platform.physicsBody = SKPhysicsBody (rectangleOf: platform.size)
        platform.physicsBody?.isDynamic = false
        addChild(winBlock)
        addChild(platform)
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
        
        let back = UIButton(type: .system)
        back.setTitle("I QUIT", for: .normal)
        back.frame = CGRect(x: -10, y: 50, width: 200, height: 50)
        back.addTarget(self, action: #selector(backButton), for: .touchDown)
        
        if let gameView = view {
            gameView.addSubview(moveLeftButton)
            gameView.addSubview(moveRightButton)
            gameView.addSubview(jumpButton)
            gameView.addSubview(back)
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
            player.physicsBody?.applyForce(CGVector(dx: 0, dy: 2800))
        }
    }
    
    @objc func backButton() {
        removeAllButtons()
        let transition = SKTransition.fade(withDuration: 1)
        startScene = SKScene(fileNamed: "LevelScreen")
        self.view?.presentScene(startScene, transition: transition)
    }
    
    func makePlayer() {
        player.removeFromParent()
        let playerSize = CGSize(width: 40, height: 40)
        player = SKSpriteNode(color: .red, size: playerSize)
        player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        player.position = CGPoint(x: 0, y: -350)
        player.physicsBody?.restitution = 0.0
        player.physicsBody?.contactTestBitMask = (player.physicsBody?.collisionBitMask)!
        player.physicsBody?.affectedByGravity = true
        addChild(player)
    }
    
    func makeBlock(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, loseBlock: Bool) {
        let leather = SKTexture(imageNamed: "images-3")
        let red = SKTexture(imageNamed: "red-abstract-textured-grunge-web-background-vector")
        
        if loseBlock {
            block = SKSpriteNode(texture: red, size: CGSize(width: w, height: h))
            block.name = "loseBlock"
            block.position = CGPoint(x: x, y: y)
            block.physicsBody = SKPhysicsBody (rectangleOf: block.size)
            block.physicsBody?.isDynamic = false
            block.physicsBody?.restitution = 0.0
        }
        else {
            block = SKSpriteNode(texture: leather, size: CGSize(width: w, height: h))
            block.position = CGPoint(x: x, y: y)
            block.name = "Block"
            block.physicsBody = SKPhysicsBody (rectangleOf: block.size)
            block.physicsBody?.isDynamic = false
            block.physicsBody?.restitution = 0.0
        }
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
        
        if contact.bodyA.node?.name == "winBlock" || contact.bodyB.node?.name == "winBlock" {
            gameOver(winner: false)
        }
        
        if contact.bodyA.node?.name == "loseBlock" || contact.bodyB.node?.name == "loseBlock" {
            resetGame()
        }
    }
    
    func addBack()
    {
        let back = UIButton(type: .system)
        back.setTitle("Back", for: .normal)
        back.frame = CGRect(x: -10, y: 50, width: 200, height: 50)
        back.addTarget(self, action: #selector(backButton), for: .touchDown)
        if let gameView = view {
            gameView.addSubview(back)
        }
    }
    
    func gameOver (winner: Bool) {
        playingGame = false
        playLabel.alpha = 1
        removeAllButtons()
        addBack()
        let transition = SKTransition.fade(withDuration: 1)
        startScene = SKScene(fileNamed: "LevelScreen")
        self.view?.presentScene(startScene, transition: transition)
    }
}
