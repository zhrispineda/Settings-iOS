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
    
    @State private var showMoviesCloudEnabled = true
    
    var body: some View {
        CustomList(title: "Movies") {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            Section {
                Toggle("Show Movies in the Cloud", isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    MoviesView()
}
