//
//  LangScreen.swift
//  test
//
//  Created by Pieter van der Mullen on 21/03/2022.
//

import Foundation
import SwiftUI


struct LanguageScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var btnDutch = Color.white
    @State var btnEnglish = Color.init(
        Color.RGBColorSpace.sRGB,
        red: 0.60,
        green: 0.60,
        blue: 0.60,
        opacity: 1)
    @State var btnGerman = Color.white
    //Color.RGBColorSpace.sRGB, red: 0.60, green: 0.60, blue: 0.60, opacity: 1
    
    var body: some View {
        return ZStack {
            
            Color.white.ignoresSafeArea()
            
            VStack {
                
                Image("startPicture")
                    .resizable()
                    .aspectRatio(
                        contentMode: .fit)
                    .edgesIgnoringSafeArea(
                        .top)
                    .padding(
                        .top, -60.0)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 3){
                    
                    HStack {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 69)
                                .fill(
                                    Color.white)
                                .frame(
                                    width: 234,
                                    height: 50)
                                .addBorder(
                                    self.btnEnglish,
                                    width: 100,
                                    cornerRadius: 50)
                            
                            Button {
                                btnClicked(btn: "en")
                            } label: {
                                
                                Image("en")
                                    .resizable()
                                    .aspectRatio(
                                        contentMode: .fit)
                                    .frame(
                                        width: 40,
                                        height: 40)
                                
                                Text("English")
                                
                                    .fontWeight(
                                        .medium)
                                    .foregroundColor(
                                        Color.black)
                                    .font(
                                        .system(size: 18))
                                    .multilineTextAlignment(.leading)
                                    .padding(
                                        .leading, 15)
                                    .frame(
                                        width: 125.0)
                                
                            }
                        }
                    }
                    
                    HStack {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 69)
                                .fill(
                                    Color.white)
                                .frame(
                                    width: 234,
                                    height: 50)
                                .addBorder(
                                    self.btnDutch,
                                    width: 100,
                                    cornerRadius: 50)
                            
                            Button {
                                btnClicked(btn: "nl");
                                
                            } label: {
                                
                                Image("nl")
                                    .resizable()
                                    .aspectRatio(
                                        contentMode: .fit)
                                    .frame(
                                        width: 40,
                                        height: 40)
                                
                                Text("Nederlands")
                                    .fontWeight(
                                        .medium)
                                    .foregroundColor(
                                        Color.black)
                                    .font(
                                        .system(size: 18))
                                    .padding(
                                        .leading, 15)
                                    .frame(
                                        width: 125.0)
                                
                            }
                        }
                    }
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 69)
                            .fill(
                                Color.white)
                            .frame(
                                width: 234,
                                height: 50)
                            .addBorder(
                                self.btnGerman,
                                width: 100,
                                cornerRadius: 50)
                        
                        HStack {
                            Button {
                                btnClicked(btn: "de")
                            } label: {
                                
                                Image("de")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                
                                Text("Deutsch")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 18))
                                    .padding(.leading, 15)
                                    .frame(
                                        width: 125.0)
                                
                            }
                        }
                    }
                }
                Spacer()
                ZStack{
                    Button {
                        viewRouter.currentPage = "ARScreen"
                    } label: {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(
                                Color.init(
                                    Color.RGBColorSpace.sRGB,
                                    red: 0.29,
                                    green: 0.64,
                                    blue: 0.28,
                                    opacity: 1))
                            .frame(
                                width: 200,
                                height: 50)
                            .cornerRadius(25)
                        
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
            }
        }.padding(.bottom, 20.0)
    }
    
    func btnClicked(btn: String){
        if(btn == "nl"){
            btnDutch = Color.init(
                Color.RGBColorSpace.sRGB,
                red: 0.60,
                green: 0.60,
                blue: 0.60,
                opacity: 1)
            btnEnglish = Color.white
            btnGerman = Color.white
            langVar = "nl"
        }else if(btn == "en"){
            btnDutch = Color.white
            btnEnglish = Color.init(
                Color.RGBColorSpace.sRGB,
                red: 0.60,
                green: 0.60,
                blue: 0.60,
                opacity: 1)
            btnGerman = Color.white
            langVar = "en"
        }else if(btn == "de"){
            btnDutch = Color.white
            btnEnglish = Color.white
            btnGerman = Color.init(
                Color.RGBColorSpace.sRGB,
                red: 0.60,
                green: 0.60,
                blue: 0.60,
                opacity: 1)
            langVar = "de"
        }
    }
    
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        
        let roundedRect = RoundedRectangle(
            cornerRadius: cornerRadius)
        
        return clipShape(roundedRect)
            .overlay(
                roundedRect.strokeBorder(
                    content))
        
    }
}
