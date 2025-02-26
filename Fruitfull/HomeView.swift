//
//  ContentView.swift
//  Fruitfull
//
//  Created by Yana Duran on 24/2/2025.
//

import SwiftUI

struct ActivityCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let score: Int
    let goalTime: Double
    let loggedTime: Double
}

struct HomeView: View {
    @State private var showAlert = false
    @State private var selectedCategory: ActivityCategory?
    
    let categories = [
        ActivityCategory(name: "Sleep", icon: "bed.double", color: .mint, score: 4, goalTime: 24, loggedTime: 19.2),
        ActivityCategory(name: "Movement", icon: "figure.walk", color: .blue, score: 3, goalTime: 24, loggedTime: 19.2),
        ActivityCategory(name: "Social", icon: "person.2", color: .yellow, score: 3, goalTime: 24, loggedTime: 19.2),
        ActivityCategory(name: "Personal", icon: "leaf", color: .green, score: 3, goalTime: 24, loggedTime: 13.2),
        ActivityCategory(name: "Downtime", icon: "clock", color: .orange, score: 3, goalTime: 24, loggedTime: 19.2),
        ActivityCategory(name: "Study", icon: "book", color: .purple, score: 3, goalTime: 24, loggedTime: 19.2),
        ActivityCategory(name: "Work", icon: "briefcase", color: .brown, score: 3, goalTime: 24, loggedTime: 19.2)
    ]
    
    let phrases = [
        "Well done, your week has been fruitful!", "Mid", "End"
    ]
    
//    let images: [String: Image] = [normalTree: Image("midTree"), fruitTree: Image("fruitTree"), deadTree: Image("deadTree") ]
        
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                headerView
                ScrollView {
                    mainContent
                }
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .alert("Category Details", isPresented: $showAlert, presenting: selectedCategory) { category in
                Button("Done", role: .cancel) { }
            } message: { category in
                VStack {
                    Text("\(category.name)")
                        .font(.headline)
                    Text("Goal: \(category.goalTime.formatted()) hours")
                    Text("Logged: \(category.loggedTime.formatted()) hours")
                    Text("Score: \(category.score)/5")
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("Fruitful")
                .font(.system(size: 34, weight: .bold)
                )
                .fontWidth(.expanded)
 
            
            Text("\(phrases[0])")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 20) {
            Image(.fruitTree) //make this like a list idk what the word was.
                .resizable()
                .scaledToFit()
                .padding(.vertical)
            
            Text("Your Week's Summary")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(categories) { category in
                categoryCard(category: category)
            }
            .frame(width: 370, height: 100)
            .padding(.bottom, 1)
        }
        
    }
    
    private func categoryCard(category: ActivityCategory) -> some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: category.icon)
                        .symbolVariant(.fill)
                        .foregroundColor(category.color)
                        .font(.title3)
                    
                    Text(category.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button {
                        selectedCategory = category
                        showAlert = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.secondary)
                    }
                }
                
                ProgressView(value: category.loggedTime, total: category.goalTime)
                    .progressViewStyle(CustomProgressStyle(color: category.color))
                
                HStack {
                    Text("\(category.loggedTime.formatted(.number.precision(.fractionLength(1))))h logged")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("Goal: \(category.goalTime.formatted(.number.precision(.fractionLength(1))))h")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            )
        }
    }
    
    
    struct CustomProgressStyle: ProgressViewStyle {
        var color: Color
        
        func makeBody(configuration: Configuration) -> some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundColor(color.opacity(0.2))
                    
                    Capsule()
                        .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0),
                               height: 8)
                        .foregroundColor(color)
                        .animation(.easeInOut, value: configuration.fractionCompleted)
                }
            }
            .frame(height: 8)
        }
    }
}
    
    
#Preview {
    HomeView()
}

