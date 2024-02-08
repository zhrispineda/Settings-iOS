//
//  ScreenTimeView.swift
//  Preferences
//
//  Settings > Screen Time
//

import SwiftUI

struct ScreenTimeView: View {
    var body: some View {
        CustomList(title: "Screen Time") {
            VStack(spacing: 10) {
                ZStack {
                    Color.indigo
                        .frame(width: 56, height: 56)
                        .clipShape(RoundedRectangle(cornerRadius: 13.0))
                    Image(systemName: "hourglass")
                        .font(.system(size: 36))
                        .foregroundStyle(.white)
                }
                Text("**Screen Time**")
                    .font(.title2)
                Text("Understand how much time you spend on your devices. Set limits on how long and when apps can be used. Restrict apps, websites, and more.")
                    .font(.subheadline)
                    .padding(.bottom, -10)
                    .padding(.horizontal, -5)
            }
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
