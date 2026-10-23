//
//  ContentView.swift
//  Trivia Game
//
//  Created by Sophia Sartor on 10/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var numQuestions = 10
    @State private var category = 0
    @State private var difficulty = ""
    @State private var type = ""

    //category ids from the api (0 = any)
    let categories: [(name: String, id: Int)] = [
        ("Any", 0),
        ("General Knowledge", 9),
        ("Books", 10),
        ("Film", 11),
        ("Music", 12),
        ("Television", 14),
        ("Video Games", 15),
        ("Science & Nature", 17),
        ("Computers", 18),
        ("Sports", 21),
        ("Geography", 22),
        ("History", 23),
        ("Animals", 27)
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Options") {
                    Stepper("Questions: \(numQuestions)", value: $numQuestions, in: 1...50)

                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.id) { cat in
                            Text(cat.name).tag(cat.id)
                        }
                    }

                    Picker("Difficulty", selection: $difficulty) {
                        Text("Any").tag("")
                        Text("Easy").tag("easy")
                        Text("Medium").tag("medium")
                        Text("Hard").tag("hard")
                    }

                    Picker("Type", selection: $type) {
                        Text("Any").tag("")
                        Text("Multiple Choice").tag("multiple")
                        Text("True / False").tag("boolean")
                    }
                }

                Section {
                    NavigationLink("Start Trivia") {
                        TriviaView(amount: numQuestions, category: category, difficulty: difficulty, type: type)
                    }
                }
            }
            .navigationTitle("Trivia")
        }
    }
}

#Preview {
    ContentView()
}
