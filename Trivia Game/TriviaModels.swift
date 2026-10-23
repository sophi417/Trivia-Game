//
//  TriviaModels.swift
//  Trivia Game
//
//  Created by Sophia Sartor on 10/22/26.
//

import Foundation

struct TriviaResponse: Codable {
        let responseCode: Int
        let results: [TriviaQuestion]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}


struct TriviaQuestion: Codable,         Identifiable {
    var id = UUID()
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    var allAnswers: [String] = [] //shuffled answers

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

// api text comes encoded, this turns it back to normal
extension String {
    var decoded: String {
        return self.removingPercentEncoding ?? self
    }
}
