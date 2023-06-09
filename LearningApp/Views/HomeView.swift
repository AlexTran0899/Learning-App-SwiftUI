//
//  ContentView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView {
            ScrollView  {
                LazyVStack(alignment: .leading, spacing: 20) {
                    Text("What do you want to do today?")
                    ForEach(model.modules) { m in
                        NavigationLink(tag: m.id, selection: $model.currentContentSelected, destination: {
                            ContentView()
                                .onAppear {
                                    model.beginModule(m.id)
                                }
                        }, label: {
                            // learning card
                            HomeViewRow(title: "Learn \(m.category)", description: m.content.description, image: m.content.image, count: "\(m.content.lessons.count) Lessons", time: m.content.time)
                        })
                        NavigationLink(tag: m.id, selection: $model.currentTestSelected, destination: {
                            TestView()
                                .onAppear{
                                    model.beginTest(m.id)
                                }
                        }, label: {
                            HomeViewRow(title: "\(m.category) Test", description: m.test.description, image: m.test.image, count: "\(m.test.questions.count) Questions", time: m.test.time)
                        })
                    }
                }.accentColor(.black)
                    .padding()
            }.navigationTitle("Get Started")
                .onChange(of: model.currentContentSelected) { changeValue in
                    if changeValue == nil {
                        model.currModule = nil
                    }
                }
        }.navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
