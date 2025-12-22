//
//  RecordVideoView.swift
//  Preferences
//
//  Settings > Camera > Record Video
//

import SwiftUI

struct RecordVideoView: View {
    @AppStorage("CameraVideoSetting") private var selected = "CAM_RECORD_VIDEO_1080p_30"
    @AppStorage("CameraPALFormats") private var showPalFormats = false
    @AppStorage("CameraEnhancedStabilization") private var enhancedStabilization = true
    @AppStorage("CameraActionLowerLight") private var actionModeLowerLight = false
    @AppStorage("CameraHDRVideo") private var hdrVideo = true
    var options = ["CAM_RECORD_VIDEO_720p_30", "CAM_RECORD_VIDEO_1080p_30", "CAM_RECORD_VIDEO_1080p_60", "CAM_RECORD_VIDEO_4K_24", "CAM_RECORD_VIDEO_4K_30", "CAM_RECORD_VIDEO_4K_60"]
    var optionsPal = ["CAM_RECORD_VIDEO_720p_30", "CAM_RECORD_VIDEO_1080p_25", "CAM_RECORD_VIDEO_1080p_30", "CAM_RECORD_VIDEO_1080p_60", "CAM_RECORD_VIDEO_4K_24", "CAM_RECORD_VIDEO_4K_25", "CAM_RECORD_VIDEO_4K_30", "CAM_RECORD_VIDEO_4K_60"]
    let path = "/System/Library/PreferenceBundles/CameraSettings.bundle"
    let table = "CameraSettings"
    
    init() { // Change options based on device on initialization
        if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice { // 16 Pro & 16 Pro Max
            options = ["CAM_RECORD_VIDEO_720p_30", "CAM_RECORD_VIDEO_1080p_30", "CAM_RECORD_VIDEO_1080p_60", "CAM_RECORD_VIDEO_1080P_120", "CAM_RECORD_VIDEO_4K_24", "CAM_RECORD_VIDEO_4K_30", "CAM_RECORD_VIDEO_4K_60", "CAM_RECORD_VIDEO_4K_120"]
            optionsPal = ["CAM_RECORD_VIDEO_720p_30", "CAM_RECORD_VIDEO_1080p_25", "CAM_RECORD_VIDEO_1080p_30", "CAM_RECORD_VIDEO_1080p_60", "CAM_RECORD_VIDEO_1080P_120", "CAM_RECORD_VIDEO_4K_24", "CAM_RECORD_VIDEO_4K_25", "CAM_RECORD_VIDEO_4K_30", "CAM_RECORD_VIDEO_4K_60", "CAM_RECORD_VIDEO_4K_100", "CAM_RECORD_VIDEO_4K_120"]
        }
    }
    
    var body: some View {
        CustomList(title: "CAM_RECORD_VIDEO_TITLE".localized(path: path, table: table)) {
            Section {
                Picker("CAM_RECORD_VIDEO_TITLE".localized(path: path, table: table), selection: $selected) {
                    ForEach(showPalFormats ? optionsPal : options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                .onChange(of: showPalFormats) { // Reset to 1080p HD at 30 fps if PAL is selected and toggled off
                    if selected.contains("25") || selected.contains("100") && !showPalFormats {
                        selected = "CAM_RECORD_VIDEO_1080p_30"
                    }
                }
            } footer: {
                VStack(alignment: .leading) {
                    if UIDevice.iPhone && !UIDevice.ProDevice {
                        Text("CAM_RECORD_VIDEO_FOOTER_QUICKTAKE".localized(path: path, table: table))
                    } else {
                        Text("CAM_RECORD_VIDEO_FOOTER_TRUE_VIDEO".localized(path: path, table: table))
                    }
                    
                    Text("\n" + "CAM_RECORD_VIDEO_FOOTER_HEAD".localized(path: path, table: table))
                    Text("CAM_RECORD_VIDEO_720p_30_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    if showPalFormats {
                        Text("CAM_RECORD_VIDEO_1080p_25_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    }
                    Text("CAM_RECORD_VIDEO_1080p_30_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    Text("CAM_RECORD_VIDEO_1080p_60_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
                        Text("CAM_RECORD_VIDEO_1080P_120_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    }
                    Text("CAM_RECORD_VIDEO_4K_24_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    if showPalFormats {
                        Text("CAM_RECORD_VIDEO_4K_25_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    }
                    Text("CAM_RECORD_VIDEO_4K_30_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    Text("CAM_RECORD_VIDEO_4K_60_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    if UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
                        if showPalFormats {
                            Text("CAM_RECORD_VIDEO_4K_100_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                        }
                        Text("CAM_RECORD_VIDEO_4K_120_HEVC\(hdrVideo ? "_DOLBY" : "")_FOOTER".localized(path: path, table: table))
                    }
                }
            }
            
            Section {
                Toggle("CAM_PAL_VIDEO_FORMATS_TITLE".localized(path: path, table: table), isOn: $showPalFormats)
            } footer: {
                Text("CAM_PAL_VIDEO_FORMATS_FOOTER".localized(path: path, table: table))
            }
            
            if UIDevice.queryCameraCapability("_actionModeControlSupported") {
                Section {
                    Toggle("CAM_ENABLE_VIDEO_STABILIZATION_SWITCH".localized(path: path, table: table), isOn: $enhancedStabilization)
                } footer: {
                    Text("CAM_ENABLE_VIDEO_STABILIZATION_FOOTER".localized(path: path, table: table))
                }
                
                Section {
                    Toggle("CAM_ACTION_MODE_LOW_LIGHT".localized(path: path, table: table), isOn: $actionModeLowerLight)
                } footer: {
                    Text("CAM_ACTION_MODE_LOW_LIGHT_FOOTER".localized(path: path, table: table))
                }
            }
            
            if UIDevice.RearFacingCameraHDRCapability {
                Section {
                    Toggle("CAM_HDR_VIDEO_TITLE".localized(path: path, table: table), isOn: $hdrVideo)
                } footer: {
                    Text(UIDevice.AdvancedPhotographicStylesCapability ? "CAM_HDR_VIDEO_FOOTER_4k120".localized(path: path, table: table) : "CAM_HDR_VIDEO_FOOTER".localized(path: path, table: table))
                }
            }
            
            Section {
                SLink(
                    "CAM_AUTO_FPS_TITLE".localized(path: path, table: table),
                    status: "CAM_AUTO_FPS_VFR_30&60".localized(path: path, table: table),
                ) {}
            } footer: {
                Text("CAM_AUTO_FPS_VFR_FOOTER".localized(path: path, table: table))
            }
            
            if UIDevice.CinematicModeCapability {
                Section {
                    Toggle("CAM_VIDEO_RECORDING_DISABLE_CAMERA_SWITCHING_TITLE".localized(path: path, table: table), isOn: .constant(false))
                } footer: {
                    Text("CAM_VIDEO_RECORDING_DISABLE_CAMERA_SWITCHING_FOOTER".localized(path: path, table: table))
                }
            }
            
            Section {
                Toggle("CAM_VIDEO_RECORDING_LOCK_WHITE_BALANCE_TITLE".localized(path: path, table: table), isOn: .constant(false))
            } footer: {
                Text("CAM_VIDEO_RECORDING_LOCK_WHITE_BALANCE_FOOTER".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecordVideoView()
    }
}
