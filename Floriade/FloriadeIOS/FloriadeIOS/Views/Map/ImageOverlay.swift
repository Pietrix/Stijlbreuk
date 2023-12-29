//
//  ImageOverlay.swift
//  FloriadeIOS
//
//  Created by Bram van der Bruggen on 15/03/2022.
//

import Foundation
import MapKit
import SwiftUI

class ImageOverlay : NSObject, MKOverlay {
    let image:UIImage
    let boundingMapRect: MKMapRect
    let coordinate: CLLocationCoordinate2D

    init(image: UIImage, rect: MKMapRect) {
        self.image = image
        self.boundingMapRect = rect
        self.coordinate = MKCoordinateRegion(rect).center
    }
}

class ImageOverlayRenderer : MKOverlayRenderer {
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let overlay = self.overlay as? ImageOverlay else {
            return
        }
        let rect = self.rect(for: overlay.boundingMapRect)
        UIGraphicsPushContext(context)
        overlay.image.draw(in: rect)
        UIGraphicsPopContext()
    }
}
