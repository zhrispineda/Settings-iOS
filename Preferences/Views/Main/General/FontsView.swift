//
//  FontsView.swift
//  Preferences
//
//  Settings > General > Fonts
//

import SwiftUI

struct FontsView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Text("**No Fonts Installed**")
                    .font(.title2)
                Text("You can download apps that install fonts from the App Store.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Button("Open App Store", action: {})
                    .padding(.vertical, 5)
            }
            .padding(30)
        }
        .navigationTitle("Fonts")
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    FontsView()
}
