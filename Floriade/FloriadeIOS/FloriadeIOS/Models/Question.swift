//
//  Question.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 22/03/2022.
//

import Foundation

struct Question: Identifiable, Decodable {
    var id: Int
    var question: String
    var sliderValues: [SliderValue]
    var explanation: String
}

struct SliderValue: Identifiable, Decodable {
    var id: Int
    var possibleAnswer: String
    var explanation: String
    var co2Value: Int
}
