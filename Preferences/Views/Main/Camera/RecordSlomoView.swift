//
//  RecordSlomoView.swift
//  Preferences
//
//  Settings > Camera > Record Slo-mo
//

import SwiftUI

struct RecordSlomoView: View {
    // Variables
    @AppStorage("CameraFormatSetting") private var cameraFormat = "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY"
    @AppStorage("CameraSlomoSetting") private var selected = String()
    var options = ["CAM_RECORD_SLOMO_1080p_120"]
    let table = "CameraSettings"
    let uhdTable = "CameraSettings-4k120"
    
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
        CustomList(title: "CAM_RECORD_SLOMO_TITLE".localize(table: table)) {
            Section {
                Picker("CAM_RECORD_SLOMO_TITLE".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: option.contains("4K") ? uhdTable : table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                VStack(alignment: .leading) {
                    if !UIDevice.HomeButtonCapability && !UIDevice.iPad {
                        Text("CAM_RECORD_SLOMO_FOOTER_FFC_120_ONLY".localize(table: table) + "\n")
                    }//CAM_RECORD_SLOMO_1080p_120_FOOTER
                    Text("CAM_RECORD_SLOMO_FOOTER_HEAD".localize(table: table))
                    if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
                        Text("CAM_RECORD_SLOMO_1080p_120\(cameraFormat.contains("COMPATIBLE") ? "" : "_HEVC")\(cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" ? "_FOOTER" : "_FOOTER_DEFAULT")".localize(table: cameraFormat.contains("COMPATIBLE") ? table : uhdTable))
                        //CAM_RECORD_SLOMO_1080p_120_HEVC_FOOTER_DEFAULT
                        Text("CAM_RECORD_SLOMO_1080p_240_FOOTER".localize(table: table))
                        if cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" {
                            Text("CAM_RECORD_SLOMO_720p_240_FOOTER_DEFAULT".localize(table: table))
                        }//CAM_RECORD_SLOMO_1080p_120_HEVC_FOOTER
                        Text("CAM_RECORD_SLOMO_4k_120_FOOTER\(cameraFormat.contains("COMPATIBLE") ? String() : "_HDR")".localize(table: uhdTable))
                    } else {
                        Text("CAM_RECORD_SLOMO_1080p_120_HEVC_FOOTER".localize(table: table))
                        Text("CAM_RECORD_SLOMO_1080p_240_FOOTER_DEFAULT".localize(table: table))
                        if cameraFormat != "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY" {
                            Text("CAM_RECORD_SLOMO_720p_240_FOOTER_DEFAULT".localize(table: table)) //740 HE
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
