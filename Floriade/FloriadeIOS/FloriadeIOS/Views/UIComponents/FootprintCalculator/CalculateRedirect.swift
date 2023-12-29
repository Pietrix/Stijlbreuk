//
//  CalculateRedirect.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 22/03/2022.
//

import Foundation
import SwiftUI

struct CalculateRedirect: View {
    let componentHeight: Double
    @EnvironmentObject var cardExpanded: cardExpendedBool
    
    var body: some View {
        HStack {
            Button(action: {
                cardExpanded.expanded.toggle()
            }) {
                Text("Calculate".localized(langVar))
                    .foregroundColor(.white)
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(uiColor: UIColor(red: 0.29, green: 0.64, blue: 0.28, alpha: 1.00)))
            .font(.system(size: 14))
            .cornerRadius(25)
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: componentHeight * 0.4)
    }
}
