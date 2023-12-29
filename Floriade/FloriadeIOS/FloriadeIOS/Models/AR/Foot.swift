//
//  Foot.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 17/03/2022.
//

import Foundation
import RealityKit
import SwiftUI

class Foot: ObservableObject {
    var entity: ModelEntity = try! Entity.loadModel(named: "foot")
    var footMaterial: FootMaterial = FootMaterial()
    @Published var currentlyScaling: Bool = false
    @Published var currentScale: Double = 5.0
    @Published var personalFootScale: Double?
    @Published var personalFootSelected: Bool = false
    @Published var recalculatingFoot: Bool = false
    @Published var hasBeenRenderedOnce: Bool = false
    
    var timer: Timer?
    
    init() {
        entity.generateCollisionShapes(recursive: true)
        entity.scale = entity.scale * Float(Double(self.currentScale).squareRoot())
        entity.model?.materials = [footMaterial.material]
    }
    
    // Scales phyiscal size of foot
    func scale(scaleDuration: Double, ha: Double) {
        var transform = self.entity.transform;
        transform.scale = SIMD3<Float>(0.01, 0.01, 0.01) * Float(ha).squareRoot()
        self.entity.move(to: transform,
                         relativeTo: self.entity.parent,
                         duration: scaleDuration, timingFunction: .linear)
        currentlyScaling = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + scaleDuration) {
            self.currentScale = ha
            self.currentlyScaling = false
        }
    }
    
    // Animates the color transition between feet
    func animateColor(wantedColor: FootColor, scaleDuration: Double) {
        // Stepsize is the number that will increase/decrease on the rgba of material based on wantedColor and self.material
        let redStepsize: Float =  wantedColor.red < self.footMaterial.red ? -1 : 1
        let greenStepsize: Float = wantedColor.green < self.footMaterial.green ? -1 : 1
        let blueStepsize: Float = wantedColor.blue < self.footMaterial.blue ? -1 : 1
        var counter = 0
        
        self.timer = Timer.scheduledTimer(withTimeInterval: scaleDuration / 100, repeats: true) { timer in
            if (counter == 100) {
                // Resets the color at the end
                // This prevents unwanted decimales on the next transition
                self.footMaterial.red = wantedColor.red
                self.footMaterial.green = wantedColor.green
                self.footMaterial.blue = wantedColor.blue
                
                self.footMaterial.material = SimpleMaterial(color: UIColor(red: Double(self.footMaterial.red / 100), green: Double(self.footMaterial.green / 100), blue: Double(self.footMaterial.blue / 100), alpha: self.footMaterial.material.color.tint.rgba.alpha), isMetallic: false)
                
                self.entity.model?.materials = [self.footMaterial.material]
                
                timer.invalidate()
                return
            }
            counter += 1
            
            // Red
            if (self.footMaterial.red != wantedColor.red) {
                self.footMaterial.red += redStepsize
            }
            
            // Green
            if (self.footMaterial.green != wantedColor.green) {
                self.footMaterial.green += greenStepsize
            }
            
            // Blue
            if (self.footMaterial.blue != wantedColor.blue) {
                self.footMaterial.blue += blueStepsize
            }
            
            self.footMaterial.material = SimpleMaterial(color: UIColor(red: Double(self.footMaterial.red / 100), green: Double(self.footMaterial.green / 100), blue: Double(self.footMaterial.blue / 100), alpha: self.footMaterial.material.color.tint.rgba.alpha), isMetallic: false)
            
            self.entity.model?.materials = [self.footMaterial.material]
        }
    }
    
    func ScaleFoot(personalScale: Double?, standardScale: Double?) {
        let scaleDuration: Double = 2 // Seconds
        currentlyScaling = true
        
        if (personalScale == nil) {
            self.personalFootSelected = false
            if (standardScale! == 1.6) {
                animateColor(wantedColor: FootColor(colorState: FootColorStates.Red), scaleDuration: scaleDuration)
                scale(scaleDuration: scaleDuration, ha: 5.0)
            } else if (standardScale! == 5.0) {
                animateColor(wantedColor: FootColor(colorState: FootColorStates.Green), scaleDuration: scaleDuration)
                scale(scaleDuration: scaleDuration, ha: 1.6)
            }
        } else {
            self.personalFootSelected = true
            self.currentScale = personalScale!
            self.personalFootScale = personalScale!
            animateColor(wantedColor: FootColor(colorState: FootColorStates.Blue), scaleDuration: scaleDuration)
            scale(scaleDuration: scaleDuration, ha: self.currentScale)
        }
        
        // Adds timeout till animation is over
        DispatchQueue.main.asyncAfter(deadline: .now() + scaleDuration) {
            self.currentlyScaling = false
        }
    }

}

class FootMaterial {
    var material: SimpleMaterial
    var red: Float = 100.0
    var green: Float = 0.0
    var blue: Float = 0.0
    
    init() {
        self.material = SimpleMaterial(color: UIColor(red: Double(self.red / 100), green: Double(self.green / 100), blue: Double(self.blue), alpha: 0.9), isMetallic: false)
    }
}

struct FootColor {
    var red: Float = 0.0
    var green: Float = 0.0
    var blue: Float = 0.0
    
    init(colorState: FootColorStates) {
        if (colorState == FootColorStates.Red) {
            self.red = 100.0
        }
        if (colorState == FootColorStates.Green) {
            self.green = 100.0
        }
        if (colorState == FootColorStates.Blue) {
            self.blue = 100.0
        }
    }
}

enum FootColorStates {
    case Red
    case Green
    case Blue
}
