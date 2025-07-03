//
//  HomeScreenAppLibraryView.swift
//  Preferences
//
//  Settings > Home Screen & App Library
//

import SwiftUI

struct HomeScreenAppLibraryView: View {
    @State private var selected = "App Library Only"
    @State private var showAppLibraryNotificationsEnabled = true
    @State private var showHomeScreenSearchEnabled = true
    let path = "/System/Library/PreferenceBundles/HomeScreenSettings.bundle"
    var options = ["Add to Home Screen", "App Library Only"]
    
    var body: some View {
        CustomList(title: "Home Screen & App Library".localized(path: path), topPadding: true) {
            Section {
                Picker("Newly Downloaded Apps".localized(path: path), selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Newly Downloaded Apps".localized(path: path))
            }
            
            Section {
                Toggle("Show in App Library".localized(path: path), isOn: $showAppLibraryNotificationsEnabled)
            } header: {
                Text("Notification Badges".localized(path: path))
            }
            
            Section {
                Toggle("Show on Home Screen".localized(path: path), isOn: $showHomeScreenSearchEnabled)
            } header: {
                Text("Search".localized(path: path))
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreenAppLibraryView()
    }
}
