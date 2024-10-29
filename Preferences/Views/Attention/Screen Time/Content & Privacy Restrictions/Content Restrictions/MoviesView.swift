//
//  MoviesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Movies
//

import SwiftUI

struct MoviesView: View {
    // Variables
    @State private var selected = "Allow All"
    let options = ["Don't Allow", "NR", "G", "PG", "PG-13", "R", "NC-17", "Unrated", "Allow All"]
    let table = "Restrictions"
    
    @State private var showMoviesCloudEnabled = true
    
    var body: some View {
        CustomList(title: "MoviesSpecifierName".localize(table: table)) {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            Section {
                Toggle("UndownloadedMoviesSpecifierName".localize(table: table), isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MoviesView()
    }
}
