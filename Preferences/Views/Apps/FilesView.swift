//
//  FilesView.swift
//  Preferences
//
//  Settings > Apps > Files
//

import SwiftUI

struct FilesView: View {
    // Variables
    @State private var cellularEnabled = true
    
    var body: some View {
        CustomList(title: "Files", topPadding: true) {
            PermissionsView(appName: "Files", location: false, notifications: false, cellularEnabled: $cellularEnabled)
        }
    }
}

#Preview {
    NavigationStack {
        FilesView()
    }
}
