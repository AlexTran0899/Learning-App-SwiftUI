//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        VStack{
            //            let lesson = model.currLesson
            let url = URL(string: "\(Constants.videoHostUrl)Learning-App-SwiftUI/blob/main/How%20to%20activate%20an%20eSIM%20on%20your%20iPhone%20%7C%20Apple%20Support.mp4?raw=true")
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
                    .aspectRatio(CGSize(width: 1920, height: 1080), contentMode: .fit)
            }
            Spacer()
            // Description
            CodeTextView()
            if (model.hasNextLesson() == true) {
                Button {
                    model.nextLesson()
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        Text("Next Lesson: \(model.nextLessonTitle())")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            } else {
                Button {
                    model.currentContentSelected = nil
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        Text("Complete: Back to home Screen")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
        }
        .navigationTitle(model.currLesson?.title ?? "")
        .padding()
    }
}

//struct ContentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = ContentModel()
//        ContentDetailView()
//            .onAppear{
//                model.beginModule(0)
//                model.beginLesson(0)
//            }
//            .environmentObject(model)
//    }
//}
