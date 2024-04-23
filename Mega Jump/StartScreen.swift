//
//  SwiftUIView.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 4/16/24.
//

import SpriteKit
import GameplayKit

class StartScreen: SKScene, SKPhysicsContactDelegate {
    let playbutt = SKTexture(imageNamed: "F2C97135-A8F6-4995-9B1E-071E31B48D82")
    var play = SKSpriteNode()
    override func didMove(to view: SKView) {
        createBackground()
        createButton()
    }
    func createBackground() {
        let imageName = "f0b8d6fc41d58e868b348cc33881093f.jpg"
        let stars = SKTexture (imageNamed: imageName)
        for i in 0...1 {
            let starsBackground = SKSpriteNode (texture: stars)
            let scaleX = size.width / starsBackground.size.width
            let scaleY = size.height / starsBackground.size.height
            let scaleFactor = max(scaleX, scaleY)
            starsBackground.setScale(scaleFactor)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat (i))
            addChild(starsBackground)
        }
    }
    func createButton() {
        play = SKSpriteNode(texture: playbutt, size: CGSize(width: 100, height: 60))
        play.position = CGPoint(x: 0, y: -75)
        
        // Set the name and enable user interaction
        play.name = "playButton"
        play.isUserInteractionEnabled = true
        // Add the button node to the scene
        addChild(play)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check if any touch event occurred
        guard let touch = touches.first else { return }
        
        // Get the location of the touch in this scene
        let touchLocation = touch.location(in: self)
        
        // Check if the play button node is touched
        if play.contains(touchLocation) {
            // Transition to the next scene (e.g., NextScene)
            let nextScene = GameScene(size: self.size)
            
            // Present the next scene with a crossfade transition
            self.view?.presentScene(nextScene, transition: SKTransition.crossFade(withDuration: 0.5))
        }
    }
}


