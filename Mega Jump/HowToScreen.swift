//
//  HowToScreen.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 4/27/24.
//

import SpriteKit
import GameplayKit

class HowToScreen: SKScene, SKPhysicsContactDelegate {
    var player = SKSpriteNode()
    var moveLeft = false
    var moveRight = false
    var jump = false
    var x = 0
    var y = 0
    var w = 0
    var h = 0
    var block = SKSpriteNode()
    var leftLabel = SKLabelNode ()
    var rightLabel = SKLabelNode ()
    var jumpLabel = SKLabelNode ()
    var startScene: SKScene!
    override func didMove(to view: SKView) {
        createBackground()
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        resetGame()
    }
    
    func resetGame() {
        makePlayer()
        addControlButton()
        createBlocks()
    }
    
    func createBlocks(){
        makeBlock(x: -140, y: -140, w : 180, h : 20)
        makeBlock(x: 80, y: -40, w : 160, h : 20)
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
        back.setTitle("Main Screen", for: .normal)
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
            player.physicsBody?.applyForce(CGVector(dx: 0, dy: 2600))
        }
    }
    
    func makePlayer() {
        player.removeFromParent()
        
        
        let playerSize = CGSize(width: 40, height: 40)
        player = SKSpriteNode(color: .red, size: playerSize)
        
        
        player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        player.position = CGPoint(x: -300, y: -175)
        player.physicsBody?.restitution = 0.0
        
        
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
        player.physicsBody?.restitution = 0.0
        
        addChild(block)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
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
    }
    
    func makeLabels() {
        leftLabel.fontSize = 20
        leftLabel.text = "Move left"
        leftLabel.fontName = "Arial"
        leftLabel.position = CGPoint(x: -100, y: 100)
        addChild(leftLabel)
        
        rightLabel.fontSize = 20
        rightLabel.text = "Move right"
        rightLabel.fontName = "Arial"
        rightLabel.position = CGPoint(x: -100, y: 0)
        addChild (rightLabel)
        
        jumpLabel.fontSize = 20
        jumpLabel.text = "Jump up"
        jumpLabel.fontColor = .black
        jumpLabel.fontName = "Arial"
        jumpLabel.position = CGPoint(x: frame.maxX - 50, y: frame.minY + 18)
        addChild(jumpLabel)
    }
    
    func createBackground() {
        let imageName = "IMG_0981"
        let rock = SKTexture (imageNamed: imageName)
        for i in 0...1 {
            let rockBackground = SKSpriteNode (texture: rock)
            let scaleX = size.width / rockBackground.size.width
            let scaleY = size.height / rockBackground.size.height
            let scaleFactor = max(scaleX, scaleY)
            rockBackground.setScale(scaleFactor)
            rockBackground.zPosition = -1
            rockBackground.position = CGPoint(x: 0, y: rockBackground.size.height * CGFloat (i))
            addChild(rockBackground)
        }
    }
    
    @objc func backButton() {
        removeAllButtons()
        let transition = SKTransition.fade(withDuration: 1)
        startScene = SKScene(fileNamed: "StartScene")
        self.view?.presentScene(startScene, transition: transition)
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
}
