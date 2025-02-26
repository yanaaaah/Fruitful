//
//  ContentView.swift
//  Fruitfull
//
//  Created by Yana Duran on 24/2/2025.
//

import SwiftUI

struct LoggingView: View {

    @Environment(DayDataStore.self) private var dayDataStore
    
    @State private var sleep = 0.0
    @State private var movement = 0.0
    @State private var social = 0.0
    @State private var personal = 0.0
    @State private var downtime = 0.0
    @State private var study = 0.0
    @State private var work = 0.0
    
    
    @State private var showingAlerttoomuch: Bool = false
    @State private var alertTitletoomuch: String = "Error"
    @State private var alertMessagetoomuch: String = "You've exceeded the total time amount per day."
    @State private var alertButtonTexttoomuch: String = "Done"
    @State private var total = 0.0
    
    
    var body: some View {
        VStack(spacing: 8)
        {
            Text("Today")
                .font(.system(size:34, weight:.bold))
            
            NavigationStack {
                ScrollView {
                    VStack {
                        Text("How did you water your tree today?")
                           // .font(.title)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        //.fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        EditGoalsBubbleSubView(title: "🍏 Sleep", value: $sleep, colour: .sleepColour, alertTitle: "Sleep Information", alertMessage: "Sleep is cruicial for enhacing overall well-being and cognitive function with most people needing 7-9 hours.", alertButtonText: "Done" )
                        EditGoalsBubbleSubView(title: "🫐 Movement", value: $movement, colour: .movementColour, alertTitle: "Movement Information", alertMessage: "Physical movement is important for overall health and well-being and recommended 30mins a day.", alertButtonText: "Done" )
                        EditGoalsBubbleSubView(title: "🍋 Social", value: $social, colour: .socialColour, alertTitle: "Social Information", alertMessage: "Regular social connection is important to combat loneliness and foster emtional wellbeing. This can incude seeing friends and family.", alertButtonText: "Done" )
                        EditGoalsBubbleSubView(title: "🍊 Personal", value: $personal, colour: .personalColour, alertTitle: "Personal Information", alertMessage: "This includes time dedicated  to hobbies, running errands, attending appointments or engaging in activities that contribute to your personal wellbeing.", alertButtonText: "Done" )
                        EditGoalsBubbleSubView(title: "🥭 Downtime", value: $downtime, colour: .downtimeColour, alertTitle: "Downtime Information", alertMessage: "This is time spent doing nothing in particular, like scrolling on your phone or simply lying in bed. Rest is essential, so don’t feel guilty as your mind and body need it.", alertButtonText: "Done" )
                        
                        VStack{
                            HStack{
                                //Image(systemName: "book")
                                Text("🍇 Study")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                
                            }
                            Slider(value: $study, in: 0...24, step:0.5)
                            HStack{
                                Text("\(String(format: "%.1f", Double(study))) hours per day")
                            }
                        }
                        .padding(20)
                        .background(Color.studyColour.opacity(0.20))
                        .cornerRadius(30)
                        
                        
                        VStack{
                            HStack{
                                //Image(systemName: "briefcase")
                                Text("🍓 Work")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            Slider(value: $work, in: 0...24, step:0.5)
                            HStack{
                                Text("\(String(format: "%.1f", Double(work))) hours per day")
                            }
                        }
                        .padding(20)
                        .background(Color.workColour.opacity(0.20))
                        .cornerRadius(30)
                    }
                    Text("Total Hours Logged: \(String(format: "%.1f", Double(sleep + study + movement + social + work + personal + downtime)))\n")
                        .font(.title2)
                    Button("Save") {
                        let dayData = DaySet(sleep: sleep, movement: movement, social: social, personal: personal, downtime: downtime, study: study, work: work)
                        // Create an array for storing this dayData.
                        // Add the dayData to the array.
                        dayDataStore.dayDataArray.append(dayData)
                        //  dayDataStore.goalData = goalData
                        print(dayDataStore.dayDataArray)
                    }
                    .padding()
                    .background(.gray.opacity(0.25))
                    .cornerRadius(30)
                }
                .onChange(of: sleep + study + movement + social + work + personal + downtime, checkHoursNotExceeded)
                .alert(Text(alertTitletoomuch), isPresented: $showingAlerttoomuch) {
                    Button(alertButtonTexttoomuch) {
                        
                    }
                } message: {
                    Text(alertMessagetoomuch)
                    
                }
                //.navigationBarTitle("Today", displayMode: .large)
                //.navigationBarTitleDisplayMode(.centered)
            }
            .padding(15)
        }
    }
    
    func checkHoursNotExceeded() {
        if sleep + study + movement + social + work + personal + downtime > 24 {
            showingAlerttoomuch = true
        }
    }
}


#Preview {
    @Previewable @State var dayDataStore = DayDataStore()
    LoggingView()
        .environment(dayDataStore)
}
