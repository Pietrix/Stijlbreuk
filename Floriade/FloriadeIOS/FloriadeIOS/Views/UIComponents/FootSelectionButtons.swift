//
//  FootSelectionButtons.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 21/03/2022.
//

import Foundation
import SwiftUI

struct LoadingImageOverlay: View {
    var body: some View {
        ZStack {
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.green)).scaleEffect(1.75, anchor: .center)
        }
        
    }
}

struct CorrectButtonOverlay: View {
    var currentScale: Double
    var correctScale: Double?
    var isScaling: Bool
    var personalFootSelected: Bool
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    
    var body: some View {
        ZStack {
            if (isScaling) {
                LoadingImageOverlay()
            }
            else if ((currentScale == correctScale && footprintInfoModel.title != FootprintInfoTitles.PersonalFootPrintTitle) || (personalFootSelected && correctScale == nil)) {
                Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2))
            }
        }
    }
}

struct FootSelectionButtons: View {
    @Binding var language: String
    @EnvironmentObject var foot: Foot
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.init(Color.RGBColorSpace.sRGB, red: 1, green: 1, blue: 1, opacity: 0.8)).frame(width: 55,height: 150).cornerRadius(15)
                        
                        VStack {
                            Button {
                                foot.personalFootSelected = false
                                foot.ScaleFoot(personalScale: nil, standardScale: 1.6)
                            } label: {
                                Image("dutchFoot")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
                                    .frame(width: 40.0, height: 40.0)
                                    .overlay(CorrectButtonOverlay(currentScale: foot.currentScale, correctScale: 5.0, isScaling: foot.currentlyScaling, personalFootSelected: foot.personalFootSelected))
                                    .cornerRadius(10)
                            }.disabled(foot.personalFootSelected == false && (foot.currentScale == 5.0 || foot.currentlyScaling == true))
                            Button {
                                
                                foot.ScaleFoot(personalScale: nil, standardScale: 5.0)
                            } label: {
                                Image("idealFoot")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
                                    .frame(width: 40.0, height: 40.0)
                                    .overlay(CorrectButtonOverlay(currentScale: foot.currentScale, correctScale: 1.6, isScaling: foot.currentlyScaling, personalFootSelected: foot.personalFootSelected))
                                    .cornerRadius(10)
                                
                            }.disabled(foot.personalFootSelected == false && (foot.currentScale == 1.6 || foot.currentlyScaling))
                            Button {
                                
                                foot.personalFootSelected = true
                                if (foot.personalFootScale != nil) {
                                    foot.ScaleFoot(personalScale: foot.personalFootScale, standardScale: nil)
                                } else {
                                }
                                
                            } label: {
                                Image("personalFoot")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 0)
                                    .frame(width: 40.0, height: 40.0)
                                    .overlay(CorrectButtonOverlay(currentScale: foot.currentScale, correctScale: nil, isScaling: foot.currentlyScaling, personalFootSelected: foot.personalFootSelected))
                                    .cornerRadius(10)
                            }.disabled(foot.personalFootSelected || foot.currentlyScaling)
                        }
                    }
                    
                    
                    
                    
                }
                Spacer()
            }.onChange(of: foot.currentScale) { newValue in
                footprintInfoModel.updateFootPrintInfo(footSize: newValue, personalFootSelected: foot.personalFootSelected)
            }.onChange(of: foot.personalFootSelected) { _ in
                footprintInfoModel.updateFootPrintInfo(footSize: foot.personalFootScale ?? foot.currentScale, personalFootSelected: foot.personalFootSelected)
            }.onChange(of: foot.personalFootScale) { _ in
                foot.ScaleFoot(personalScale: foot.personalFootScale ?? 3.0, standardScale: nil)
                footprintInfoModel.updateFootPrintInfo(footSize: foot.personalFootScale ?? 0.0, personalFootSelected: foot.personalFootSelected)}
            .padding(.trailing, 10)
        }
        
    }
}
