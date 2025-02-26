//
//  ICloudSyncView.swift
//  Fruitfull
//
//  Created by Abhijeet Raj Singh on 26/2/2025.
//

import SwiftUI

struct ICloudSyncView: View {
    @State private var isSyncing = false
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    Toggle("iCloud Sync", isOn: $isSyncing)
                    Text("Last Synced: Today 9:41 AM")
                }
                
                Section(header: Text("Sync Options")) {
                    Text("Sync Frequency")
                    Text("Data to Sync")
                    Text("Storage Usage")
                }
            }
            
            Spacer()
        }
        .navigationTitle("iCloud Sync")
    }
}


#Preview {
    ICloudSyncView()
}
