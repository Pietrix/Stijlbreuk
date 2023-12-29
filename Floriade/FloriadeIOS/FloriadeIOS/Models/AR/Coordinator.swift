import ARKit
import RealityKit
import Combine
import SwiftUI

class Coordinator: NSObject, ARSessionDelegate{
    var parent: ARViewContainer
    var foot: Foot
    
    init(parent: ARViewContainer, foot: Foot) {
        self.parent = parent
        self.foot = foot
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let imageAnchor = anchors[0] as? ARImageAnchor else {
            print("Problems loading anchor.")
            return
        }
        
        //Assigns reference image that will be detected
        if (parent.arView.scene.anchors.count == 0) {
            if let imageName = imageAnchor.name, imageName  == "ARImage" {
                #if DEBUG
                    let anchor = AnchorEntity()
                
                #else
                    let anchor = AnchorEntity(anchor: imageAnchor)
                
                #endif
                
                anchor.addChild(foot.entity)
                foot.entity.setPosition(SIMD3<Float>(0.35, 0.0, -0.30), relativeTo: anchor)
                foot.entity.orientation *= simd_quatf(angle: .pi * 1.15, axis: SIMD3(0, 1, 0))
                
                parent.arView.scene.addAnchor(anchor)
                
                var transform = foot.entity.transform;
                transform.scale = SIMD3<Float>(0.01, 0.01, 0.01) * Float(foot.currentScale).squareRoot()
                foot.entity.move(to: transform,
                                      relativeTo: foot.entity.parent,
                                      duration: 2, timingFunction: .linear)
            }
        }
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let imageAnchor = anchors[0] as? ARImageAnchor else {
            print("Problems loading anchor.")
            return }
        
        if (imageAnchor.isTracked && !foot.hasBeenRenderedOnce) {
                foot.hasBeenRenderedOnce = true
        }
    }
}
