//
//  TVView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > TV
//

import SwiftUI

struct TVView: View {
    @State private var selected = "Allow All"
    @State private var showMoviesCloudEnabled = true
    let options = ["DontAllowLabel", "TV-Y", "TV-Y7", "TV-Y7-FV", "TV-G", "TV-PG", "TV-14", "TV-MA", "Allow All"]
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "TV".localized(path: path, table: table)) {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0.localized(path: path, table: table))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            Section {
                Toggle("UndownloadedTVSpecifierName".localized(path: path, table: table), isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVView()
    }
}
