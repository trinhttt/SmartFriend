//
//  Question.swift
//  Challenge
//
//  Created by Trinh Thai on 5/4/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation
class Question{
    let question: String
    let options: [String]
    private let correctedAnswer: String
    init(question: String, options: [String], correctedAnswer: String) {
        self.question = question
        self.options = options
        self.correctedAnswer = correctedAnswer
    }
    func validateOption(_ index: Int) -> Bool {
        let answer = options[index]
        return answer == correctedAnswer
    }
}
