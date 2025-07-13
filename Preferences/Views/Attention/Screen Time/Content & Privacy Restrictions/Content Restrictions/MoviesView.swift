//
//  MoviesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Movies
//

import SwiftUI

struct MoviesView: View {
    @State private var selected = "Allow All"
    let options = ["Don't Allow", "NR", "G", "PG", "PG-13", "R", "NC-17", "Unrated", "Allow All"]
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    
    @State private var showMoviesCloudEnabled = true
    
    var body: some View {
        CustomList(title: "MoviesSpecifierName".localized(path: path, table: table)) {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0.localized(path: path, table: table))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            Section {
                Toggle("UndownloadedMoviesSpecifierName".localized(path: path, table: table), isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MoviesView()
    }
}
