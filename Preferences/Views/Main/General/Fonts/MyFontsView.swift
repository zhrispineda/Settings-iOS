//
//  MyFontsView.swift
//  Preferences
//
//  Settings > General > Fonts > My Fonts
//

import SwiftUI

struct MyFontsView: View {
    let path = "/System/Library/PreferenceBundles/FontSettings.bundle"
    
    var body: some View {
        ScrollView() {
            ZStack {
                Spacer().containerRelativeFrame(.vertical)
                ContentUnavailableView("No Fonts Installed".localized(path: path), systemImage: "textformat", description: Text("You can download apps that install fonts from the App Store.".localized(path: path)))
                Button("Open App Store".localized(path: path)) {}
                    .padding(.top, 150)
            }
        }
        .navigationTitle("My Fonts".localized(path: path))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        MyFontsView()
    }
}
