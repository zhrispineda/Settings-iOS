//
//  MoviesView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Movies
//

import SwiftUI

struct MoviesView: View {
    // Variables
    @State private var selectedOption = "Allow All"
    let options = ["Don't Allow", "NR", "G", "PG", "PG-13", "R", "NC-17", "Unrated", "Allow All"]
    
    @State private var showMoviesCloudEnabled = true
    
    var body: some View {
        CustomList(title: "Movies") {
            ForEach(options, id: \.self) { option in
                Button(action: { selectedOption = option }, label: {
                    HStack {
                        Text(option)
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                })
            }
            
            Section {
                Toggle("Show Movies in the Cloud", isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    MoviesView()
}
