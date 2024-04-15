//
//  SoundsHapticsView.swift
//  Preferences
//
//  Settings > Sounds & Haptics
//

import SwiftUI

struct SoundsHapticsView: View {
    // Variables
    @State private var silentModeEnabled = true
    @State private var showInStatusBarEnabled = true
    
    var body: some View {
        CustomList(title: DeviceInfo().isPhone ? "Sounds & Haptics" : "Sounds") {
            Section(content: {
                Toggle(isOn: $silentModeEnabled.animation(), label: {
                    Label(
                        title: {
                            Text("Silent Mode")
                        }, icon: {
                            Image(systemName: silentModeEnabled ? "bell.slash.fill" : "bell.fill")
                                .foregroundStyle(silentModeEnabled ? .red : .secondary)
                        }
                    )
                })
                .toggleStyle(SwitchToggleStyle(tint: silentModeEnabled ? .red : .accentColor))
            }, header: {
                Text("\nSilent Mode")
            }, footer: {
                Text(silentModeEnabled ? "\(UIDevice().localizedModel) will not play ringtones, alerts, and system sounds. \(UIDevice().localizedModel) will still play alarms, timers, music, and audio from videos." : "\(UIDevice().localizedModel) will play ringtones, alerts, and system sounds.")
            })
            
            Section {
                Toggle("Show in Status Bar", isOn: $showInStatusBarEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SoundsHapticsView()
    }
}
