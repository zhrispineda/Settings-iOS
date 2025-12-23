//
//  FormatsView.swift
//  Preferences
//
//  Settings > Camera > Formats
//

import SwiftUI

struct FormatsView: View {
    @AppStorage("CameraFormatSetting") private var cameraFormat = "CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY"
    @AppStorage("CameraSlomoSetting") private var selectedSlomo = String()
    @State private var proRawResolutionControl = false
    @State private var resolutionControl = false
    @State private var proRawEnabled = false
    @State private var proResCapture = false
    let options = ["CAM_FORMATS_CAPTURE_HIGH_EFFICIENCY", "CAM_FORMATS_CAPTURE_MOST_COMPATIBLE"]
    let path = "/System/Library/PreferenceBundles/CameraSettings.bundle"
    let table = "CameraSettings"
    let buttonTable = "CameraSettings-CameraButton"
    
    var body: some View {
        CustomList(title: "CAM_FORMATS_TITLE".localized(path: path, table: table), topPadding: true) {
            Section {
                Picker("CAM_FORMATS_TITLE".localized(path: path, table: table), selection: $cameraFormat) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
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
                Text("CAM_FORMATS_CAPTURE_TITLE".localized(path: path, table: table))
            } footer: {
                Text("CAM_FORMATS_CAPTURE_FOOTER_4k60_1080P240_HDR_VIDEO".localized(path: path, table: table))
            }
            
            if UIDevice.iPhone {
                if UIDevice.RingerButtonCapability && UIDevice.ProDevice {
                    Section {
                        SLink(
                            "ENHANCED_RESOLUTION_TITLE".localized(path: path, table: table),
                            status: "CAM_PHOTO_RESOLUTION_24MP".localized(path: path, table: table)
                        ) {}
                    } header: {
                        Text("CAM_PHOTO_CAPTURE_HEADER".localized(path: path, table: table))
                    } footer: {
                        if UIDevice.AdvancedPhotographicStylesCapability {
                            Text("ENHANCED_RESOLUTION_FOOTER_CAMERA_BUTTON".localized(path: path, table: buttonTable))
                        } else {
                            Text("ENHANCED_RESOLUTION_FOOTER".localized(path: path, table: table))
                        }
                    }
                }
                
                if UIDevice.VariableFramerateVideo {
                    Section {
                        if UIDevice.DeviceSupportsAlwaysOnTime {
                            Toggle("CAM_PRESERVE_PRO_RAW_48MP_SWITCH".localized(path: path, table: table), isOn: $proRawResolutionControl)
                        } else if UIDevice.AlwaysCaptureDepthCapability {
                            Toggle("CAM_PRESERVE_48MP_CONTROL_SWITCH".localized(path: path, table: table), isOn: $resolutionControl)
                        } else {
                            Toggle("CAM_LINEAR_DNG_TITLE".localized(path: path, table: table), isOn: $proRawEnabled)
                        }
                        if proRawResolutionControl {
                            SLink(
                                "CAM_SECONDARY_PHOTO_FORMAT_TITLE".localized(path: path, table: table),
                                status: "CAM_SECONDARY_PHOTO_FORMAT_RAW48_SHORT".localized(path: path, table: table)
                            ) {}
                        }
                    } footer: {
                        Text("\(UIDevice.AlwaysCaptureDepthCapability ? "48MP_CONTROL_FOOTER".localized(path: path, table: table) : "CAM_PRO_RAW_48MP_FOOTER")".localized(path: path, table: table))
                        
                    }
                }
                
                if UIDevice.CinematicModeCapability && UIDevice.ProDevice {
                    Section {
                        Toggle("CAM_PRESERVE_PRO_RES_SWITCH".localized(path: path, table: table), isOn: $proResCapture)
                        if proResCapture && UIDevice.RingerButtonCapability && UIDevice.ProDevice {
                            SLink(
                                "PRO_RES_COLOR_SPACE_TITLE".localized(path: path, table: table),
                                status: "PRO_RES_COLOR_SPACE_HDR".localized(path: path, table: table)
                            ) {}
                        }
                    } header: {
                        Text("CAM_FORMATS_VIDEO_CAPTURE_GROUP_TITLE".localized(path: path, table: table))
                    } footer: {
                        Text("CAM_FORMATS_PRO_RES_EXTERNAL_STORAGE_FOOTER".localized(path: path, table: table))
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
