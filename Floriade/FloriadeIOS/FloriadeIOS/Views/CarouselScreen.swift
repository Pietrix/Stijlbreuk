//
//  CarouselScreen.swift
//  test
//
//  Created by Pieter van der Mullen on 17/03/2022.
//

import SwiftUI

// Section on the first AR screen with a title, description and image
struct ARMapCarouselSection: View {
    
    var IconName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: IconName == "arkit" ? .leading : .trailing, spacing: 0) {
            Text(title.localized(langVar)).font(.system(size: 20)).fontWeight(.semibold).padding(.bottom, 5)
            if(IconName == "arkit") {
                HStack(alignment: .top) {
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
                        Image(systemName: IconName)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                        
                    }.padding(.top, 10)
                    Text(description.localized(langVar)).font(.system(size: 12)).padding(.leading, 5).padding(.top, 0)
                }} else {
                    HStack(alignment: .top) {
                        Text(description.localized(langVar)).multilineTextAlignment(.trailing).font(.system(size: 12)).padding(.leading, 5)
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
                            Image(systemName: IconName)
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                            
                        }.padding(.top, 10)
                    }}
        }.padding(.horizontal, 20)
    }
}

struct ARMapCarousel: View {
    var carouselItem: CarouselItem
    @EnvironmentObject var isMainHidden: isMainHiddenBool
    @EnvironmentObject var carouselModel: CarouselModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.init(Color.RGBColorSpace.sRGB, red: 0.88, green: 0.88, blue: 0.88, opacity: 1))
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.init(Color.RGBColorSpace.sRGB, red: 1, green: 1, blue: 1, opacity: 1))
                    .overlay(Image(carouselItem.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25, corners: [.bottomLeft, .bottomRight, .topRight, .topLeft])
                    )
                    .frame(width: (UIScreen.main.bounds.width - (16*4)),height: 200 * 0.7)
                // AR Section
                ScrollView {
                    VStack(spacing: 0) {
                        ARMapCarouselSection(IconName: "arkit", title: "AR Experience", description: "Aim your camera towards the floriade map and you will see a foot appear. This foot will show you how big of a piece of ground a person needs to live. Using the feet in the top-right corner you can switch between different sizes").fixedSize(horizontal: false, vertical: true).padding(.bottom, 10)
                    Divider().frame(width: (UIScreen.main.bounds.width - (16*4)) * 0.9)
                    // Map Section
                    ARMapCarouselSection(IconName: "map", title: "Map Experience", description: "Two feet will be shown on the map in your screen. These feet will show the average dutch carbon footprint (in red) and the perfect one (in green). The blue point will be showing where you are located. While wandering about you will be able to see here if you are in one of the feet. This way you can get a feeling of the size of these feet and how much area you need.").padding(.top, 10).fixedSize(horizontal: false, vertical: true)
                    }
                }.disabled(UIScreen.main.bounds.height > 600)
                Spacer()
                Button(action: {
                    carouselModel.screenDrag = 0
                    if(carouselModel.activeCard == 0) {
                        carouselModel.activeCard += 1
                    }
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 0)
                            .fill(
                                Color.init(
                                    Color.RGBColorSpace.sRGB,
                                    red: 0.29,
                                    green: 0.64,
                                    blue: 0.28,
                                    opacity: 1))
                            .frame(width: 200, height: 50)
                            .cornerRadius(25)
                        HStack{
                            Text("Next".localized(langVar))
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        }
                    }.padding(.bottom, 20)
                }
            }
            // Responsible for carousel animation
        }.carouselItem(activeCard: carouselModel.activeCard)
            .shadow(color: Color.gray, radius: 2, x: 1, y: 2)
    }
}

struct Disclaimers: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "exclamationmark.circle").padding(.trailing, 3).font(.system(size: 10))
                Text("Your data will not be saved".localized(langVar)).font(.system(size: 10))
                Spacer()
            }.padding(.leading, 20)
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "exclamationmark.circle").padding(.trailing, 3).font(.system(size: 10))
                Text("Calcuted carbon footprint isn’t fully accurate".localized(langVar)).font(.system(size: 10))
                Spacer()
            }.padding(.leading, 20)
        }
    }
}

