//
//  QuestionSlider.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 22/03/2022.
//

import Foundation
import SwiftUI

struct QuestionSlider: View {
    @State var value: Double = 3.0
    @State var sliderAmount: Int = 3
    @Binding var questionNumber: Int
    @EnvironmentObject var answers: Answers
    let componentHeight: Double
    @EnvironmentObject var cardExpanded: cardExpendedBool
    @EnvironmentObject var foot: Foot
    
    var body: some View {
        VStack {
            SwiftUISlider(thumbColor: UIColor(red: 0.17, green: 0.48, blue: 0.16, alpha: 1.00), minTrackColor: UIColor(red: 0.29, green: 0.64, blue: 0.28, alpha: 1.00), value: $value)
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .onChange(of: value) { newValue in
                    sliderAmount = Int(newValue.rounded())
                }
            Text(answers.answers[questionNumber - 1].question.sliderValues[sliderAmount - 1].possibleAnswer.localized(langVar))
                .bold()
                
            Text(answers.answers[questionNumber - 1].question.sliderValues[sliderAmount - 1].explanation.localized(langVar)).fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                // Updates the previous answer to the new entered answer
                answers.answers[questionNumber - 1].co2Answer = answers.answers[questionNumber - 1].question.sliderValues[sliderAmount - 1].co2Value
                
                // Checks if its the last question
                if (questionNumber + 1 > answers.answers.count) {
                    // Calculates the score to hectares
                    var co2: Int = 0
                    for answer in answers.answers {
                        co2 += answer.co2Answer
                    }
                    let personalHa = Double(co2) / Double(1900)
                        foot.personalFootSelected = true
                        foot.personalFootScale = round(personalHa * 10) / 10.0
                        cardExpanded.expanded = false
                    foot.recalculatingFoot = false
                    
                } else {
                    questionNumber += 1
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
                }
                
            }
            
            Button(action: {
                answers.answers[questionNumber - 1].co2Answer = answers.answers[questionNumber - 1].question.sliderValues[sliderAmount - 1].co2Value
                if (questionNumber - 1 < 1) {
                    cardExpanded.expanded.toggle()
                    foot.recalculatingFoot = false
                } else {
                    questionNumber -= 1
                }
            }) {
                Text("Back".localized(langVar)).foregroundColor(Color(UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)))
            }
            .padding(.top, 15)
            .padding(.horizontal, 10.0)
            .padding(.bottom, 30)
            .font(.system(size: 20))
            .cornerRadius(25)
        }.task(id: questionNumber) {
            // Updates the slidevalues when going to new question
            let newValue = answers.answers[questionNumber - 1].question.sliderValues.firstIndex(where: {$0.co2Value == answers.answers[questionNumber - 1].co2Answer})!
            
            value = Double(newValue + 1)
            sliderAmount = newValue + 1
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: componentHeight * 1.9)
    }
}
