//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import SwiftUI

struct ContentViewRow: View {
    @EnvironmentObject var model: ContentModel
    @State var index: Int
    
    var body: some View {
        ZStack(alignment: .leading){
            if model.currModule != nil {
                let lesson = model.currModule!.content.lessons[index]
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10, x: -5, y: 5)
                    .frame(height: 66)
                HStack {
                    Text(String(index + 1))
                    VStack(alignment: .leading) {
                        Text(lesson.title)
                            .font(.headline)
                        Text(lesson.duration)
                            .font(.caption)
                    }.padding(.leading, 10)
                }.padding()
            }
        }
    }
}

struct ContentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = ContentModel()
        ContentViewRow(index: 0)
            .environmentObject(model)
            .onAppear {
                model.beginModule(0)
            }
        
    }
}
