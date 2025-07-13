//
//  AppRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Apps
//

import SwiftUI

struct AppRestrictionsView: View {
    @State private var selected = "17+"
    let options = ["DontAllowLabel", "4+", "9+", "12+", "17+"]
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AppsSpecifierName".localized(path: path, table: table)) {
            Picker("AppsSpecifierName".localized(path: path, table: table), selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0.localized(path: path, table: table))
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
