//
//  MKPolygon+Geofencing.swift
//  FloriadeIOS
//
//  Created by Bram van der Bruggen on 16/03/2022.
//

import Foundation
import MapKit

extension MKPolygon {
    func containsCoord(coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPoint(coor)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        if polygonRenderer.path == nil {
            return false
        } else {
            return polygonRenderer.path.contains(polygonViewPoint)
        }
    }
}
