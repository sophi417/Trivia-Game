//
//  CardView.swift
//  Trivia Game
//
//  Created by Sophia Sartor on 10/23/26.
//
import SwiftUI

struct CardView: View {
    let question: TriviaQuestion
    let number: Int
    let total: Int
    let selectedAnswer: String?
   
    let showResult: Bool
    let onSelect: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Question \(number) of \(total)")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(question.category.decoded)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(question.question.decoded)
                .font(.title3)
                .bold()

            // answer buttons
            ForEach(question.allAnswers, id: \.self) { answer in
                Button {
                    onSelect(answer)
                } label: {
                    Text(answer.decoded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(color(for: answer))
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .disabled(showResult) // cant change after submitting
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
        .padding(.bottom, 30) // room for the page dots
    }

    // picks the color for each answer
    func color(for answer: String) -> Color {
        if showResult {
            if answer == question.correctAnswer {
                return Color.green.opacity(0.4)
            }
            if answer == selectedAnswer {
                return Color.red.opacity(0.4)
            }
        }
        if answer == selectedAnswer {
            return Color.blue.opacity(0.3)
        }
        return Color.gray.opacity(0.15)
    }
}
