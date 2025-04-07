//
//  SoundsHapticsView.swift
//  Preferences
//
//  Settings > Sounds & Haptics
//

import SwiftUI

struct SoundsHapticsView: View {
    // Variables
    @State private var silentModeEnabled = false
    @State private var showInStatusBarEnabled = true
    @State private var volume = 0.5
    @State private var changeWithButtonsEnabled = true
    @State private var keyboardClicksEnabled = true
    @State private var lockSoundEnabled = true
    @State private var systemHapticsEnabled = true
    @State private var fixedPositionVolumeControlsEnabled = true
    let table = "Sounds"
    
    var body: some View {
        CustomList(title: UIDevice.iPhone ? "SOUNDS_AND_HAPTICS".localize(table: table) : "Sounds".localize(table: table), topPadding: true) {
            Section {
                Toggle(isOn: $silentModeEnabled.animation()) {
                    Label(
                        title: {
                            Text("SILENT_MODE", tableName: table)
                        }, icon: {
                            Image(systemName: silentModeEnabled ? "bell.slash.fill" : "bell.fill")
                                .foregroundStyle(silentModeEnabled ? .red : .secondary)
                        }
                    )
                }
                .toggleStyle(SwitchToggleStyle(tint: silentModeEnabled ? .red : .accentColor))
            } header: {
                Text("SILENT_MODE", tableName: table)
            } footer: {
                Text(silentModeEnabled ? "SILENT_MODE_ON_FOOTER" : "SILENT_MODE_OFF_FOOTER", tableName: table)
                    .transition(.slide)
            }
            
            Section {
                Toggle("SHOW_IN_STATUS_BAR".localize(table: table), isOn: $showInStatusBarEnabled)
            }
            
            Section {
                Group {
                    Slider(value: $volume,
                           in: 0...1,
                           minimumValueLabel: Image(systemName: "speaker.fill"),
                           maximumValueLabel: Image(systemName: "speaker.wave.3.fill"),
                           label: {
                                Text("RING_VOLUME_SLIDER", tableName: table)
                           }
                    )
                }
                .foregroundStyle(.secondary)
                
                Toggle("CHANGE_WITH_BUTTONS".localize(table: table), isOn: $changeWithButtonsEnabled)
                if UIDevice.iPhone {
                    CustomNavigationLink("HAPTICS".localize(table: table), status: "ALWAYS_PLAY".localize(table: table), destination: EmptyView())
                }
            } header: {
                Text("RINGER_AND_ALERTS", tableName: table)
            } footer: {
                Text(changeWithButtonsEnabled ? "RING_VOL_CAN_BE_ADJUSTED" : "RING_VOL_CANNOT_BE_ADJUSTED", tableName: table)
            }
            
            Section {
                CustomNavigationLink("Ringtone".localize(table: table), status: "Reflection", destination: EmptyView())
                CustomNavigationLink("Text_Messages".localize(table: table), status: "Note", destination: EmptyView())
                if UIDevice.iPhone {
                    CustomNavigationLink("Voicemail".localize(table: table), status: "Droplet", destination: EmptyView())
                }
                CustomNavigationLink("NEW_MAIL".localize(table: table), status: "None", destination: EmptyView())
                CustomNavigationLink("SENT_MAIL".localize(table: table), status: "Swoosh", destination: EmptyView())
                CustomNavigationLink("Calendar Alarm".localize(table: table), status: "Chord", destination: EmptyView())
                CustomNavigationLink("Reminder Alerts".localize(table: table), status: "Chord", destination: EmptyView())
                CustomNavigationLink("DEFAULT_ALERTS".localize(table: table), status: "Rebound", destination: EmptyView())
            }
            
            Section {
                if UIDevice.iPhone {
                    CustomNavigationLink("KEYBOARD_FEEDBACK".localize(table: table), status: "SOUND".localize(table: table), destination: EmptyView())
                } else {
                    Toggle("KEYBOARD_CLICKS".localize(table: table), isOn: $keyboardClicksEnabled)
                }
                Toggle("LOCK_SOUND".localize(table: table), isOn: $lockSoundEnabled)
                if UIDevice.iPhone {
                    Toggle("SYSTEM_HAPTICS".localize(table: table), isOn: $systemHapticsEnabled)
                }
            } header: {
                Text(UIDevice.iPhone ? "SOUND_SWITCHES_HEADER" : "SOUND_ONLY_SWITCHES_HEADER", tableName: table)
            } footer: {
                Text(UIDevice.iPhone ? "SYSTEM_HAPTICS_FOOTER" : "SOUND_ONLY_SWITCHES_FOOTER", tableName: table)
            }
            
            if UIDevice.iPad {
                Section {
                    Toggle("FIXED_POSITION_VOLUME".localize(table: table), isOn: $fixedPositionVolumeControlsEnabled.animation())
                } footer: {
                    Text(fixedPositionVolumeControlsEnabled ? "FIXED_POSITION_VOLUME_ON_FOOTER" : "FIXED_POSITION_VOLUME_OFF_FOOTER", tableName: table)
                }
            }
            
            Section {
                NavigationLink("HEADPHONE_HEARING_PROTECTION".localize(table: table)) {}
            } header: {
                Text("HEADPHONE_AUDIO_GROUP", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SoundsHapticsView()
    }
}
