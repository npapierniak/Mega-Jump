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
    
    override func didMove(to view: SKView) {
        //this stuff happens when game opens
        camera = gameCamera
        addChild(gameCamera)
        
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        resetGame()
    }
    
    func resetGame() {
        //this stuff happens before every game
        makePlayer()
        addControlButton()
    }
    
    func addControlButton() {
            let button = UIButton(type: .system)
            button.setTitle("Move Left", for: .normal)
            button.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
            button.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside])
            
            if let gameView = view {
                gameView.addSubview(button)
            }
        }
    
    @objc func buttonPressed() {
            moveLeft = true
        }
        
        @objc func buttonReleased() {
            moveLeft = false
        }
    
    func makePlayer() {
        player.removeFromParent()
        
        // Create a new player node (cube)
           let playerSize = CGSize(width: 50, height: 50)  // Specify the size of the cube
           player = SKSpriteNode(color: .red, size: playerSize)  // Create a red cube (you can change the color)
       
        // Set up physics properties for the player
            player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)  // Use a rectangular physics body for the cube
            player.physicsBody?.isDynamic = true  // Allow physics to affect the player
            player.physicsBody?.affectedByGravity = true  // Allow gravity to affect the player
        
        // Set the position of the player (for example, center of the scene)
            player.position = CGPoint(x: frame.midX, y: frame.midY)
            
            // Add the player node to the scene
            addChild(player)
            
    }
    
    override func update(_ currentTime: TimeInterval) {
            // Move player left if the button is pressed
            if moveLeft {
                player.physicsBody?.velocity = CGVector(dx: -100, dy: 0)  // Adjust the velocity as needed
            } else {
                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)  // Stop player if button is released
            }
            
            // Update camera position to follow the player
            gameCamera.position = player.position
        }
    
}
