//
//  RecordSoundView.swift
//  Preferences
//
//  Settings > Camera > Record Sound
//

import SwiftUI

struct RecordSoundView: View {
    // Variables
    @AppStorage("CameraSoundSetting") private var selected = String()
    @AppStorage("CameraAllowAudioPlayback") private var allowAudioPlayback = true
    @AppStorage("CameraWindNoiseReduction") private var windNoiseReduction = true
    var options = ["CAM_AUDIO_CONFIGURATION_STEREO", "CAM_AUDIO_CONFIGURATION_MONO"]
    let table = "CameraSettings"
    let cineTable = "CameraSettings-CinematicAudio"
    
    init() {
        if UIDevice.AdvancedPhotographicStylesCapability || UIDevice.identifier == "iPhone17,5" {
            options.insert("CAM_AUDIO_CONFIGURATION_CINEMATIC", at: 0)
        }
    }
    
    var body: some View {
        CustomList(title: "CAM_AUDIO_CONFIGURATION_TITLE".localize(table: table)) {
            Section {
                Picker("CAM_AUDIO_CONFIGURATION_TITLE".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) { setting in
                        Text(setting.localize(table: setting.contains("CINE") ? cineTable : table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                if UIDevice.AdvancedPhotographicStylesCapability {
                    Text("CAM_AUDIO_CONFIGURATION_CINEMATIC_FOOTER_iPhone".localize(table: cineTable))
                }
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("CAM_VIDEO_RECORDING_MIX_AUDIO_WITH_OTHERS_TITLE".localize(table: table), isOn: $allowAudioPlayback)
                } footer: {
                    Text("CAM_VIDEO_RECORDING_MIX_AUDIO_WITH_OTHERS_FOOTER".localize(table: table))
                }
            }
            
            if UIDevice.identifier == "iPhone17,5" || UIDevice.AdvancedPhotographicStylesCapability && selected != "CAM_AUDIO_CONFIGURATION_MONO" {
                Section {
                    Toggle("CAM_AUDIO_WIND_REMOVAL_TITLE".localize(table: cineTable), isOn: $windNoiseReduction)
                } footer: {
                    Text("CAM_AUDIO_WIND_REMOVAL_FOOTER".localize(table: cineTable))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordSoundView()
    }
}
