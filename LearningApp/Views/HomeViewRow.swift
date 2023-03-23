//
//  CardView.swift
//  LearningApp
//
//  Created by Alex Tran on 3/23/23.
//

import SwiftUI

struct HomeViewRow: View {
    var title: String
    var description: String
    var image: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5, x: -5, y: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    // Headline
                    Text(title)
                        .bold()
                    Text(description)
                        .font(.caption)
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.leading)
                    HStack(alignment: .bottom) {
                        // number of lessons and questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count).font(.system(size: 10))
                        Spacer()
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time).font(.system(size: 10))
                    }
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(title: "learn swift", description: "some description", image: "swift", count: "10 Lessons", time: "2 Hours")
    }
}
