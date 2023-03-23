//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
