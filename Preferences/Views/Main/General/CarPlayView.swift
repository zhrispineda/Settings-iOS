//
//  CarPlayView.swift
//  Preferences
//
//  Settings > General > CarPlay
//

import SwiftUI

struct CarPlayView: View {
    // Variables
    let table = "CarKitSettings"
    
    var body: some View {
        CustomList(title: "CARPLAY_OPTIONS_ROW_TITLE".localize(table: table)) {
            Section {
                Image("SiriWheel")
                    .resizable()
                    .scaledToFit()
                    .listRowInsets(EdgeInsets())
            }
            
            Section {} footer: {
                Text("WIRELESS_SETUP_FOOTER", tableName: table)
            }
            
            Section {} header: {
                HStack {
                    Text("AVAILABLE_CARS", tableName: table)
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarPlayView()
    }
}
