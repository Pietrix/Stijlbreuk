//
//  ARViewContainer.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 14/03/2022.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var arView: FootARView
    @EnvironmentObject var foot: Foot
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, foot: foot)
    }
    
    func makeUIView(context: Context) -> FootARView {
        arView.session.delegate = context.coordinator
        arView.addCoaching();
        
        // Loads image marker
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARImageTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.trackingImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1
        
        arView.session.run(configuration)
        
        return arView
    }
    
    func updateUIView(_ uiView: FootARView, context: Context) {
        
    }
}
