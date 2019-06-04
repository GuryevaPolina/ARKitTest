//
//  CameraViewController.swift
//  ARKitTest
//
//  Created by defaultUser on 04/06/2019.
//  Copyright © 2019 Polina Guryeva. All rights reserved.
//

import UIKit
import ARKit

class CameraViewController: UIViewController {
    
    private let colors = [UIColor.red, // front
                          UIColor.blue, // right
                          UIColor.yellow, // back
                          UIColor.purple, // left
                          UIColor.gray, // top
                          UIColor.green] // bottom
    
    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScreenView()
    }
    
    private func initScreenView() {
        config.planeDetection = .horizontal
        sceneView.session.run(config, options: [])
        sceneView.delegate = self
       // sceneView.debugOptions = [.showFeaturePoints]
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeColor(_:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(singleTapGestureRecognizer)
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAlert))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        sceneView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        
        let longTouchGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showAlert))
        sceneView.addGestureRecognizer(longTouchGestureRecognizer)
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Объект XXX", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func changeColor(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            let location = recognizer.location(in: sceneView)
            let hits = sceneView.hitTest(location, options: nil)
            
            if let tappedNode = hits.first?.node {
                
                let sideMaterials = colors.shuffled().map { color -> SCNMaterial in
                    let material = SCNMaterial()
                    material.diffuse.contents = color
                    material.locksAmbientWithDiffuse = true
                    return material
                }
                
                tappedNode.geometry?.materials = sideMaterials
            }
            
        }
    }

}

extension CameraViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)

        let sideMaterials = colors.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            material.locksAmbientWithDiffuse = true
            return material
        }
        
        box.materials = sideMaterials
        
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(0,0,0)
        node.addChildNode(boxNode)
    }
}
