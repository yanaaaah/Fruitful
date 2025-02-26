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
    
    @Environment(DayDataStore.self) private var dayDataStore
    
    @State private var showInfoAlert = false
    @State private var showFruitAlert = false
    @State private var selectedInfoCategory: ActivityCategory?
    @State private var selectedFruitCategory: ActivityCategory?
    @State private var alertQueue: [ActivityCategory] = []
    @State private var alertedCategories = Set<UUID>()
    var count: Int = 0 //for the commit
    
    
    @State var categories: [ActivityCategory] = []
    
    let phrases = [
        "Well done, your week has been fruitful!",
        "Keep going! There's still more fruit to grow!",
        "Let's start growing some fruit!"
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
            .alert("Sleep Details",
                   isPresented: $showInfoAlert,
                   presenting: selectedInfoCategory) { _ in
                Button("OK") { }
            } message: { category in
                VStack {        //FIX THIS - IT REPEATS FOR ALL THE CATEGORIES (STUDY AND WORK SHOULDN'T HAVE INFO ICON
                    Text("Sleep is cruicial for enhacing overall well-being and cognitive function with most people needing 7-9 hours.")
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
        .onAppear {
            let averageSleep = dayDataStore.dayDataArray.map { $0.sleep }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            let averageMovement = dayDataStore.dayDataArray.map { $0.movement }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            let averageSocial = dayDataStore.dayDataArray.map { $0.social }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            let averagePersonal = dayDataStore.dayDataArray.map { $0.personal }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            let averageDowntime = dayDataStore.dayDataArray.map { $0.downtime }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            let averageStudy = dayDataStore.dayDataArray.map { $0.study }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            let averageWork = dayDataStore.dayDataArray.map { $0.work }.reduce(0, +) / Double(dayDataStore.dayDataArray.count)
            
            categories = [
                ActivityCategory(name: "Sleep", color: .sleepColour, score: 4, goalTime: dayDataStore.goalData?.sleep ?? 0, loggedTime: averageSleep, fruitEmoji: "🍏"),
                ActivityCategory(name: "Movement", color: .movementColour, score: 3, goalTime:dayDataStore.goalData?.movement ?? 0, loggedTime: averageMovement, fruitEmoji: "🫐"),
                ActivityCategory(name: "Social", color: .socialColour, score: 3, goalTime: dayDataStore.goalData?.social ?? 0, loggedTime: averageSocial, fruitEmoji: "🍍"),
                ActivityCategory(name: "Personal", color: .personalColour, score: 3, goalTime:dayDataStore.goalData?.personal ?? 0, loggedTime: averagePersonal, fruitEmoji: "🍊"),
                ActivityCategory(name: "Downtime", color: .downtimeColour, score: 3, goalTime: dayDataStore.goalData?.downtime ?? 0, loggedTime: averageDowntime, fruitEmoji: "🍉"),
                ActivityCategory(name: "Study", color: .studyColour, score: 3, goalTime:dayDataStore.goalData?.study ?? 0, loggedTime: averageStudy, fruitEmoji: "🍇"),
                ActivityCategory(name: "Work", color: .workColour, score: 3, goalTime: dayDataStore.goalData?.work ?? 0, loggedTime: averageWork, fruitEmoji: "🍓")
            ]
        }
    }
    
    private var fruitsEarned: Int {
        categories.filter { $0.loggedTime >= $0.goalTime }.count
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("Fruitful")
                .font(.system(size: 34, weight: .bold))
                //.fontWidth(.bold)
            
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
    @Previewable @State var dayDataStore = DayDataStore()
    HomeView()
        .environment(dayDataStore)
}
