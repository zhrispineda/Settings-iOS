//
//  RecordCinematicView.swift
//  Preferences
//
//  Settings > Camera > Record Cinematic
//

import SwiftUI

struct RecordCinematicView: View {
    // Variables
    @AppStorage("CameraCinematicSetting") private var selected = "CAM_RECORD_VIDEO_1080p_30"
    let options = ["CAM_RECORD_VIDEO_1080p_30", "CAM_RECORD_VIDEO_4K_24", "CAM_RECORD_VIDEO_4K_30"]
    let table = "CameraSettings"
    
    var body: some View {
        CustomList(title: "CAM_RECORD_CINEMATIC_TITLE".localize(table: table)) {
            Section {
                Picker("CAM_RECORD_CINEMATIC_TITLE".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                VStack(alignment: .leading) {
                    Text("CAM_RECORD_CINEMATIC_FOOTER_HEAD".localize(table: table))
                    Text("CAM_RECORD_VIDEO_1080p_30_HEVC_FOOTER".localize(table: table))
                    Text("CAM_RECORD_VIDEO_4K_24_HEVC_FOOTER".localize(table: table))
                    Text("CAM_RECORD_VIDEO_4K_30_HEVC_FOOTER".localize(table: table))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordCinematicView()
    }
}
