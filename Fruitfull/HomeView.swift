//
//  ContentView.swift
//  Fruitfull
//
//  Created by Amogh Sharma on 24/2/2025.
//

import SwiftUI

struct ActivityCategory: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let score: Int
    let goalTime: Double
    let loggedTime: Double
    let fruitEmoji: String
}

struct HomeView: View {
    @State private var showInfoAlert = false
    @State private var showFruitAlert = false
    @State private var selectedInfoCategory: ActivityCategory?
    @State private var selectedFruitCategory: ActivityCategory?
    @State private var alertQueue: [ActivityCategory] = []
    @State private var alertedCategories = Set<UUID>()
    var count: Int = 0 //for the commit
    
    
    let categories = [
        ActivityCategory(name: "Sleep", color: .mint, score: 4, goalTime: 24, loggedTime: 24, fruitEmoji: "🍏"),
        ActivityCategory(name: "Movement", color: .blue, score: 3, goalTime: 24, loggedTime: 24, fruitEmoji: "🍊"),
        ActivityCategory(name: "Social", color: .yellow, score: 3, goalTime: 24, loggedTime: 24, fruitEmoji: "🍇"),
        ActivityCategory(name: "Personal", color: .green, score: 3, goalTime: 24, loggedTime: 24, fruitEmoji: "🍓"),
        ActivityCategory(name: "Downtime", color: .orange, score: 3, goalTime: 24, loggedTime: 24, fruitEmoji: "🥭"),
        ActivityCategory(name: "Study", color: .purple, score: 3, goalTime: 24, loggedTime: 24, fruitEmoji: "🍑"),
        ActivityCategory(name: "Work", color: .brown, score: 3, goalTime: 24, loggedTime: 24, fruitEmoji: "🍒")
    ]
    
    let phrases = [
        "Well done, your week has been fruitful!",
        "Keep going! You've got this!",
        "Time to make progress!"
    ]
    
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
            // Fruit earned alert
            .alert("Fruit Earned! \(selectedFruitCategory?.fruitEmoji ?? "")",
                   isPresented: $showFruitAlert,
                   presenting: selectedFruitCategory) { _ in
                Button("OK") { showNextAlert() }
            } message: { category in
                Text("You earned a \(category.fruitEmoji) for completing \(category.name) goals!")
            }
            // Info alert
            .alert("Category Details",
                   isPresented: $showInfoAlert,
                   presenting: selectedInfoCategory) { _ in
                Button("OK") { }
            } message: { category in
                VStack {
                    Text("\(category.name)")
                        .font(.headline)
                    Text("Goal: \(category.goalTime.formatted()) hours")
                    Text("Logged: \(category.loggedTime.formatted()) hours")
                    Text("Score: \(category.score)/5")
                }
            }
            .onAppear {
                checkCompletedCategories()
            }
        }
    }
    
    private var fruitsEarned: Int {
        categories.filter { $0.loggedTime >= $0.goalTime }.count
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("Fruitful")
                .font(.system(size: 34, weight: .bold))
                .fontWidth(.expanded)
            
            Group {
                if fruitsEarned <= 1 {
                    Text(phrases[2])
                } else if fruitsEarned <= 4 {
                    Text(phrases[1])
                } else {
                    Text(phrases[0])
                }
            }
            .font(.headline)
            .foregroundColor(.secondary)
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 20) {
            ZStack {
                Image(.originalTree)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
                
                ForEach(categories) { category in
                    if category.loggedTime >= category.goalTime {
                        Button {
                            selectedFruitCategory = category
                            showFruitAlert = true
                        } label: {
                            Text(category.fruitEmoji)
                                .font(.system(size: 40))
                                .hoverEffect(.lift)
                        }
                        .buttonStyle(.plain)
                        .offset(fruitPosition(for: category.name))
                    }
                }
            }
            
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
            VStack(alignment: .leading, spacing: 11) {
                HStack {
                    Text("\(category.fruitEmoji)")
                        .foregroundColor(category.color)
                        .font(.title3)
                    
                    Text(category.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button {
                        selectedInfoCategory = category
                        showInfoAlert = true
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
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2))
            }
    }
    
    private func fruitPosition(for category: String) -> CGSize {
        switch category {
        case "Sleep": return CGSize(width: -50, height: -120)
        case "Movement": return CGSize(width: 30, height: -80)
        case "Social": return CGSize(width: 90, height: -120)
        case "Personal": return CGSize(width: -130, height: -80)
        case "Downtime": return CGSize(width: -40, height: -50)
        case "Study": return CGSize(width: 100, height: -60)
        case "Work": return CGSize(width: 20, height: -150)
        default: return .zero
        }
    }
    
    private func checkCompletedCategories() {
        let completed = categories.filter { $0.loggedTime >= $0.goalTime }
        alertQueue = completed.filter { !alertedCategories.contains($0.id) }
        showNextAlert()
    }
    
    private func showNextAlert() {
        guard let next = alertQueue.first else { return }
        selectedFruitCategory = next
        showFruitAlert = true
        alertedCategories.insert(next.id)
        alertQueue.removeFirst()
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

#Preview {
    HomeView()
}
