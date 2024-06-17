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
    
    var body: some View {
        CustomList(title: "Home Screen & App Library") {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        selected = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if option == selected {
                                Image(systemName: "checkmark")
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
            } header: {
                Text("\nNewly Downloaded Apps")
            }
            
            Section {
                Toggle("Show in App Library", isOn: $showAppLibraryNotificationsEnabled)
            } header: {
                Text("Notification Badges")
            }
            
            Section {
                Toggle("Show on Home Screen", isOn: $showHomeScreenSearchEnabled)
            } header: {
                Text("Search")
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreenAppLibraryView()
    }
}
