//
//  SKViewController.swift
//  C
//
//  Created by Joseph William Santoso on 13/12/23.
//

import UIKit
import SpriteKit

class SKViewController: UIViewController {
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
}

class GameScene: SKScene {
    
    var userRectangle: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score = 0
    var userRectangleSize = CGSize(width: 50, height: 50)
    var smallerRectangleSpeed: CGFloat = 5.0
    var largerRectangleSpeed: CGFloat = 3.0
    
    override func didMove(to view: SKView) {
        setupGame()
        spawnRectangles()
    }
    
    func setupGame() {
        backgroundColor = UIColor.cyan
        
        userRectangle = SKSpriteNode(color: UIColor.green, size: userRectangleSize)
        userRectangle.position = CGPoint(x: size.width / 4, y: size.height / 2)
        addChild(userRectangle)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 50)
        addChild(scoreLabel)
    }
    
    func spawnRectangles() {
        // Spawn smaller rectangles
        let spawnAction = SKAction.run {
            let smallerRectangle = self.createRectangle(color: UIColor.red, size: CGSize(width: 30, height: 30))
            smallerRectangle.position = CGPoint(x: self.size.width + smallerRectangle.size.width / 2,
                                                y: CGFloat.random(in: smallerRectangle.size.height / 2...(self.size.height - smallerRectangle.size.height / 2)))
            self.addChild(smallerRectangle)
            
            let moveAction = SKAction.moveTo(x: -smallerRectangle.size.width / 2, duration: TimeInterval(self.size.width / self.smallerRectangleSpeed))
            let removeAction = SKAction.removeFromParent()
            let sequence = SKAction.sequence([moveAction, removeAction])
            smallerRectangle.run(sequence)
        }
        
        let waitAction = SKAction.wait(forDuration: 1.0)
        let spawnSequence = SKAction.sequence([spawnAction, waitAction])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        run(spawnForever)
        
        // Spawn larger rectangles
        let spawnLargerAction = SKAction.run {
            let largerRectangle = self.createRectangle(color: UIColor.blue, size: CGSize(width: 60, height: 60))
            largerRectangle.position = CGPoint(x: self.size.width + largerRectangle.size.width / 2,
                                               y: CGFloat.random(in: largerRectangle.size.height / 2...(self.size.height - largerRectangle.size.height / 2)))
            self.addChild(largerRectangle)
            
            let moveAction = SKAction.moveTo(x: -largerRectangle.size.width / 2, duration: TimeInterval(self.size.width / self.largerRectangleSpeed))
            let removeAction = SKAction.removeFromParent()
            let sequence = SKAction.sequence([moveAction, removeAction])
            largerRectangle.run(sequence)
        }
        
        let spawnLargerSequence = SKAction.sequence([waitAction, spawnLargerAction, waitAction])
        let spawnLargerForever = SKAction.repeatForever(spawnLargerSequence)
        run(spawnLargerForever)
    }
    
    func createRectangle(color: UIColor, size: CGSize) -> SKSpriteNode {
        let rectangle = SKSpriteNode(color: color, size: size)
        return rectangle
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle user input here
        // For example, move the userRectangle up or down based on touch location
    }
    
    func updateScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func gameOver() {
        // Implement game over logic
        print("Game Over")
    }
}