struct FootprintCarousel: View {
    var carouselItem: CarouselItem
    @EnvironmentObject var isMainHidden: isMainHiddenBool
    @EnvironmentObject var carouselModel: CarouselModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.init(Color.RGBColorSpace.sRGB, red: 0.88, green: 0.88, blue: 0.88, opacity: 1))
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.init(Color.RGBColorSpace.sRGB, red: 1, green: 1, blue: 1, opacity: 1))
                    .overlay(Image(carouselItem.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25, corners: [.bottomLeft, .bottomRight, .topRight, .topLeft])
                    )
                    .frame(width: (UIScreen.main.bounds.width - (16*4)),height: 200 * 0.7)
                ScrollView {
                    VStack(spacing: 0) {
                HStack {
                    Text("Carbon footprint".localized(langVar))
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 5)
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                HStack() {
                    Image("allfootprints").resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 100).padding(.leading, 20)
                    VStack(alignment: .leading) {
                        Text("The Dutch carbon footprint".localized(langVar)).font(.system(size: 14)).fixedSize(horizontal: false, vertical: true)
                        
                        Text("The ideal carbon footprint".localized(langVar)).font(.system(size: 14)).padding(.vertical, 5).fixedSize(horizontal: false, vertical: true)
                        
                        Text("Your personal carbon footprint".localized(langVar)).font(.system(size: 14)).fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                    HStack {
                        Text("You can switch between viewing the different footprints by selecting the feet show above.".localized(langVar)).padding(.horizontal, 20).padding(.vertical, 10).font(.system(size: 12)).fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                
                Divider().frame(width: (UIScreen.main.bounds.width - (16*4)) * 0.9)
                HStack {
                    Text("Your personal carbon footprint".localized(langVar))
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 5)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack {
                Text("By selecting your personal carbon footprint you can calculate your own footprint. Answer the 12 questions by draging the bar".localized(langVar))
                    .font(.system(size: 12))
                    .padding(.leading, 20)
                    .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                    
                Spacer()
                Disclaimers().padding(.bottom, 10)
                    }
                }.disabled(UIScreen.main.bounds.height > 600)
                Button(action: {
                    isMainHidden.hidden.toggle()
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 0)
                            .fill(
                                Color.init(
                                    Color.RGBColorSpace.sRGB,
                                    red: 0.29,
                                    green: 0.64,
                                    blue: 0.28,
                                    opacity: 1))
                            .frame(width: 200, height: 50)
                            .cornerRadius(25)
                        HStack{
                            Text("Start".localized(langVar))
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        }
                    }.padding(.bottom, 20)
                }
                
            }
            .onChange(of: carouselModel.activeCard) {_ in
                carouselModel.screenDrag = 0
            }
            .onChange(of: isMainHidden.hidden) {_ in
                carouselModel.screenDrag = 0
            }
            
        }.carouselItem(activeCard: carouselModel.activeCard)
            .shadow(color: Color.gray, radius: 2, x: 1, y: 2)
        
    }
}

struct CarouselScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var isMainHidden: isMainHiddenBool
    
    let CarouselItems = [
        CarouselItem(count: 0, name: "Explanation", description: "", image: "carousel1"),
        CarouselItem(count: 1, name: "Your footprint".localized(langVar), description: "After clicking the icon of your own footprint you will be able to calculate its size by answereing 12 questions. These questions can be answered by sliding a button. After these questions your foot will be shown on the map.".localized(langVar), image: "carousel2")
    ]
    
    var body: some View {
        return ZStack {
            Carousel(items: CarouselItems.count) { item in
                if (item == 0) {
                    ARMapCarousel(carouselItem: CarouselItems[item])
                } else {
                    FootprintCarousel(carouselItem: CarouselItems[item])
                }
                
            }
        }
    }
}

struct CarouselItem: Identifiable {
    let id = UUID()
    let count: Int
    let name: String
    let description: String
    let image: String
}
