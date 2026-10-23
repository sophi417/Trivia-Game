//
//  TriviaView.swift
//  Trivia Game
//
//  Created by Sophia Sartor on 10/22/26.
//
import SwiftUI
import Combine

struct TriviaView: View {
    let amount: Int
    let category: Int
    let difficulty: String
    let type: String
    
    @State private var questions: [TriviaQuestion] = []
    @State private var isLoading = true
    @State private var errorMessage = ""
    @State private var selectedAnswers: [UUID: String] = [:] // question id -> picked answer
    @State private var showScore = false
    @State private var score = 0
    @Environment(\.dismiss) private var dismiss
    //fires every 1 second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var submitted = false
    @State private var timeLeft = 0
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading questions...")
            } else if !errorMessage.isEmpty {
                Text(errorMessage)
                    .padding()
            } else {
                Text("Time left: \(timeLeft)s")
                    .font(.headline)
                    .foregroundStyle(timeLeft <= 10 && !submitted ? .red : .primary)
                    .padding(.top)
                
                // one card per question, swipe to move
                TabView {
                    ForEach(Array(questions.enumerated()), id: \.element.id) { index, q in
                        CardView(
                            question: q,
                            number: index + 1,
                            total: questions.count,
                            selectedAnswer: selectedAnswers[q.id],
                            showResult: submitted
                        ) { answer in
                            selectedAnswers[q.id] = answer
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                Button("Submit") {
                    submit()
                }
                .buttonStyle(.borderedProminent)
                .disabled(submitted)
                
                .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .task {
            await fetchQuestions()
        }
       
        .onReceive(timer) { _ in
            // dont count while loading, after submit, or if theres an error
            if isLoading || submitted || !errorMessage.isEmpty { return }

            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                submit() // times up
            }
        }
        .alert("Results", isPresented: $showScore) {
            Button("Play Again") { dismiss() }
            Button("OK", role: .cancel) { }
        } message: {
            Text("You got \(score) out of \(questions.count) correct!")
        }
    }
    
    func fetchQuestions() async {
        // build the url from the options
        var urlString = "https://opentdb.com/api.php?amount=\(amount)&encode=url3986"
        if category != 0 { urlString += "&category=\(category)" }
        if difficulty != "" { urlString += "&difficulty=\(difficulty)" }
        if type != "" { urlString += "&type=\(type)" }
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(TriviaResponse.self, from: data)
            
            if response.responseCode != 0 {
                errorMessage = "Couldn't get questions (code \(response.responseCode)). Try different options."
                isLoading = false
                return
            }
            
            // put all the answers together and shuffle
            var list = response.results
            for i in list.indices {
                if list[i].type == "boolean" {
                    list[i].allAnswers = ["True", "False"]
                } else {
                    list[i].allAnswers = (list[i].incorrectAnswers + [list[i].correctAnswer]).shuffled()
                }
            }
            questions = list
            timeLeft = list.count * 10 // 10 seconds per question
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // counts correct answers then sends the score back
    func calculateScore(completion: (Int) -> Void) {
        var correct = 0
        for q in questions {
            if selectedAnswers[q.id] == q.correctAnswer {
                correct += 1
            }
        }
        completion(correct)
    }
    
    func submit() {
        calculateScore { result in
            score = result
            submitted = true
            showScore = true
        }
    }
}
