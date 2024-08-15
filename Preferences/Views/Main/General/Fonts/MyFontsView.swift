//
//  MyFontsView.swift
//  Preferences
//
//  Settings > General > Fonts > My Fonts
//

import SwiftUI

struct MyFontsView: View {
    var body: some View {
        ScrollView() {
            ZStack {
                Spacer().containerRelativeFrame(.vertical)
                VStack(alignment: .center) {
                    Text("**No Fonts Installed**")
                        .font(.title2)
                    Text("You can download apps that install fonts from the App Store.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                    Button("Open App Store") {}
                        .padding(.vertical, 5)
                }
                .padding(30)
            }
        }
        .navigationTitle("My Fonts")
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
