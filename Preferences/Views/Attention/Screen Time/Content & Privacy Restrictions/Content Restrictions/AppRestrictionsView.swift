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
    let options = ["Don't Allow", "4+", "9+", "12+", "17+"]
    
    var body: some View {
        CustomList(title: "Apps") {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
    }
}

#Preview {
    AppRestrictionsView()
}
