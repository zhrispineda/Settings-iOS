//
//  DefaultAppsView.swift
//  Preferences
//
//  Settings > Apps > Default Apps
//

import SwiftUI

struct DefaultAppsView: View {
    @State private var frameY = Double()
    @State private var opacity = Double()
    let table = "DefaultAppsSettingsUI"
    
    var body: some View {
        CustomList(title: "Default Apps".localize(table: table)) {
            Placard(title: "Default Apps".localize(table: table), color: .gray, iconColor: .white, icon: "checkmark.rectangle.stack.fill", description: "Placard Subtitle".localize(table: table), frameY: $frameY, opacity: $opacity)
            
            Section {
                SettingsLink("Email".localize(table: table), status: "None".localize(table: table), destination: EmptyView())
                SettingsLink("Messaging".localize(table: table), status: "Messages", destination: EmptyView())
                SettingsLink("Calling".localize(table: table), status: "None".localize(table: table), destination: EmptyView())
            }
            
            Section {
                SettingsLink("Navigation", status: "Maps", destination: EmptyView())
                SettingsLink("Browser App".localize(table: table), status: "Safari", destination: EmptyView())
                SettingsLink("Translation", status: "None".localize(table: table), destination: EmptyView())
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Default Apps", tableName: table)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        DefaultAppsView()
    }
}
