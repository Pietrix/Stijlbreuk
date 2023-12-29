//
//  HomeScreen.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 14/03/2022.
//

import Foundation
import SwiftUI

struct ARScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var foot: Foot
    @EnvironmentObject var isMainHidden: isMainHiddenBool
    @EnvironmentObject var carouselModel: CarouselModel
    @EnvironmentObject var footprintInfoModel: FootprintInfoModel
    @State var language: String = "netherlandsFlag"
    
    var body: some View {
        
        return ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            if(!isMainHidden.hidden){
                if (!foot.hasBeenRenderedOnce) {
                    ARTutorialOverlay()
                }
                FootSelectionButtons(language: $language)
                FootprintInfo()
            }
            if(isMainHidden.hidden){
                CarouselScreen()
            }
            VStack{
                HStack{
                    Button{
                        carouselModel.activeCard = 0
                        isMainHidden.hidden.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 69)
                                .fill(
                                    Color.init(
                                        Color.RGBColorSpace.sRGB,
                                        red: 0.29,
                                        green: 0.64,
                                        blue: 0.28,
                                        opacity: 0))
                                .frame(width: 25, height: 25)
                                .addBorder(
                                    Color.white,
                                    width: 2,
                                    cornerRadius: 15)
                            Image(systemName: "questionmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                            
                        }.padding()
                    }
                    
                    Spacer()
                }
                Spacer()
            }
        }.task(id: viewRouter.currentPage) {
            footprintInfoModel.updateFootPrintInfo(footSize: foot.currentScale, personalFootSelected: false)
        }.task(id: foot.currentScale) {
            footprintInfoModel.updateFootPrintInfo(footSize: foot.currentScale, personalFootSelected: false)
        }
    }
}

//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARScreen()
//            .previewDevice("iPhone SE (1st generation)")
//            .environmentObject(ViewRouter())
//            .environmentObject(Foot())
//            .environmentObject(isMainHiddenBool())
//            .environmentObject(CarouselModel())
//            .environmentObject(FootprintInfoModel())
//    }
//}
//#endif
