//
//  ContentView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        ScrollView {
            LazyVStack {
                if model.currModule != nil {
                    ForEach(0..<model.currModule!.content.lessons.count, id: \.self) { index in
                        NavigationLink {
                            ContentDetailView()
                                .onAppear{
                                    model.beginLesson(index)
                                }
                        } label: {
                            ContentViewRow(index: index)
                        }
                    }
                }
            }.navigationBarTitle("Learn \(model.currModule?.category ?? "")")
                .accentColor(.black)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ContentModel()
        ContentView()
            .environmentObject(model)
            .onAppear{
                model.beginModule(0)
            }
    }
}
