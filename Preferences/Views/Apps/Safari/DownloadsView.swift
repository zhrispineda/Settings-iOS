//
//  DownloadsView.swift
//  Preferences
//
//  Settings > Apps > Safari > Downloads
//

import SwiftUI

struct DownloadsView: View {
    var body: some View {
        CustomList(title: "Downloads") {
            Section {
                Button {} label: {
                    HStack(spacing: 15) {
                        Image(systemName: "\(UIDevice.current.model.lowercased())")
                            .font(.title)
                            .tint(.blue)
                        VStack(alignment: .leading) {
                            Text("On My \(UIDevice.current.model)")
                            Text("Downloads")
                                .foregroundStyle(.secondary)
                                .font(.footnote)
                        }
                        .foregroundStyle(.text)
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
                // TODO: Open File folder selection view
                Button {} label: {
                    HStack {
                        Image(systemName: "\(UIDevice.current.model.lowercased())")
                            .font(.title)
                            .foregroundStyle(.blue)
                            .opacity(0.0)
                        Text("Other...")
                    }
                }
                .foregroundStyle(.primary)
            } header: {
                Text("Store Downloaded Files On:")
            } footer: {
                Text("Store downloads only on this device, and do not make them available on other devices.")
            }
            
            Section {
                CustomNavigationLink("Remove Download List Items", status: "After one day", destination: SelectOptionList("Remove Download List Items", options: ["After one day", "Upon successful download", "Manually"], selected: "After one day"))
            }
        }
    }
}

#Preview {
    NavigationStack {
        DownloadsView()
    }
}
