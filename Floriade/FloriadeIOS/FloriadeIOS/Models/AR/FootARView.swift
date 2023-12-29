//
//  ARView.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 17/03/2022.
//

import Foundation
import RealityKit
import ARKit
import SwiftUI

class FootARView: ARView, ARSessionDelegate, ObservableObject {
    let coachingOverlay = ARCoachingOverlayView();
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FootARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        self.coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.coachingOverlay.session = session
        self.coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        coachingOverlayView.activatesAutomatically = false
    }
}
