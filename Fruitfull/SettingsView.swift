//
//  SettingsView.swift
//  Fruitfull
//
//  Created by Abhijeet Raj Singh on 26/2/2025.
//

import SwiftUI
struct SettingsView: View {
    var body: some View {
        ZStack {
            
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                
                VStack(spacing: 10) {
                    SettingsOptionRow(title: "Profile")
                    SettingsOptionRow(title: "Notifications")
                    SettingsOptionRow(title: "Help & Support")
                    SettingsOptionRow(title: "Privacy")
                    SettingsOptionRow(title: "Terms of use")
                }
                .padding(.horizontal, 20)
                .font(.system(size: 50))
                
                
                Spacer()
            }
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)
                    .offset(x: 200, y: 140)
                
            }
        }
    }
}

struct SettingsOptionRow: View {
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
    SettingsView()
}
