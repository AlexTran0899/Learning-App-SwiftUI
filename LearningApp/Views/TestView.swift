//
//  TestView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/24/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State private var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack(alignment: .leading){
                // Question number
                Text("Question \(model.currentQuestionIndex! + 1) of \(model.currModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                // Answers
                ScrollView {
                    VStack (alignment: .leading){
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button {
                                // Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack{
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    } else {
                                        if (index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex) || index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        } else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                        } else {
                                            RectangleCard()
                                                .frame(height: 48)
                                        }
                                    }
                                    Text(model.currentQuestion!.answers[index])
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }.disabled(submitted)
                        }
                    }.padding(20)
                }
                Button {
                    if submitted == true {
                        // Answer has already been submitted, move to the next question
                        model.nextQuestion()
                        // reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    } else {
                        submitted = true
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        Text(buttonText)
                            .foregroundColor(.white)
                            .bold()
                    }
                }.disabled(selectedAnswerIndex == nil)
                    .padding(.horizontal, 20)
            }
            .navigationBarTitle("\(model.currModule?.category ?? "") Test")
        } else {
            ProgressView()
            TestResultView(numCorrect: numCorrect)
        }
    }
    var buttonText: String {
        // check if answer has been submited
        if submitted == true {
            if (model.currentQuestionIndex ?? 0) + 1 == model.currModule!.test.questions.count {
                return "Finish"
            } else {
                return "Next question"
            }
        } else {
            return "Submit"
        }
    }
}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = ContentModel()
//        TestView()
//            .onAppear {
//                model.beginModule(0)
//                model.beginTest(0)
//            }
//            .environmentObject(model)
//    }
//}
