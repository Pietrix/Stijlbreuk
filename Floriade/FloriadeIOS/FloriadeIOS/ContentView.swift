//
//  ContentView.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 14/03/2022.
//

import SwiftUI
import RealityKit

public var langVar = "en"


struct ContentView : View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var isMainHidden: isMainHiddenBool = isMainHiddenBool()
    @ObservedObject var foot: Foot = Foot()
    @ObservedObject var footprintInfoModel: FootprintInfoModel = FootprintInfoModel()
    @ObservedObject var answers: Answers = Answers()
    @ObservedObject var carouselModel: CarouselModel = CarouselModel()
    @State var cardExpended: cardExpendedBool = cardExpendedBool()
    
    var body: some View {
        VStack {
            viewRouter.getCurrentView()
                .environmentObject(cardExpended)
                .environmentObject(foot)
                .environmentObject(footprintInfoModel)
                .environmentObject(answers)
                .environmentObject(carouselModel)
                .environmentObject(isMainHidden)
                
        }
    }
}

class cardExpendedBool: ObservableObject {
    @Published var expanded: Bool = false
}

class isMainHiddenBool: ObservableObject {
    @Published var hidden: Bool = true
}
