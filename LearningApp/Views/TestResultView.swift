//
//  TestResultView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/24/23.
//

import SwiftUI

struct TestResultView: View {
    @EnvironmentObject var model: ContentModel
    @State var numCorrect: Int
    
    var body: some View {
        VStack {
            Text("Doing great!")
                .font(.title)
            Text("You got  \(numCorrect) out of \(model.currModule?.test.questions.count ?? 0) questions")
            Button {
                model.currentTestSelected = nil
            } label: {
                ZStack{
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    Text("Complete")
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }.padding()
    }
}
//
//struct TestResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultView()
//            .environmentObject(model)
//    }
//}
