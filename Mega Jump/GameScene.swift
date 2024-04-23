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
    
    override func didMove(to view: SKView) {
        //this stuff happens when game opens
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        resetGame()
    }
    
    func resetGame() {
        //this stuff happens before every game
        makePlayer()
        
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
    
}
