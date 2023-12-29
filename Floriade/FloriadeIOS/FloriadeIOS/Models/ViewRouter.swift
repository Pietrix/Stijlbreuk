import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: String = "SplashScreen" {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
    @ViewBuilder
    func getCurrentView() -> some View {
        switch(currentPage) {
        case "LanguageScreen":
            LanguageScreen()
        case "ARScreen":
            ARScreen()
        case "MapScreen":
            MapScreen()
        default:
            SplashScreen()
        }
    }
}
