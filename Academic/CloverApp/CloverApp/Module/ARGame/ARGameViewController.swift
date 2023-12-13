//
//  ARGameViewController.swift
//  C
//
//  Created by Joseph William Santoso on 13/12/23.
//

import UIKit
import ARKit
import SpriteKit
import SceneKit

class ARGameViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var measurementLabel: UILabel!
    
    var startNode: SCNNode?
    var endNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restartARSession()
    }
    
    func restartARSession() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func setupARScene() {
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        
        guard let raycastQuery = sceneView.raycastQuery(from: location, allowing: .estimatedPlane, alignment: .any) else { return }
        
        let results = sceneView.session.raycast(raycastQuery)
        
        if let hitResult = results.first {
            let hitTransform = hitResult.worldTransform
            let hitVector = SCNVector3(hitTransform.columns.3.x, hitTransform.columns.3.y, hitTransform.columns.3.z)
            
            if startNode == nil {
                startNode = createSphere(at: hitVector, color: .green)
            } else if endNode == nil {
                endNode = createSphere(at: hitVector, color: .red)
                measureDistance()
            }
        }
    }
    
    func createSphere(at position: SCNVector3, color: UIColor) -> SCNNode {
        let sphere = SCNSphere(radius: 0.02)
        sphere.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = position
        sceneView.scene.rootNode.addChildNode(sphereNode)
        return sphereNode
    }
    
    func measureDistance() {
        guard let startNode = startNode, let endNode = endNode else { return }
        let distance = distanceBetweenNodes(startNode, endNode)
        measurementLabel.text = String(format: "Distance: %.2f meters", distance)
    }
    
    func distanceBetweenNodes(_ nodeA: SCNNode, _ nodeB: SCNNode) -> Float {
        let vector = SCNVector3Make(
            nodeB.position.x - nodeA.position.x,
            nodeB.position.y - nodeA.position.y,
            nodeB.position.z - nodeA.position.z
        )
        return sqrtf(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z)
    }
}

