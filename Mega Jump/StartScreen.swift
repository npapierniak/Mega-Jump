//
//  SwiftUIView.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 4/16/24.
//

import SpriteKit
import GameplayKit

class StartScreen: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        createBackground()
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
}


