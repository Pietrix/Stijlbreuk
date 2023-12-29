//
//  FootprintInfoModel.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 22/03/2022.
//

import Foundation
import SwiftUI

class FootprintInfoModel: ObservableObject {
    @Published var title: FootprintInfoTitles;
    @Published var description: FootprintInfoDescriptions;
    @Published var image: Image;
    @Published var size: Double;
    @Published var earths: Double;
    @Published var overshootDay: String;
    
    init() {
        self.title = FootprintInfoTitles.DutchFootPrintTitle;
        self.description = FootprintInfoDescriptions.DutchFootPrintDescription;
        self.image = FootprintImages.DutchFootprintImage.image;
        self.size = 5.0;
        self.earths = getEarthsFromHectares(ha: 5.0)
        self.overshootDay = getOvershootDayStringFromHectares(ha: 5.0)
    }
    
    func updateFootPrintInfo(footSize: Double, personalFootSelected: Bool, mapView: Bool = false) {
        // Responsible for correct Card information based on selected foot and page
        if (!mapView) {
            if (personalFootSelected) {
                self.title = FootprintInfoTitles.PersonalFootPrintTitle
                self.description = FootprintInfoDescriptions.PersonalFootPrintTitle
                self.image = FootprintImages.PersonalFootprintImage.image
            }
            else if (footSize == 1.6) {
                self.title = FootprintInfoTitles.IdealFootPrintTitle
                self.description = FootprintInfoDescriptions.IdealFootPrintDescription
                self.image = FootprintImages.IdealFootprintImage.image
            }
            else if (footSize == 5.0) {
                self.title = FootprintInfoTitles.DutchFootPrintTitle
                self.description = FootprintInfoDescriptions.DutchFootPrintDescription
                self.image = FootprintImages.DutchFootprintImage.image
            }
        } else {
            if (footSize == 1.6) {
                self.title = FootprintInfoTitles.InsideIdealFootprintTitle
                self.image = FootprintImages.IdealFootprintImage.image
            }
            else if (footSize == 5.0) {
                self.title = FootprintInfoTitles.InsideDutchFootprintTitle
                self.image = FootprintImages.DutchFootprintImage.image
            } else {
                self.title = FootprintInfoTitles.OutsideFootprintTitle
                self.image = FootprintImages.NoFootprintImage.image
            }
        }
        
        if (footSize == 0.0 && mapView == true) {
            self.earths = 0.0
            self.size = 0.0
            self.overshootDay = "-"
        } else {
            self.earths = getEarthsFromHectares(ha: footSize)
            if (self.earths != 0.0) {
                self.overshootDay = getOvershootDayStringFromHectares(ha: footSize)
            }
            self.size = footSize
        }
    }
}

private func getEarthsFromHectares(ha: Double) -> Double {
    return round(ha * Double(1900) * 0.861842105 / Double(2620) * 10) / 10.0
}

private func getOvershootDayStringFromHectares(ha: Double) -> String {
    let earths: Double = getEarthsFromHectares(ha: ha)
    
    let firstDate: Date = String.DateFromString(dateString: "2022-01-01")
    var daysToAdd: Int = Int(365 / earths - 1)
    if (daysToAdd >= 364){ daysToAdd=364 }
    let modifiedDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: firstDate)!
    
    return String.StringFromDate(date: modifiedDate)
}

enum FootprintInfoTitles: String {
    case DutchFootPrintTitle = "Dutch carbon footprint"
    case IdealFootPrintTitle = "Ideal carbon footprint"
    case PersonalFootPrintTitle = "Your carbon footprint"
    case OutsideFootprintTitle = "You’re outside the Footprint"
    case InsideDutchFootprintTitle = "You’re inside the Dutch Footprint"
    case InsideIdealFootprintTitle = "You’re inside the Ideal Footprint"
}

enum FootprintInfoDescriptions: String {
    case DutchFootPrintDescription = "The carbon footprint of the dutch"
    case IdealFootPrintDescription = "The carbon footprint neccesary to sustain earth"
    case PersonalFootPrintTitle = "Your carbon footprint based on answered questions"
}

enum FootprintImages {
    case DutchFootprintImage
    case IdealFootprintImage
    case PersonalFootprintImage
    case NoFootprintImage
    
    var image: Image {
        switch self {
        case .DutchFootprintImage: return Image("dutchFoot").resizable()
        case .IdealFootprintImage: return Image("idealFoot").resizable()
        case .PersonalFootprintImage: return Image("personalFoot").resizable()
        case .NoFootprintImage: return Image("noFoot").resizable()
        }
    }
}

