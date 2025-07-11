//
//  RecordSlomoView.swift
//  Preferences
//
//  Settings > Camera > Record Slo-mo
//

import SwiftUI

struct RecordSlomoView: View {
    @AppStorage("CameraFormatSetting") private var cameraFormat = "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY"
    @AppStorage("CameraSlomoSetting") private var selected = ""
    let path = "/System/Library/PreferenceBundles/CameraSettings.bundle"
    var options = ["CAM_RECORD_SLOMO_1080p_120"]
    let table = "CameraSettings"
    
    init() {
        if cameraFormat == "CAM_FORMATS_CAPTURE_MOST_COMPATIBLE" {
            options.append("CAM_RECORD_SLOMO_1080p_240_MOST_COMPATIBLE")
        } else {
            options.append("CAM_RECORD_SLOMO_1080p_240")
        }
        
        if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
            if cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" {
                options.append("CAM_RECORD_SLOMO_720p_240")
            }
            if cameraFormat == "CAM_FORMATS_CAPTURE_MOST_COMPATIBLE" {
                options.append("CAM_RECORD_VIDEO_4K_120_MOST_COMPATIBLE")
            } else {
                options.append("CAM_RECORD_VIDEO_4K_120")
            }
        }
        
        if selected.isEmpty && !UIDevice.AdvancedPhotographicStylesCapability && !UIDevice.ProDevice {
            selected = "CAM_RECORD_SLOMO_1080p_240"
        } else if selected.isEmpty && UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
            selected = "CAM_RECORD_SLOMO_1080p_120"
        }
    }
    
    var body: some View {
        CustomList(title: "CAM_RECORD_SLOMO_TITLE".localized(path: path, table: table)) {
            Section {
                Picker("CAM_RECORD_SLOMO_TITLE".localized(path: path, table: table), selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                VStack(alignment: .leading) {
                    if !UIDevice.HomeButtonCapability && !UIDevice.iPad {
                        Text("CAM_RECORD_SLOMO_FOOTER_FFC_120_ONLY".localized(path: path, table: table) + "\n")
                    }
                    Text("CAM_RECORD_SLOMO_FOOTER_HEAD".localized(path: path, table: table))
                    
                    if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
                        Text("CAM_RECORD_SLOMO_1080p_120\(cameraFormat.contains("COMPATIBLE") ? "" : "_HEVC")\(cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" ? "_FOOTER" : "_FOOTER_DEFAULT")".localized(path: path, table: table))
                        Text("CAM_RECORD_SLOMO_1080p_240_FOOTER".localized(path: path, table: table))
                        if cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" {
                            Text("CAM_RECORD_SLOMO_720p_240_FOOTER_DEFAULT".localized(path: path, table: table))
                        }
                        Text("CAM_RECORD_SLOMO_4k_120_FOOTER\(cameraFormat.contains("COMPATIBLE") ? "" : "_HDR")".localized(path: path, table: table))
                    } else {
                        Text("CAM_RECORD_SLOMO_1080p_120_HEVC_FOOTER".localized(path: path, table: table))
                        Text("CAM_RECORD_SLOMO_1080p_240_FOOTER_DEFAULT".localized(path: path, table: table))
                        if cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" {
                            Text("CAM_RECORD_SLOMO_720p_240_FOOTER_DEFAULT".localized(path: path, table: table))
                        }
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
