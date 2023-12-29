//
//  ARTutorialOverlay.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 29/03/2022.
//

import SwiftUI

struct ARTutorialOverlay: View {
    @EnvironmentObject var foot: Foot
    
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 0) {
                    Image("ARTutorialImage")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 125, height: 175)
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.8).padding(.top, 10)
                    Text("AR Footprint".localized(langVar))
                        .fontWeight(.semibold)
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                    Text("Use your phone to scan the map given to you at the entrance or use one of the sign placed around the floriade.".localized(langVar))
                        .padding(.horizontal, 10)
                        .font(.system(size: 12))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        foot.hasBeenRenderedOnce = true
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
                                .frame(width: 125, height: 40)
                                .cornerRadius(25)
                            HStack{
                                Text("OK".localized(langVar))
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        }.padding(.bottom, 10)
                    }
                }
                
            }.frame(width: UIScreen.main.bounds.width - 20, height: 300)
                .background(.white.opacity(0.7))
                .cornerRadius(20)
        }
    }
}

struct ARTutorialOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ARTutorialOverlay()
    }
}
