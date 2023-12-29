//
//  SplashScreen.swift
//  FloriadeIOS
//
//  Created by Pieter van der Mullen on 16/03/2022.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        return ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Image("startPicture").resizable().aspectRatio(contentMode: .fit).edgesIgnoringSafeArea(.top).padding(.top, -60.0)
                Image("floriadeLogo").resizable().aspectRatio(contentMode: .fit).padding(.horizontal, 20.0).padding(.bottom, 20.0).padding(.top, 20.0)
                Spacer()
                ZStack{
                    Button {
                        viewRouter.currentPage = "LanguageScreen"
                    } label: {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.init(Color.RGBColorSpace.sRGB, red: 0.29, green: 0.64, blue: 0.28, opacity: 1)).frame(width: 200,height: 50).cornerRadius(25)
                    }
                    HStack {
                        Text(String("Start").localized(langVar))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .font(
                                .system(size: 28))
                        Image(systemName: "arrow.right")
                            .padding(.leading, 10.0)
                            .foregroundColor(Color.white)
                            .font(
                                .system(size: 24,
                                        weight: .semibold))
                    }
                }
                
            }.padding(.bottom, 20.0)
            
        }
    }
}
