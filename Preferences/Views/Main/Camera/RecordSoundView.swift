//
//  RecordSoundView.swift
//  Preferences
//
//  Settings > Camera > Record Sound
//

import SwiftUI

struct RecordSoundView: View {
    @AppStorage("CameraSoundSetting") private var selected = String()
    @AppStorage("CameraAllowAudioPlayback") private var allowAudioPlayback = true
    @AppStorage("CameraWindNoiseReduction") private var windNoiseReduction = true
    var options = ["CAM_AUDIO_CONFIGURATION_STEREO", "CAM_AUDIO_CONFIGURATION_MONO"]
    let path = "/System/Library/PreferenceBundles/CameraSettings.bundle"
    let table = "CameraSettings"
    
    init() {
        if UIDevice.AdvancedPhotographicStylesCapability || UIDevice.identifier == "iPhone17,5" {
            options.insert("CAM_AUDIO_CONFIGURATION_CINEMATIC", at: 0)
        }
    }
    
    var body: some View {
        CustomList(title: "CAM_AUDIO_CONFIGURATION_TITLE".localized(path: path, table: table)) {
            Section {
                Picker("CAM_AUDIO_CONFIGURATION_TITLE".localized(path: path, table: table), selection: $selected) {
                    ForEach(options, id: \.self) { setting in
                        Text(setting.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                if UIDevice.AdvancedPhotographicStylesCapability {
                    Text("CAM_AUDIO_CONFIGURATION_CINEMATIC_FOOTER".localized(path: path, table: table))
                }
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("CAM_VIDEO_RECORDING_MIX_AUDIO_WITH_OTHERS_TITLE".localized(path: path, table: table), isOn: $allowAudioPlayback)
                } footer: {
                    Text("CAM_VIDEO_RECORDING_MIX_AUDIO_WITH_OTHERS_FOOTER".localized(path: path, table: table))
                }
            }
            
            if UIDevice.queryCameraCapability("_windRemovalSupported") && selected != "CAM_AUDIO_CONFIGURATION_MONO" {
                Section {
                    Toggle("CAM_AUDIO_WIND_REMOVAL_TITLE".localized(path: path, table: table), isOn: $windNoiseReduction)
                } footer: {
                    Text("CAM_AUDIO_WIND_REMOVAL_FOOTER".localized(path: path, table: table))
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
