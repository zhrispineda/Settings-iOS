//
//  AppClipsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > App Clips
//

import SwiftUI

struct AppClipsView: View {
    // Variables
    @State private var confirmLocationEnabled = false
    var completeView = true
    let table = "Dim-Sum"
    let locTable = "Location Services"
    
    var body: some View {
        CustomList(title: "APP_CLIPS".localize(table: table)) {
            Section {
                if completeView {
                    Toggle("CONFIRM_LOCATION".localize(table: table), isOn: $confirmLocationEnabled)
                }
            } footer: {
                VStack(alignment: .leading) {
                    if completeView {
                        Text("CONFIRM_LOCATION_FOOTER", tableName: table) + Text("\n\n")
                    }
                    Text("GENERAL_EXPLANATION_CLIPS_ITEM", tableName: locTable) + Text("\n")
                    if completeView {
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("ACTIVE_EXPLANATION_ITEM", tableName: locTable)
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("RECENT_EXPLANATION_ITEM", tableName: locTable)
                        }
                        .padding(.trailing)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppClipsView()
    }
}
