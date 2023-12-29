//
//  UIImage+resize.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 30/03/2022.
//

import Foundation
import SwiftUI

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
