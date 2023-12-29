//
//  Answers.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 22/03/2022.
//

import Foundation

class Answer: ObservableObject {
    var question: Question
    var co2Answer: Int
    
    init(question: Question, answer: Int) {
        self.question = question;
        self.co2Answer = answer
    }
}

class Answers: ObservableObject {
    @Published var answers: [Answer]
    
    // Loads all questions.json to a list of answers
    init() {
        let questions: [Question] = JSON.loadJSON("Questions.json")
        var answers: [Answer] = []
        
        for question in questions {
            let answer = Answer(question: question, answer: question.sliderValues[2].co2Value)
            answers.append(answer)
        }
        self.answers = answers
    }
}
