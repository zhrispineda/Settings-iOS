//
//  RecordSlomoView.swift
//  Preferences
//
//  Settings > Camera > Record Slo-mo
//

import SwiftUI

struct RecordSlomoView: View {
    // Variables
    @AppStorage("CameraSlomoSetting") private var selected = String()
    var options = ["CAM_RECORD_SLOMO_1080p_120", "CAM_RECORD_SLOMO_1080p_240"]
    let table = "CameraSettings"
    
    init() {
        if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
            options.append("CAM_RECORD_VIDEO_4K_120")
        }
        
        if selected.isEmpty && !UIDevice.AdvancedPhotographicStylesCapability && !UIDevice.ProDevice {
            selected = "CAM_RECORD_SLOMO_1080p_240"
        } else if selected.isEmpty && UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
            selected = "CAM_RECORD_SLOMO_1080p_120"
        }
    }
    
    var body: some View {
        CustomList(title: "CAM_RECORD_SLOMO_TITLE".localize(table: table)) {
            Section {
                Picker("CAM_RECORD_SLOMO_TITLE".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                VStack(alignment: .leading) {
                    if !UIDevice.HomeButtonCapability {
                        Text("CAM_RECORD_SLOMO_FOOTER_FFC_120_ONLY".localize(table: table) + "\n")
                    }
                    Text("CAM_RECORD_SLOMO_FOOTER_HEAD".localize(table: table))
                    if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
                        Text("CAM_RECORD_SLOMO_1080p_120_HEVC_FOOTER_DEFAULT".localize(table: table))
                        Text("CAM_RECORD_SLOMO_1080p_240_FOOTER".localize(table: table))
                        Text("CAM_RECORD_SLOMO_4k_120_FOOTER_HDR".localize(table: table))
                    } else {
                        Text("CAM_RECORD_SLOMO_1080p_120_HEVC_FOOTER".localize(table: table))
                        Text("CAM_RECORD_SLOMO_1080p_240_FOOTER_DEFAULT".localize(table: table))
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordSlomoView()
    }
}
