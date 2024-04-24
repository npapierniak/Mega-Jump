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
    var startScene: SKScene!
    override func didMove(to view: SKView) {
        createBackground()
        createButton()
    }
    func createBackground() {
        let imageName = "360_F_621585347_GATWJ061PptsBJqhGpSi6KWIFsxnYnCb"
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
        play.position = CGPoint(x: 0, y: -60)
        play.name = "playButton"
        // Add the button node to the scene
        addChild(play)
    }
    func buttonClicked()
    {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "playButton" {
                let transition = SKTransition.fade(withDuration: 1)
                startScene = SKScene(fileNamed: "GameScene")
                self.view?.presentScene(startScene, transition: transition)
            }
        }
    }
}


