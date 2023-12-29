//
//  AVPlayer+extension.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 15/03/2022.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
