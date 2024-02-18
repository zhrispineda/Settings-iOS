//
//  TVAppView.swift
//  Preferences
//
//  Settings > Developer > TV App
//

import SwiftUI

struct TVAppView: View {
    var body: some View {
        CustomList(title: "TV App") {
            Section(content: {}, footer: {
                Text("\nNo developer accounts added. User accounts written by developer apps will be listed here.")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            })
        }
    }
}

#Preview {
    TVAppView()
}
