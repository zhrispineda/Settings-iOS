//
//  FontsView.swift
//  Preferences
//
//  Settings > General > Fonts
//

import SwiftUI

struct FontsView: View {
    let path = "/System/Library/PreferenceBundles/FontSettings.bundle"
    
    var body: some View {
        CustomList(title: "Fonts".localized(path: path)) {
            Section {
                NavigationLink("System Fonts".localized(path: path), destination: SystemFontsView())
                NavigationLink("My Fonts".localized(path: path), destination: MyFontsView())
            } footer: {
                Text("INSTALLED_FONTS_CLARIFICATION".localized(path: path))
            }
            
            Section {
                Text("More Fonts".localized(path: path))
            } footer: {
                Text("MORE_FONTS_CLARIFICATION".localized(path: path))
            }
        }
    }
}

#Preview {
    NavigationStack {
        FontsView()
    }
}
