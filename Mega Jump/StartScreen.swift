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
        let imageName = "F2C97135-A8F6-4995-9B1E-071E31B48D82"
        let playbutt = SKTexture (imageNamed: imageName)
        let play = SKSpriteNode (texture: playbutt, size: CGSize(width: 100, height: 60))
        play.position = CGPoint (x: 0, y: -75)
        play.physicsBody = SKPhysicsBody(rectangleOf: play.size)
        play.physicsBody?.isDynamic = false
        addChild(play)
    }
}


