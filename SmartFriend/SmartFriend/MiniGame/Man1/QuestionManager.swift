//
//  QuestionManager.swift
//  Challenge
//
//  Created by Trinh Thai on 5/4/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation

class QuestionManager{
    private let questions:[(question: String, correctAnswer: String, options: [String])] =
        [(question: "ok", correctAnswer: "2",
          options: ["0", "1", "2", "3"]),(
            question: "ok2", correctAnswer: "1",
            options: ["A", "B", "2", "3"]),(
                question: "ok2", correctAnswer: "3",
                options: ["C", "D", "2", "3"])]
    
    private var SoCauDaTL=0
    private var SoCauDung=0
    private var quest: Question!
    var question: String {
        return quest.question
    }
    var options: [String] {
        return quest.options
    }
    var totalAnswers: Int {
        return SoCauDaTL
    }
    var totalCorrectAnswers: Int {
        return SoCauDung
    }
    func refreshQuiz() {
        let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        let Data = questions[randomIndex]
        quest = Question(question: Data.question, options: Data.options,correctedAnswer: Data.correctAnswer)
    }
    
    func validadeAnswer(index: Int) {
        SoCauDaTL += 1
        if quest.validateOption(index) {
            SoCauDung += 1
        }
    }
    
}
