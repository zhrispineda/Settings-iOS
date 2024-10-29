//
//  TVView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > TV
//

import SwiftUI

struct TVView: View {
    // Variables
    @State private var selected = "Allow All"
    let options = ["DontAllowLabel", "TV-Y", "TV-Y7", "TV-Y7-FV", "TV-G", "TV-PG", "TV-14", "TV-MA", "Allow All"]
    let table = "Restrictions"
    
    @State private var showMoviesCloudEnabled = true
    
    var body: some View {
        CustomList(title: "TV") {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0.localize(table: table))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            
            Section {
                Toggle("UndownloadedTVSpecifierName".localize(table: table), isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVView()
    }
}
