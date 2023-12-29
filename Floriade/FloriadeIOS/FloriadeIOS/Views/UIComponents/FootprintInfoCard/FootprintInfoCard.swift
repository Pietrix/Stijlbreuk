//
//  FootprintInfoCard.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 21/03/2022.
//

import Foundation
import SwiftUI


struct FootprintInfo: View {
    @EnvironmentObject var cardExpanded: cardExpendedBool
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    @EnvironmentObject var foot: Foot
    @State var questionNumber: Int = 1
    @EnvironmentObject var answers: Answers
    
    var body: some View {
        let componentHeight: CGFloat = UIScreen.main.bounds.height * 0.20
        let imageHeight: CGFloat = 40
        
        VStack {
            Spacer()
            VStack(spacing: 0) {
                if(cardExpanded.expanded && footprintInfoModel.title == FootprintInfoTitles.PersonalFootPrintTitle && foot.personalFootScale == nil || foot.recalculatingFoot == true) {
                    HStack(alignment: .center) {
                        Spacer()
                        VStack(alignment: .center) {
                            Text(answers.answers[questionNumber - 1].question.question.localized(langVar))
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                            Text(answers.answers[questionNumber - 1].question.explanation.localized(langVar))
                                .font(.system(size: 12))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                        }.padding(.vertical, 10)
                        Spacer()
                    }.frame(minHeight: componentHeight * 0.5)
                        .padding(.horizontal, 20.0)
                        .background(.white)
                        .cornerRadius(25)
                }
                else {
                    HStack(alignment: .center) {
                        footprintInfoModel.image
                            .frame(width: 55, height: 55)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 0)
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(String(footprintInfoModel.title.rawValue).localized(langVar))
                                .font(.system(size: 16))
                                .fontWeight(Font.Weight.bold)
                            if (footprintInfoModel.title == FootprintInfoTitles.DutchFootPrintTitle || footprintInfoModel.title == FootprintInfoTitles.IdealFootPrintTitle || footprintInfoModel.title == FootprintInfoTitles.PersonalFootPrintTitle) {
                                Text(String(footprintInfoModel.description.rawValue).localized(langVar)).font(.system(size: 12))
                            }
                        }
                        Spacer()
                        if (viewRouter.currentPage == "ARScreen") {
                            if (footprintInfoModel.title == FootprintInfoTitles.PersonalFootPrintTitle){
                                if (foot.personalFootScale != nil){
                                    Button{
                                        foot.recalculatingFoot = true
                                        cardExpanded.expanded = true
                                        questionNumber = 1
                                    } label: {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(
                                                    Color.init(
                                                        Color.RGBColorSpace.sRGB,
                                                        red: 0.29,
                                                        green: 0.64,
                                                        blue: 0.28,
                                                        opacity: 1))
                                                .frame(width: 50, height: 50)
                                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                                            Image(systemName: "arrow.clockwise")
                                                .foregroundColor(.white)
                                                .font(.system(size: 34))
                                        }
                                    }
                                }
                            } else{
                                Button{
                                    viewRouter.currentPage = "MapScreen"
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(
                                                Color.init(
                                                    Color.RGBColorSpace.sRGB,
                                                    red: 0.29,
                                                    green: 0.64,
                                                    blue: 0.28,
                                                    opacity: 1))
                                            .frame(width: 50, height: 50)
                                            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                                        Image(systemName: "map")
                                            .foregroundColor(.white)
                                            .font(.system(size: 34))
                                    }
                                }
                            }
                        } else if (viewRouter.currentPage == "MapScreen") {
                            Button {
                                viewRouter.currentPage = "ARScreen"
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            Color.init(
                                                Color.RGBColorSpace.sRGB,
                                                red: 0.29,
                                                green: 0.64,
                                                blue: 0.28,
                                                opacity: 1))
                                        .frame(width: 50, height: 50)
                                        .shadow(color: Color.black.opacity(0.5), radius: 0.1, x: 1, y: 1)
                                    Image(systemName: "arkit")
                                        .foregroundColor(.white)
                                        .font(.system(size: 34))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20.0)
                    .frame(height: componentHeight * 0.6)
                    .background(.white)
                    .cornerRadius(25)
                }
                
                HStack(alignment: cardExpanded.expanded ? .top : .center) {
                    // Check if the current view is personal foot view and the foot has not been calculated before
                    if ((footprintInfoModel.title == FootprintInfoTitles.PersonalFootPrintTitle && foot.personalFootScale == nil) || foot.recalculatingFoot) {
                        // Check if the card is expanded
                        if (!cardExpanded.expanded) {
                            CalculateRedirect(componentHeight: componentHeight)
                        } else {
                            QuestionSlider(questionNumber: $questionNumber, componentHeight: componentHeight)
                        }
                        // Current view is not personal foot view
                    } else {
                        if (!cardExpanded.expanded) {
                            CardDetailsCollapsed(componentHeight: componentHeight)
                        } else {
                            CardDetailsExpanded(componentHeight: componentHeight)
                        }
                        Button(action: {
                            cardExpanded.expanded.toggle()
                        }) {
                            Image(systemName: "chevron.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageHeight * 0.5, height: imageHeight * 0.5)
                                .rotationEffect(.degrees(cardExpanded.expanded ? 180 : 0))
                                .animation(Animation.easeInOut(duration: 0.5), value: cardExpanded.expanded)
                                .foregroundColor(.black.opacity(footprintInfoModel.size == 0.0 ? 0 : 1))
                        }.disabled(footprintInfoModel.size == 0.0 ? true : false)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }.padding(.top, cardExpanded.expanded ? 30 : 0)
            }.background(Color(UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)))
                .cornerRadius(25)
                .padding(.bottom, 20)
                .animation(Animation.easeInOut(duration: 0.5), value: cardExpanded.expanded)
        }.padding(.horizontal, 10.0)
    }
}
