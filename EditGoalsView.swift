//
//  EditGoalsView.swift
//  Fruitfull
//
//  Created by Abhijeet Raj Singh on 26/2/2025.
//

import SwiftUI

struct EditGoalsView: View {
    var body: some View {
        ZStack {
            
            VStack {
                Text("Edit Goals")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                
                VStack(spacing: 10) {
                    GoalView(title: "Sleep")
                    GoalView(title: "Movement")
                    GoalView(title: "Social")
                    GoalView(title: "Personal")
                    GoalView(title: "Downtime")
                }
                .padding(.horizontal, 20)
                .font(.system(size: 50))
                
                Spacer()
            }
            Image(systemName: "target")
                .resizable()
                .opacity(0.2)
                .frame(width: 400, height: 400)
                .offset(x: 100, y: 120)
        }
    }
}

struct GoalView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    EditGoalsView()
}
