//
//  CardDetailsCollapsed.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 21/03/2022.
//

import Foundation
import SwiftUI

struct CardDetailsCollapsed: View {
    var componentHeight: CGFloat
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    
    var body: some View {
        HStack {
            Spacer()
            FootprintDetails(title: footprintInfoModel.size == 0.0 ? "-" : "\(String(format: "%g", footprintInfoModel.size)) Ha", detail: String("Size").localized(langVar))
            Spacer()
            FootprintDetails(title: footprintInfoModel.earths == 0.0 ? "-" : "\(String(format: "%g", footprintInfoModel.earths))", detail: footprintInfoModel.earths <= 1.0 ? String("Earth").localized(langVar) : String("Earths").localized(langVar))
            Spacer()
            FootprintDetails(title: footprintInfoModel.overshootDay, detail: String("Overshoot day").localized(langVar))
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: componentHeight * 0.4)
    }
}

struct FootprintDetails: View {
    var title: String
    var detail: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18)).bold()
            Text(detail)
                .font(.system(size: 16))
                .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)))
        }
    }
}

