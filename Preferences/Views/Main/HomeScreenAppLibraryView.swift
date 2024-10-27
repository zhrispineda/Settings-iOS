//
//  HomeScreenAppLibraryView.swift
//  Preferences
//
//  Settings > Home Screen & App Library
//

import SwiftUI

struct HomeScreenAppLibraryView: View {
    // Variables
    var options = ["Add to Home Screen", "App Library Only"]
    @State private var selected = "App Library Only"
    @State private var showAppLibraryNotificationsEnabled = true
    @State private var showHomeScreenSearchEnabled = true
    let table = "HomeScreenSettings"
    
    var body: some View {
        CustomList(title: "Home Screen & App Library".localize(table: table), topPadding: true) {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        selected = option.localize(table: table)
                    } label: {
                        HStack {
                            Text(option.localize(table: table))
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if option.localize(table: table) == selected {
                                Image(systemName: "checkmark")
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
            } header: {
                Text("Newly Downloaded Apps", tableName: table)
            }
            
            Section {
                Toggle("Show in App Library".localize(table: table), isOn: $showAppLibraryNotificationsEnabled)
            } header: {
                Text("Notification Badges", tableName: table)
            }
            
            Section {
                Toggle("Show on Home Screen".localize(table: table), isOn: $showHomeScreenSearchEnabled)
            } header: {
                Text("Search", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreenAppLibraryView()
    }
}
