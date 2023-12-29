//
//  CLLocationManager+Geofencing.swift
//  FloriadeIOS
//
//  Created by Bram van der Bruggen on 16/03/2022.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

extension CLLocationManager: CLLocationManagerDelegate {
    func isInsideFence(locations: [MKMapPoint], map: MKMapView) -> Bool {
        let coor = self.location?.coordinate ?? nil
        if coor != nil && locations.count > 0 {
            let polygon = MKPolygon(coordinates: locations.map({$0.coordinate}), count: locations.count)
            return polygon.containsCoord(coor: coor!)
        }
        else {
            return false
        }
    }
}
