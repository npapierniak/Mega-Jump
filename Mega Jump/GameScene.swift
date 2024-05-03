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
    var x = 0
    var y = 0
    var w = 0
    var h = 0
    var block = SKSpriteNode()
    override func didMove(to view: SKView) {
        //this stuff happens when game opens
        let extendedFrame = CGRect(x: frame.origin.x - 500, // Adjust as needed
                                   y: frame.origin.y - 50, // Adjust as needed
                                   width: frame.size.width + 1000, // Adjust as needed
                                   height: frame.size.height + 100)
        camera = gameCamera
        addChild(gameCamera)
        
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: extendedFrame)
        resetGame()
    }
    
    func resetGame() {
        //this stuff happens before every game
        makePlayer()
        addControlButton()
        createBlocks()
    }
    func createBlocks(){
        makeBlock(x: 0, y: -100, w : 180, h : 20)
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
        
        if let gameView = view {
            gameView.addSubview(moveLeftButton)
            gameView.addSubview(moveRightButton)
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
    
    func makePlayer() {
        player.removeFromParent()
        
        // Create a new player node (cube)
        let playerSize = CGSize(width: 40, height: 40)  // Specify the size of the cube
        player = SKSpriteNode(color: .red, size: playerSize)  // Create a red cube (you can change the color)
        
        // Set up physics properties for the player
        player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)  // Use a rectangular physics body for the cube
        // Set the position of the player (for example, center of the scene)
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        
        // Add the player node to the scene
        addChild(player)
        
    }
    func makeBlock(x: CGFloat, y: CGFloat, w : CGFloat, h : CGFloat) {
        let leather = SKTexture(imageNamed: "images-3")
        block.removeFromParent ()
        block = SKSpriteNode(texture: leather, size: CGSize(width: w, height: h))
        //remove the paddle, if it exists
        block.position = CGPoint(x: x, y: y)
        block.name = "Block"
        block.physicsBody = SKPhysicsBody (rectangleOf: block.size)
        block.physicsBody?.isDynamic = false
        addChild(block)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Move player left if the button is pressed
        if moveLeft {
            player.physicsBody?.velocity = CGVector(dx: -100, dy: 0)  // Adjust the velocity as needed
        }
        else if moveRight {
            player.physicsBody?.velocity = CGVector(dx: 100, dy: 0)  // Adjust the velocity as needed
        }
        else {
            player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)  // Stop player if button is released
        }
        
        // Update camera position to follow the player
        gameCamera.position = player.position
    }
    
}
