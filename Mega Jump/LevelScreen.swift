//
//  LevelScreen.swift
//  Mega Jump
//
//  Created by Nicholas Papierniak on 5/20/24.
//

import SpriteKit
import GameplayKit

class LevelScreen: SKScene {
    var first = SKSpriteNode()
    let firstButton = SKTexture(imageNamed: "Screenshot 2024-05-20 at 9.15.17 AM")
    var second = SKSpriteNode()
    let secondButton = SKTexture(imageNamed: "Level 2")
    var third = SKSpriteNode()
    let thirdButton = SKTexture(imageNamed: "Level 3")
    var levelScene: SKScene!
    override func didMove(to view: SKView) {
        createBackground()
        createButtons()
    }
    func createButtons()
    {
        level1()
        level2()
        level3()
        back()
    }
    func createBackground() {
        let imageName = "9b3dbba790a33941b330a86480271cb2"
        let level = SKTexture (imageNamed: imageName)
        for i in 0...1 {
            let levelBackground = SKSpriteNode (texture: level)
            let scaleX = size.width / levelBackground.size.width
            let scaleY = size.height / levelBackground.size.height
            let scaleFactor = max(scaleX, scaleY)
            levelBackground.setScale(scaleFactor)
            levelBackground.zPosition = -2
            levelBackground.position = CGPoint(x: 0, y: levelBackground.size.height * CGFloat (i))
            addChild(levelBackground)
        }
    }
    func level1() {
        first = SKSpriteNode(texture: firstButton, size: CGSize(width: 100, height: 50))
        first.position = CGPoint(x: -155, y: 50)
        first.name = "firstButton"
        addChild(first)
    }
    func level2() {
        second = SKSpriteNode(texture: secondButton, size: CGSize(width: 100, height: 50))
        second.position = CGPoint(x: 100, y: 25)
        second.name = "secondButton"
        addChild(second)
    }
    func level3() {
        third = SKSpriteNode(texture: thirdButton, size: CGSize(width: 100, height: 50))
        third.position = CGPoint(x: 325, y: -40)
        third.name = "thirdButton"
        addChild(third)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "firstButton"  {
                removeAllButtons()
                let transition = SKTransition.fade(withDuration: 1)
                levelScene = SKScene(fileNamed: "GameScene")
                self.view?.presentScene(levelScene, transition: transition)
            }
            if touchedNode.name == "secondButton" {
                removeAllButtons()
                let transition = SKTransition.fade(withDuration: 1)
                levelScene = SKScene(fileNamed: "LevelTwoScene")
                self.view?.presentScene(levelScene, transition: transition)
            }
            if touchedNode.name == "thirdButton" {
                removeAllButtons()
                let transition = SKTransition.fade(withDuration: 1)
                levelScene = SKScene(fileNamed: "LevelThreeScene")
                self.view?.presentScene(levelScene, transition: transition)
            }
        }
    }
    func back()
    {
        let back = UIButton(type: .system)
        back.setTitle("Back", for: .normal)
        back.frame = CGRect(x: -10, y: 50, width: 200, height: 50)
        back.addTarget(self, action: #selector(backButton), for: .touchDown)
        if let gameView = view {
            gameView.addSubview(back)
        }
    }
    @objc func backButton() {
        removeAllButtons()
        let transition = SKTransition.fade(withDuration: 1)
        levelScene = SKScene(fileNamed: "StartScene")
        self.view?.presentScene(levelScene, transition: transition)
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
