//
//  SwiftUIView.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 4/16/24.
//

import SpriteKit
import GameplayKit

class StartScreen: SKScene, SKPhysicsContactDelegate {
    let playbutt = SKTexture(imageNamed: "IMG_0477")
    let howToButton = SKTexture(imageNamed: "IMG_0476")
    var play = SKSpriteNode()
    var how = SKSpriteNode()
    var startScene: SKScene!
    override func didMove(to view: SKView) {
        createBackground()
        createButton()
        createName()
        HowToButton()
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
            starsBackground.zPosition = -2
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat (i))
            addChild(starsBackground)
        }
    }
    
    func createButton() {
        play = SKSpriteNode(texture: playbutt, size: CGSize(width: 100, height: 50))
        play.position = CGPoint(x: 10, y: 0)
        play.name = "playButton"
        // Add the button node to the scene
        addChild(play)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "playButton"  {
                let transition = SKTransition.fade(withDuration: 1)
                startScene = SKScene(fileNamed: "GameScene")
                self.view?.presentScene(startScene, transition: transition)
            }
            if touchedNode.name == "HowToButton" {
                let transition = SKTransition.fade(withDuration: 1)
                startScene = SKScene(fileNamed: "HowToScene")
                self.view?.presentScene(startScene, transition: transition)
            }
        }
    }
    
    func createName()
    {
        let gameName = SKLabelNode()
        gameName.text = "Mega Jump"
        gameName.fontSize = 50
        gameName.fontColor = .black
        gameName.fontName = "Georgia-Bold"
        gameName.position = CGPoint(x: 10, y: 80)
        addChild(gameName)
    }
    
    func HowToButton()
    {
        how = SKSpriteNode(texture: howToButton, size: CGSize(width: 130, height: 50))
        how.position = CGPoint(x: 10, y: -70)
        how.name = "HowToButton"
        // Add the button node to the scene
        addChild(how)
    }
}


