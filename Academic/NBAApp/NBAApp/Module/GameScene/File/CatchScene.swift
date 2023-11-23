//
//  HockeyScene.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import SpriteKit

class CatchGameScene: SKScene {
    let basket = SKSpriteNode(color: UIColor(named: "TextColor") ?? .white, size: CGSize(width: 100, height: 30))

    override func didMove(to view: SKView) {
        backgroundColor = SKColor(named: "PrimaryColor") ?? .white

        // Add the basket
        basket.position = CGPoint(x: size.width / 2, y: 50)
        basket.name = "basket" // Set a name for easy identification
        addChild(basket)

        // Start spawning falling objects
        spawnFallingObjects()
    }

    func spawnFallingObjects() {
        let waitAction = SKAction.wait(forDuration: 1.0) // Adjust the duration as needed

        let spawnAction = SKAction.run {
            self.spawnObject()
        }

        let sequence = SKAction.sequence([waitAction, spawnAction])
        let repeatForever = SKAction.repeatForever(sequence)

        run(repeatForever)
    }

    func spawnObject() {
        let randomX = CGFloat.random(in: 0..<size.width)
        let fallingObject = SKSpriteNode(color: UIColor(named: "SelectedColor") ?? .white, size: CGSize(width: 20, height: 20))
        fallingObject.position = CGPoint(x: randomX, y: size.height)
        fallingObject.name = "fallingObject" // Set a name for easy identification
        addChild(fallingObject)

        let fallAction = SKAction.moveTo(y: 0, duration: 5.0) // Adjust the duration as needed
        let removeAction = SKAction.removeFromParent()

        fallingObject.run(SKAction.sequence([fallAction, removeAction]))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            basket.position.x = location.x
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Check for collisions between falling objects and the basket
        enumerateChildNodes(withName: "fallingObject") { node, _ in
            if let fallingObject = node as? SKSpriteNode {
                if fallingObject.frame.intersects(self.basket.frame) {
                    fallingObject.removeFromParent()
                    // Handle scoring or other game logic here
                }
            }
        }
    }
}




