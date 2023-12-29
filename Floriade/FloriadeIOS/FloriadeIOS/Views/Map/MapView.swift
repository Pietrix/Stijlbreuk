//
//  MapView.swift
//  FloriadeIOS
//
//  Created by Bram van der Bruggen on 14/03/2022.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var userIsInside: IsInsideEnum
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    fileprivate let latitude = 52.3571145034
    fileprivate let longitude = 5.22773087332
    let redColor = UIColor(red: 0.91, green: 0.18, blue: 0.18, alpha: 0.6)
    let greenColor = UIColor(red: 0.25, green: 0.85, blue: 0.23, alpha: 0.6)
    var mapView: MKMapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        // Initialising locations manager and requesting permissions
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.delegate = context.coordinator
        
        // Initialising mapview
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        mapView.mapType = MKMapType.satellite
        
        // Centering map on Floriade
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    // Adding all context on the mapview
    func updateUIView(_ uiView: MKMapView, context: Context) {
        addImage(mapView: mapView, imageName: "floriadeMap", scale: 5.75)
        addGeofence(mapView: mapView, coords: FootCoords.bigPointing, color: redColor)
        addGeofence(mapView: mapView, coords: FootCoords.bigSole, color: redColor)
        addGeofence(mapView: mapView, coords: FootCoords.bigMiddle, color: redColor)
        addGeofence(mapView: mapView, coords: FootCoords.bigRing, color: redColor)
        addGeofence(mapView: mapView, coords: FootCoords.bigPinky, color: redColor)
        addGeofence(mapView: mapView, coords: FootCoords.smallSole, color: greenColor)
        addGeofence(mapView: mapView, coords: FootCoords.smallPointing, color: greenColor)
        addGeofence(mapView: mapView, coords: FootCoords.smallMiddle, color: greenColor)
        addGeofence(mapView: mapView, coords: FootCoords.smallRing, color: greenColor)
        addGeofence(mapView: mapView, coords: FootCoords.smallPinky, color: greenColor)
    }
    
    // MARK: Coordinator
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var control: MapView
        var headingImageView: UIImageView?
        var userHeading: CLLocationDirection?
        
        init(_ control: MapView) {
            self.control = control
        }
        
        // Custom overlay rendering for images and geofences
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is ImageOverlay {
                return ImageOverlayRenderer(overlay: overlay)
            }
            
            if overlay is MKPolygon {
                let polygonView = MKPolygonRenderer(overlay: overlay)
                polygonView.fillColor = FootCoords.fillColor
                return polygonView
            }
            
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            if views.last?.annotation is MKUserLocation {
                addHeadingView(toAnnotationView: views.last!)
            }
        }
        
        func addHeadingView(toAnnotationView annotationView: MKAnnotationView) {
            if headingImageView == nil {
                var image = UIImage(named: "mapArrow")!
                image = image.resized(to: CGSize(width: 30, height: 30))
                headingImageView = UIImageView(image: image)
            
                headingImageView!.frame = CGRect(x: (annotationView.frame.size.width - image.size.width)/2, y: (annotationView.frame.size.height - image.size.height)/2, width: image.size.width, height: image.size.height)
                control.mapView.userLocation.title = ""
                annotationView.addSubview(headingImageView!)
                headingImageView!.isHidden = true
            }
        }
        
        func updateHeadingRotation() {
            if let heading = control.locationManager.heading?.trueHeading,
                let headingImageView = headingImageView {
                
                headingImageView.isHidden = false
                let rotation = CGFloat(heading/180 * Double.pi)
                headingImageView.transform = CGAffineTransform(rotationAngle: rotation)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            if newHeading.headingAccuracy < 0 { return }
            
            let heading = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
            userHeading = heading
            updateHeadingRotation()
        }
        
        // Geofence controller
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if (
                control.isInside(coords: FootCoords.bigSole) ||
                control.isInside(coords: FootCoords.bigPointing) ||
                control.isInside(coords: FootCoords.bigMiddle) ||
                control.isInside(coords: FootCoords.bigRing) ||
                control.isInside(coords: FootCoords.bigPinky)) {
                if (
                    control.isInside(coords: FootCoords.smallSole) ||
                    control.isInside(coords: FootCoords.smallPointing) ||
                    control.isInside(coords: FootCoords.smallMiddle) ||
                    control.isInside(coords: FootCoords.smallRing) ||
                    control.isInside(coords: FootCoords.smallPinky))
                {
                    control.userIsInside = IsInsideEnum.Small
                    return
                }
                control.userIsInside = IsInsideEnum.Big
                return
            }
            control.userIsInside = IsInsideEnum.Outside
        }
    }
    
    // MARK: Image overlay
    
    func addImage(mapView: MKMapView, imageName: String, scale: Double) {
        let startCoordinate = MKMapPoint(.init(latitude: latitude, longitude: longitude))
        let size = MKMapSize(width: 2300 * scale, height: 2300 * scale)
        let rect = MKMapRect(origin: startCoordinate, size: size)
        
        let region = MKCoordinateRegion(rect)
        let lat = latitude + (region.span.latitudeDelta / 2)
        let lon = longitude - (region.span.longitudeDelta / 2)
        let point = MKMapPoint(.init(latitude: lat, longitude: lon))
        
        let newRect = MKMapRect(origin: point, size: size)
        let image = UIImage(named: imageName)!
        let overlay = ImageOverlay(image: image, rect: newRect)
        
        mapView.addOverlay(overlay)
    }
    
    // MARK: Geofencing
    
    public func isInside(coords: [CLLocationCoordinate2D]) -> Bool {
        var locations: [MKMapPoint] = []
        for coord in coords {
            locations.append(.init(coord))
        }
        return locationManager.isInsideFence(locations: locations, map: mapView)
    }
    
    func addGeofence(mapView: MKMapView, coords: [CLLocationCoordinate2D], color: UIColor) {
        FootCoords.fillColor = color
        let polygon = MKPolygon(coordinates: coords, count: coords.count)
        mapView.addOverlay(polygon)
    }
}
