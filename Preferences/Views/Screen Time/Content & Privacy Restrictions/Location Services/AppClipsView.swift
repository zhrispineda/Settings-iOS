//
//  AppClipsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > App Clips
//

import SwiftUI

struct AppClipsView: View {
    // Variables
    @State private var confirmLocationEnabled = false
    var completeView = true
    
    var body: some View {
        CustomList(title: "App Clips") {
            Section(content: {
                if completeView {
                    Toggle("Confirm Location", isOn: $confirmLocationEnabled)
                }
            }, footer: {
                VStack(alignment: .leading) {
                    if completeView {
                        Text("Your location is used to confirm to app clips that scanned tags haven‘t been moved from where they belong.\n\n")
                    }
                    Text("App clips that have requested access to your location will appear here.\n")
                    if completeView {
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("A purple arrow indicates that an item has recently used your location.")
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("A gray arrow indicates that an item has used your location in the last 24 hours.")
                        }
                        .padding(.trailing)
                    }
                }
            })
        }
    }
}

#Preview {
    AppClipsView()
}
