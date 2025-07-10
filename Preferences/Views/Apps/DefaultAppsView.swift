//
//  DefaultAppsView.swift
//  Preferences
//
//  Settings > Apps > Default Apps
//

import SwiftUI

struct DefaultAppsView: View {
    @State private var frameY = Double()
    @State private var opacity = Double()
    let path = "/System/Library/PrivateFrameworks/DefaultAppsSettingsUI.framework"
    
    var body: some View {
        CustomList(title: "Default Apps".localized(path: path)) {
            Placard(title: "Default Apps".localized(path: path), color: .gray, iconColor: .white, icon: "checkmark.rectangle.stack.fill", description: "Placard Subtitle".localized(path: path), frameY: $frameY, opacity: $opacity)
            
            Section {
                SettingsLink("Email".localized(path: path), status: "None".localized(path: path), destination: EmptyView())
                SettingsLink("Messaging".localized(path: path), status: "Messages", destination: EmptyView())
                SettingsLink("Calling".localized(path: path), status: "None".localized(path: path), destination: EmptyView())
            }
            
            Section {
                SettingsLink("Navigation", status: "Maps", destination: EmptyView())
                SettingsLink("Browser App".localized(path: path), status: "Safari", destination: EmptyView())
                SettingsLink("Translation", status: "None".localized(path: path), destination: EmptyView())
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Default Apps".localized(path: path))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DefaultAppsView()
    }
}
