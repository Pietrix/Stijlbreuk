//
//  CardDetailsExpanded.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 21/03/2022.
//

import Foundation
import SwiftUI

struct CardDetailsExpanded: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var componentHeight: CGFloat
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    
    var body: some View {
        ScrollView(showsIndicators: false
        ) {
            VStack(alignment: .leading) {
                Text("\(String(format: "%g", footprintInfoModel.size)) " + "Hectares".localized(langVar))
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 1.0)
                
                Text("1ha = 10.000m2")
                    .font(.system(size: 12))
                    .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(RenderTexts.RenderHectareTexts(pageType: footprintInfoModel.title, hectare: footprintInfoModel.size).localized(langVar))
                    .font(.system(size: 14))
                    .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)))
                    .fixedSize(horizontal: false, vertical: true)
                
                if (footprintInfoModel.title != FootprintInfoTitles.PersonalFootPrintTitle) {
                    Button(action: {
                        if (viewRouter.currentPage == "ARScreen") {
                            viewRouter.currentPage = "MapScreen"
                        } else {
                            viewRouter.currentPage = "ARScreen"
                        }
                        
                    }) {
                        Text(viewRouter.currentPage == "ARScreen" ? "See on map".localized(langVar) : "AR Experience".localized(langVar))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(uiColor: UIColor(red: 0.29, green: 0.64, blue: 0.28, alpha: 1.00)))
                    .font(.system(size: 14))
                    .cornerRadius(25)
                }
                
                Text("\(String(format: "%g", footprintInfoModel.earths)) " + (footprintInfoModel.earths <= 1.0 ? String("Earth").localized(langVar) : String("Earths").localized(langVar)))
                    .font(.system(size: 16))
                    .bold()
                    .padding(.bottom, 1.0)
                    .padding(.top, 5)
                
                Text(RenderTexts.RenderEarthTexts(pageType: footprintInfoModel.title, earths: footprintInfoModel.earths).localized(langVar))
                    .font(.system(size: 14))
                    .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)))
                    .fixedSize(horizontal: false, vertical: true)
                
                EarthView(amountOfEarths: Float(footprintInfoModel.earths))
                Text(
                    String("\(String.FormatDayDateFromStringToString(dateString: footprintInfoModel.overshootDay) + " " +  String.FormatMonthDateFromStringToString(dateString: footprintInfoModel.overshootDay).localized(langVar))"))
                .font(.system(size: 16))
                .bold()
                .padding(.bottom, 1.0)
                .padding(.top, 5)
                
                Text(RenderTexts.RenderOvershootTexts(pageType: footprintInfoModel.title).localized(langVar))
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 14))
                    .foregroundColor(Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)))
                
                Spacer()
                
            }.padding(.leading, 20.0)
        }
        
    }
}

struct EarthView: View {
    let amountOfEarths: Float
    var body: some View {
        let extraWidth: CGFloat = CGFloat(40 * (amountOfEarths - Float(Int(amountOfEarths))))
        VStack (alignment: .leading) {
            if (amountOfEarths > 6) {
                HStack {
                    ForEach((1...6), id: \.self) { earths in
                        Image("fullearth").resizable().frame(width: 40, height: 40)
                    }
                }
            }
            
            let range: Int = amountOfEarths < 6 ? Int(amountOfEarths) : Int(amountOfEarths)-6
            
            HStack {
                if (range != 0) {
                    ForEach((1...range), id: \.self) { earths in
                        Image("fullearth").resizable().frame(width: 40, height: 40)
                    }
                }
                Image("fullearth").resizable().frame(width: 40, height: 40).clipped().frame(width: extraWidth, alignment: .leading).clipped()
            }
        }
    }
}
