//
//  DownloadsView.swift
//  Preferences
//
//  Settings > Safari > Downloads
//

import SwiftUI

struct DownloadsView: View {
    var body: some View {
        CustomList(title: "Downloads") {
            Section(content: {
                Button(action: {}, label: {
                    HStack(spacing: 15) {
                        Image(systemName: "\(DeviceInfo().model.lowercased())")
                            .font(.title)
                            .tint(.blue)
                        VStack(alignment: .leading) {
                            Text("On My \(DeviceInfo().model)")
                            Text("Downloads")
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                        }
                        .tint(Color["Label"])
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                })
                // TODO: Open File folder selection view
                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "\(DeviceInfo().model.lowercased())")
                            .font(.title)
                            .foregroundStyle(.blue)
                            .opacity(0.0)
                        Text("Other...")
                    }
                })
                .tint(Color["Label"])
            }, header: {
                Text("\n\nStore Downloaded Files On:")
            }, footer: {
                Text("Store downloads only on this device, and do not make them available on other devices.")
            })
            
            Section {
                CustomNavigationLink(title: "Remove Download List Items", status: "After one day", destination: SelectOptionList(title: "Remove Download List Items", options: ["After one day", "Upon successful download", "Manually"], selected: "After one day"))
            }
        }
    }
}

#Preview {
    NavigationStack {
        DownloadsView()
    }
}
