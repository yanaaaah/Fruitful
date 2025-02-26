//
//  ContentView.swift
//  Fruitfull
//
//  Created by Yana Duran on 24/2/2025.
//


/*
 */

import SwiftUI

struct AccountView: View {
    /*  @State private var isSyncing = false
     @State private var navigateToSync = false */ // Animation
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    //Account headline
                    Text("Account")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                    
                    // Edit Goals Button
                    NavigationLink(destination: EditGoalsView()) {
                        AccountOptionRow(icon: "target", title: "Edit Goals")
                    }
                    
                    NavigationLink(destination: ICloudSyncView()) {
                        AccountOptionRow(icon: "arrow.triangle.2.circlepath", title: "iCloud Sync")
                    }
                    
                    
                    // Settings Button
                    NavigationLink(destination: SettingsView()) {
                        AccountOptionRow(icon: "gearshape", title: "Settings")
                    }
                    Spacer()
                    
                    
                }
                .background(.white)
                .padding()
                
                // Tree
                HStack {
                    Spacer()
                    Image(.image)
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                }
                
            }
        }
        
    }
    
    // Account Option Row Reusable Component
    struct AccountOptionRow: View {
        var icon: String
        var title: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                    .padding()
                Text(title)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
        }
    }
    
    // Navigation Bar
    struct CustomTabBar: View {
        var body: some View {
            HStack {
                Spacer()
                TabBarButton(icon: "tree", isSelected: false)
                Spacer()
                TabBarButton(icon: "drop", isSelected: false)
                Spacer()
                TabBarButton(icon: "person.crop.circle", isSelected: true, isPersonIcon: true)
                Spacer()
            }
            .padding(.horizontal, -70)
            .background(Color.white)
            //.background(Color(UIColor.secondarySystemBackground))
        }
    }
    
    struct TabBarButton: View {
        let icon: String
        let isSelected: Bool
        var isPersonIcon: Bool = false
        
        var iconColor: Color {
            if isPersonIcon && isSelected {
                return .brown
            }
            return isSelected ? .primary : .gray
        }
        
        var body: some View {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.system(size: 24))
        }
    }
}

// Preview
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
