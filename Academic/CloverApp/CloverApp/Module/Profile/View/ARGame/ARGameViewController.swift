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
import AVKit

class ARGameViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var videoPlayerNode: SKVideoNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupARScene()
        Task {
            await showVideo()
        }
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
    }
    
    func showVideo() async {
        guard let videoURL = URLstore.videosURL else {
            // Handle invalid URL
            print("Not this link!")
            return
        }
        
        let player = AVPlayer(url: videoURL)
        
        let videoScene = SKScene(size: CGSize(width: 1280, height: 720)) // Adjusted for a common 16:9 aspect ratio
        videoPlayerNode = SKVideoNode(avPlayer: player)
        videoPlayerNode?.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoPlayerNode?.size = videoScene.size
        videoPlayerNode?.yScale = -1.0 // Flip the video to display correctly in SpriteKit
        
        videoScene.addChild(videoPlayerNode!)
        
        do {
            let asset = try await player.currentItem?.asset
            let tracks = try await asset?.loadTracks(withMediaType: .video)
            let track = tracks?.first
            let naturalSize = try await track?.load(.naturalSize)
            
            let aspectRatio = naturalSize?.height ?? 1 / (naturalSize?.width ?? 1) // Invert the aspect ratio
            
            let videoNode = SCNNode()
            videoNode.geometry = SCNPlane(width: 2.0, height: 3.0) // Adjusted for the video's aspect ratio
            videoNode.geometry?.firstMaterial?.diffuse.contents = videoScene
            videoNode.position = SCNVector3(0, -1, -2) // Adjust position according to your scene and distance
            videoNode.eulerAngles.x = -.pi / 2 // Rotate the plane to face the camera
            
            sceneView.scene.rootNode.addChildNode(videoNode)
            
            try? await player.play()
        } catch {
            // Handle errors
            print("Error: \(error)")
        }
    }
}

