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
        setUp()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func setUp(){
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        skView.layer.cornerRadius = 20
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var score = 0
    
    let bulletCategory: UInt32 = 0x1 << 0
    let meteoriteCategory: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(named: "Background") ?? .white
        physicsWorld.contactDelegate = self
        
        // Add score label
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: size.width - 100, y: size.height - 50)
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        addChild(scoreLabel)
        
        // Start generating meteorites
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(generateMeteorite), SKAction.wait(forDuration: 2.0)])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Shoot on tap
        if let touch = touches.first {
            let location = touch.location(in: self)
            shootBullet(at: location)
        }
    }
    
    func generateMeteorite() {
        let meteorite = SKSpriteNode(imageNamed: "meteorite")
        
        // Randomize meteorite size
        let randomSize = CGFloat.random(in: 20...60)
        meteorite.size = CGSize(width: randomSize, height: randomSize)
        
        // Set the initial position to the right top
        meteorite.position = CGPoint(x: size.width, y: size.height)
        
        meteorite.physicsBody = SKPhysicsBody(rectangleOf: meteorite.size)
        meteorite.physicsBody?.categoryBitMask = meteoriteCategory
        meteorite.physicsBody?.contactTestBitMask = bulletCategory
        addChild(meteorite)
        
        let moveAction = SKAction.move(to: CGPoint(x: -meteorite.size.width, y: 0), duration: 2.0)
        let removeAction = SKAction.removeFromParent()
        
        meteorite.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    func shootBullet(at position: CGPoint) {
        let bullet = SKSpriteNode(color: .red, size: CGSize(width: 10, height: 10))
        bullet.position = CGPoint(x: size.width / 2, y: 50)
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = meteoriteCategory
        addChild(bullet)
        
        let moveAction = SKAction.move(to: position, duration: 0.5)
        let removeAction = SKAction.removeFromParent()
        
        bullet.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    func createMeteoriteExplosion(at position: CGPoint) {
        let explosionSize = CGSize(width: 40, height: 40)
        let explosion = SKSpriteNode(imageNamed: "meteorite_explosion")
        explosion.size = explosionSize
        explosion.position = position
        addChild(explosion)
        
        let removeAction = SKAction.sequence([
            SKAction.wait(forDuration: 0.1),
            SKAction.removeFromParent()
        ])
        
        explosion.run(removeAction)
    }
    
    func updateScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        // Check if the score is a multiple of 20 (or any desired interval)
        if score % 20 == 0 {
            // Trigger meteor rain
            run(SKAction.sequence([
                SKAction.run(generateMeteorite),
                SKAction.wait(forDuration: 0.2),
                SKAction.run(generateMeteorite),
                SKAction.wait(forDuration: 0.2),
                SKAction.run(generateMeteorite),
                // Add more actions as needed
            ]))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Called when a collision occurs
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if (nodeA?.physicsBody?.categoryBitMask == bulletCategory && nodeB?.physicsBody?.categoryBitMask == meteoriteCategory) ||
            (nodeA?.physicsBody?.categoryBitMask == meteoriteCategory && nodeB?.physicsBody?.categoryBitMask == bulletCategory) {
            // Bullet hit meteorite
            nodeA?.removeFromParent()
            nodeB?.removeFromParent()
            createMeteoriteExplosion(at: contact.contactPoint)
            updateScore()
        }
    }
}
