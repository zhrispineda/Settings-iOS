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
    @State private var volume = 0.5
    @State private var changeWithButtonsEnabled = true
    
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
            
            Section(content: {
                Group {
                    Slider(value: $volume,
                           in: 0...100,
                           minimumValueLabel: Image(systemName: "speaker.fill"),
                           maximumValueLabel: Image(systemName: "speaker.wave.3.fill"),
                           label: {
                               Text("Volume")
                           }
                    )
                }
                .foregroundStyle(.secondary)
                
                Toggle("Change with Buttons", isOn: $changeWithButtonsEnabled)
                if DeviceInfo().isPhone {
                    CustomNavigationLink(title: "Haptics", status: "Always Play", destination: EmptyView())
                }
            }, header: {
                Text("Ringtone and Alerts")
            }, footer: {
                Text("The volume buttons \(changeWithButtonsEnabled ? "can be used to adjust" : "will not affect") the volume of the ringtone and alerts.")
            })
            
            Section {
                CustomNavigationLink(title: "Ringtone", status: "Reflection", destination: EmptyView())
                CustomNavigationLink(title: "Text Tone", status: "Note", destination: EmptyView())
                CustomNavigationLink(title: "New Voicemail", status: "Droplet", destination: EmptyView())
                CustomNavigationLink(title: "New Mail", status: "None", destination: EmptyView())
                CustomNavigationLink(title: "Sent Mail", status: "Swoosh", destination: EmptyView())
                CustomNavigationLink(title: "Calendar Alerts", status: "Chord", destination: EmptyView())
                CustomNavigationLink(title: "Reminder Alerts", status: "Chord", destination: EmptyView())
                CustomNavigationLink(title: "Default Alerts", status: "Rebound", destination: EmptyView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        SoundsHapticsView()
    }
}
