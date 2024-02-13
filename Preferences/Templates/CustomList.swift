//
//  CustomList.swift
//  Preferences
//
//  Template for a custom List with common properties
//

import SwiftUI

let defaultPaddingViews = ["Accessibility", "Maps", "Health", "Siri & Search", "Photos", "Game Center", "Developer"]

struct CustomList<Content: View>: View {
    // Variables
    var title: String = String()
    @ViewBuilder let content: Content
    @State private var isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            List {
                content
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, defaultPaddingViews.contains(title) ? 0 : -19)
            .padding(.horizontal, DeviceInfo().isPhone ? 0 : (isOnLandscapeOrientation ? 35 : 0))
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            if !DeviceInfo().isPhone && UIDevice.current.orientation.rawValue <= 4 {
                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
            }
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "Developer") {
            Text("Hello, World!")
        }
    }
}
