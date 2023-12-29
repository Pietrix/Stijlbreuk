//
//  MapScreen.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 14/03/2022.
//

import Foundation
import MapKit
import SwiftUI

struct MapScreen: View {
    @EnvironmentObject var cardExpanded: cardExpendedBool
    @EnvironmentObject var viewRouter: ViewRouter
    @State var userIsInside: IsInsideEnum = IsInsideEnum.Outside
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    @EnvironmentObject var foot: Foot
    
    var body: some View {
        let mapView = MapView(userIsInside: $userIsInside)
        ZStack {
            mapView.edgesIgnoringSafeArea(.all)
            BackgroundColor().edgesIgnoringSafeArea(.all).allowsHitTesting(false)
            FootprintInfo()
        }.task(id: userIsInside) {
            if (userIsInside == IsInsideEnum.Outside) {
                footprintInfoModel.updateFootPrintInfo(footSize: 0.0, personalFootSelected: false, mapView: true)
                cardExpanded.expanded = false
            }
            if (userIsInside == IsInsideEnum.Big) {
                footprintInfoModel.updateFootPrintInfo(footSize: 5.0, personalFootSelected: false, mapView: true)
                foot.ScaleFoot(personalScale: nil, standardScale: 1.6)
                foot.currentScale = 5.0
            }
            if (userIsInside == IsInsideEnum.Small) {
                footprintInfoModel.updateFootPrintInfo(footSize: 1.6, personalFootSelected: false, mapView: true)
                foot.ScaleFoot(personalScale: nil, standardScale: 5.0)
                foot.currentScale = 1.6
            }
        }
    }
    
    // Coloroverlay placed on the map when entering a footprint
    func BackgroundColor() -> Color {
        return userIsInside == IsInsideEnum.Outside ? Color.init(uiColor: UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.00)) : userIsInside == IsInsideEnum.Big ? Color.init(Color.RGBColorSpace.sRGB, red: 0.91, green: 0.18, blue: 0.18, opacity: 0.25) : Color.init(Color.RGBColorSpace.sRGB, red: 0.25, green: 0.85, blue: 0.23, opacity: 0.25)
    }
}
