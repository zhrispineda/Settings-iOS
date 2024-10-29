//
//  AppRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Apps
//

import SwiftUI

struct AppRestrictionsView: View {
    // Variables
    @State private var selected = "17+"
    let options = ["DontAllowLabel", "4+", "9+", "12+", "17+"]
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AppsSpecifierName".localize(table: table)) {
            Picker("AppsSpecifierName".localize(table: table), selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0.localize(table: table))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
    }
}

#Preview {
    NavigationStack {
        AppRestrictionsView()
    }
}
