//
//  EditGoalsBubbleSubView.swift
//  Fruitfull
//
//  Created by Tilly Nicoll on 25/2/2025.
//

import SwiftUI

struct EditGoalsBubbleSubView: View {
    @State private var infoAlert = false
    
    @State var symbol = ""
    var title: String
    @Binding var value: Double
    var colour: Color
    
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var alertButtonText = ""
    
    var body: some View {
        VStack{
            HStack {
                
                Image(systemName: symbol)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    infoAlert = true
                } label: {
                    Image(systemName:"info.circle")
                }
                .alert(Text(alertTitle), isPresented: $infoAlert) {
                    Button(alertButtonText) {
                        
                    }
                } message: {
                    Text(alertMessage)
                    
                }
            }
            Slider(value: $value, in: 0...24, step: 0.5)
            HStack{
                Text("\(String(format: "%.1f", Double(value))) hours a day ")
            }
            
        }
        .padding(20)
        .background(colour.opacity(0.25))
        .cornerRadius(30)
    }
}

#Preview {
    EditGoalsBubbleSubView( symbol: "bed.double.fill", title: "Sleep", value: .constant(0), colour: .blue, alertTitle: "", alertMessage: "", alertButtonText: "done" )
}

