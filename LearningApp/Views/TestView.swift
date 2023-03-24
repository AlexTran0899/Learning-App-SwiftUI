//
//  TestView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/24/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        if model.currentQuestion != nil {
            VStack{
                // Question number
                Text("Question \(model.currentQuestionIndex! + 1) of \(model.currModule?.test.questions.count ?? 0)")
                // Question
                CodeTextView()
                // Answers
                // Button
            }.navigationBarTitle("\(model.currModule?.category ?? "") Test")
        } else {
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ContentModel()
        TestView()
            .onAppear{
                model.beginTest(0)
            }
            .environmentObject(model)
    }
}
