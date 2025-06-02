//
//  FormatsView.swift
//  Preferences
//
//  Settings > Camera > Formats
//

import SwiftUI

struct FormatsView: View {
    // Variables
    @AppStorage("CameraFormatSetting") private var cameraFormat = "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY"
    @AppStorage("CameraSlomoSetting") private var selectedSlomo = String()
    @State private var proRawResolutionControl = false
    @State private var resolutionControl = false
    @State private var proRawEnabled = false
    @State private var proResCapture = false
    let options = ["CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY", "CAM_FORMATS_CAPTURE_MOST_COMPATIBLE"]
    let table = "CameraSettings"
    let buttonTable = "CameraSettings-CameraButton"
    
    var body: some View {
        CustomList(title: "CAM_FORMATS_TITLE".localize(table: table), topPadding: true) {
            Section {
                Picker("CAM_FORMATS_TITLE".localize(table: table), selection: $cameraFormat) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                .onChange(of: cameraFormat) {
                    if cameraFormat == "CAM_FORMATS_CAPTURE_MOST_COMPATIBLE" {
                        selectedSlomo = "CAM_RECORD_SLOMO_720p_240"
                    } else {
                        selectedSlomo = "CAM_RECORD_SLOMO_1080p_240"
                    }
                }
            } header: {
                Text("CAM_FORMATS_CAPTURE_TITLE".localize(table: table))
            } footer: {
                Text("CAM_FORMATS_CAPTURE_FOOTER_4k60_1080P240_HDR_VIDEO".localize(table: table))
            }
            
            if UIDevice.iPhone {
                if UIDevice.RingerButtonCapability && UIDevice.ProDevice || UIDevice.fullModel.contains("iPhone 16") {
                    Section {
                        SettingsLink("ENHANCED_RESOLUTION_TITLE".localize(table: table), status: "CAM_PHOTO_RESOLUTION_24MP".localize(table: table), destination: EmptyView())
                    } header: {
                        Text("CAM_PHOTO_CAPTURE_HEADER".localize(table: table))
                    } footer: {
                        if UIDevice.AdvancedPhotographicStylesCapability {
                            Text("ENHANCED_RESOLUTION_FOOTER_CAMERA_BUTTON".localize(table: buttonTable))
                        } else {
                            Text("ENHANCED_RESOLUTION_FOOTER".localize(table: table))
                        }
                    }
                }
                
                if UIDevice.RearFacingCameraHDRCapability {
                    Section {
                        if UIDevice.AlwaysOnDisplayCapability {
                            Toggle("CAM_PRESERVE_PRO_RAW_48MP_SWITCH".localize(table: table), isOn: $proRawResolutionControl)
                        } else if UIDevice.AlwaysCaptureDepthCapability {
                            Toggle("CAM_PRESERVE_48MP_CONTROL_SWITCH".localize(table: table), isOn: $resolutionControl)
                        } else {
                            Toggle("CAM_LINEAR_DNG_TITLE".localize(table: table), isOn: $proRawEnabled)
                        }
                        if proRawResolutionControl {
                            SettingsLink("CAM_SECONDARY_PHOTO_FORMAT_TITLE".localize(table: table), status: "CAM_SECONDARY_PHOTO_FORMAT_RAW48_SHORT".localize(table: table), destination: EmptyView())
                        }
                    } footer: {
                        Text("\(UIDevice.AlwaysCaptureDepthCapability ? "48MP_CONTROL_FOOTER" : "CAM_PRO_RAW_48MP_FOOTER")".localize(table: table))
                        
                    }
                }
                
                if UIDevice.CinematicModeCapability && UIDevice.ProDevice {
                    Section {
                        Toggle("CAM_PRESERVE_PRO_RES_SWITCH".localize(table: table), isOn: $proResCapture)
                        if proResCapture && UIDevice.RingerButtonCapability && UIDevice.ProDevice {
                            SettingsLink("PRO_RES_COLOR_SPACE_TITLE".localize(table: table), status: "PRO_RES_COLOR_SPACE_HDR".localize(table: table), destination: EmptyView())
                        }
                    } header: {
                        Text("CAM_FORMATS_VIDEO_CAPTURE_GROUP_TITLE".localize(table: table))
                    } footer: {
                        Text("CAM_FORMATS_PRO_RES_EXTERNAL_STORAGE_FOOTER".localize(table: table))
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FormatsView()
    }
}
