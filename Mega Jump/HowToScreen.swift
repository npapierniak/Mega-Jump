//
//  HowToScreen.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 4/27/24.
//

import SpriteKit
import GameplayKit

class HowToScreen: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        createBackground()
        
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
    }
