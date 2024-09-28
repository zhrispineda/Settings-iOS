//
//  CameraView.swift
//  Preferences
//
//  Settings > Camera
//

import SwiftUI

struct CameraView: View {
    // Variables
    @AppStorage("CameraControlApp") private var selectedApp = "Camera"
    @AppStorage("CameraVideoSetting") private var selectedVideoSetting = "CAM_RECORD_VIDEO_1080p_30"
    @AppStorage("CameraSlomoSetting") private var selectedSlomoSetting = String()
    @AppStorage("CameraCinematicSetting") private var selectedCinematicSetting = "CAM_RECORD_VIDEO_1080p_30"
    @AppStorage("CameraSoundSetting") private var selectedSoundSetting = String()
    @State private var showingPhotographicStylesView = false
    @State private var useVolumeUpBurstEnabled = false
    @State private var scanQrCodesEnabled = true
    @State private var showDetectedTextEnabled = true
    
    @State private var gridEnabled = false
    @State private var levelEnabled = false
    @State private var mirrorFrontCameraEnabled = false
    @State private var viewOutsideFrameEnabled = true
    
    @State private var sceneDetectionEnabled = true
    @State private var portraitsPhotoModeEnabled = true
    @State private var prioritizeFasterShootingEnabled = true
    @State private var lensCorrectionEnabled = true
    @State private var macroControlEnabled = true
    
    let table = "CameraSettings"
    
    init() {
        if selectedSlomoSetting.isEmpty && !UIDevice.ProDevice || UIDevice.iPad {
            selectedSlomoSetting = "CAM_RECORD_SLOMO_1080p_240"
        } else if selectedSlomoSetting.isEmpty && UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
            selectedSlomoSetting = "CAM_RECORD_SLOMO_1080p_120"
        }
        
        if selectedSoundSetting.isEmpty && UIDevice.AdvancedPhotographicStylesCapability {
            selectedSoundSetting = "CAM_AUDIO_CONFIGURATION_CINEMATIC"
        } else if selectedSoundSetting.isEmpty {
            selectedSoundSetting = "CAM_AUDIO_CONFIGURATION_STEREO"
        }
    }
    
    var body: some View {
        CustomList(title: "CAMERA_SETTINGS_TITLE".localize(table: table), topPadding: true) {
            if !UIDevice.isSimulator && UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    CustomNavigationLink(title: "CAMERA_BUTTON_TITLE".localize(table: table), status: selectedApp.localize(table: table + "-CameraButton"), destination: CameraControlView())
                } header: {
                    Text("SYSTEM_SETTINGS_HEADER".localize(table: table))
                } footer: {
                    Text(.init("CAMERA_BUTTON_%@_FOOTER".localize(table: table).replacingOccurrences(of: "Learn more.", with: "[Learn more.](#)")))
                }
            }
            
            if UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    Button {
                        showingPhotographicStylesView.toggle()
                    } label: {
                        CustomNavigationLink(title: "SYSTEM_STYLES_TITLE".localize(table: table), status: "SEMANTIC_STYLES_LABEL_STANDARD".localize(table: table), destination: EmptyView())
                    }
                    .foregroundStyle(Color["Label"])
                    .fullScreenCover(isPresented: $showingPhotographicStylesView) {
                        NavigationStack {
                            PhotographicStylesView()
                        }
                    }
                } header: {
                    if !UIDevice.isSimulator {
                        Text("APP_SETTINGS_HEADER".localize(table: table))
                    }
                } footer: {
                    Text("SYSTEM_STYLES_FOOTER".localize(table: table))
                }
            }
            
            Section {
                CustomNavigationLink(title: "CAM_RECORD_VIDEO_TITLE".localize(table: table), status: "\(selectedVideoSetting)_SHORT".localize(table: table), destination: RecordVideoView())
                CustomNavigationLink(title: "CAM_RECORD_SLOMO_TITLE".localize(table: table), status: "\(selectedSlomoSetting)_SHORT".localize(table: table), destination: RecordSlomoView())
                if UIDevice.HigherResolutionCinematicModeCapability {
                    CustomNavigationLink(title: "CAM_RECORD_CINEMATIC_TITLE".localize(table: table), status: "\(selectedCinematicSetting)_SHORT".localize(table: table), destination: RecordCinematicView())
                }
                CustomNavigationLink(title: "CAM_AUDIO_CONFIGURATION_TITLE".localize(table: table), status: selectedSoundSetting.localize(table: table), destination: RecordSoundView())
                NavigationLink("CAM_FORMATS_TITLE".localize(table: table)) {
                    FormatsView()
                }
                NavigationLink("CAM_PRESERVE_SETTINGS_TITLE".localize(table: table)) {}
                if UIDevice.iPhone {
                    Toggle("VOLUME_UP_BURST".localize(table: table), isOn: $useVolumeUpBurstEnabled)
                }
                Toggle("QR_CODES".localize(table: table), isOn: $scanQrCodesEnabled)
                Toggle("TEXT_ANALYSIS".localize(table: table), isOn: $showDetectedTextEnabled)
            }
            
            Section {
                Toggle("Grid".localize(table: table), isOn: $gridEnabled)
                Toggle("HORIZON_LEVEL".localize(table: table), isOn: $levelEnabled)
                Toggle("MIRROR_FRONT_CAPTURES".localize(table: table), isOn: $mirrorFrontCameraEnabled)
                if UIDevice.ViewOutsideFrameCapability && UIDevice.iPhone {
                    Toggle("OVER_CAPTURE_VIEW_OUTSIDE_THE_FRAME_SWITCH".localize(table: table), isOn: $viewOutsideFrameEnabled)
                }
            } header: {
                Text("COMPOSITION_GROUP_TITLE".localize(table: table))
            }
            
            if UIDevice.PhotographicStylesCapability {
                Section {
                    Button("SEMANTIC_STYLES_ROW_TITLE".localize(table: table)) {}
                } header: {
                    Text("CAM_PHOTO_CAPTURE_GROUP_TITLE".localize(table: table))
                } footer: {
                    Text("SEMANTIC_STYLES_ROW_FOOTER".localize(table: table))
                }
            } else if UIDevice.iPad || UIDevice.SceneDetectionCapability {
                Section {
                    Toggle("SEM_DEV_SWITCH".localize(table: table), isOn: $sceneDetectionEnabled)
                } header: {
                    Text("CAM_PHOTO_CAPTURE_HEADER".localize(table: table))
                } footer: {
                    Text("SEM_DEV_GROUP_FOOTER".localize(table: table))
                }
            }
            
            if UIDevice.ProDevice && UIDevice.iPhone {
                Section {
                    CustomNavigationLink(title: UIDevice.AdvancedPhotographicStylesCapability ? "FOCAL_LENGTH_ROW_TITLE_CAMERA_BUTTON".localize(table: table) : "FOCAL_LENGTH_ROW_TITLE".localize(table: table), status: "FOCAL_LENGTH_GROUP_%@_AND_%@_AND_%@_MM".localize(table: table, "24", "28", "35"), destination: EmptyView())
                } header: {
                    if UIDevice.AdvancedPhotographicStylesCapability {
                        Text("CAM_PHOTO_CAPTURE_HEADER".localize(table: table))
                    }
                } footer: {
                    Text("FOCAL_LENGTH_ROW_%@_MM_FOOTER".localize(table: table, "24"))
                }
            }
            
            if UIDevice.AlwaysCaptureDepthCapability {
                Section {
                    Toggle("PHOTO_MODE_DEPTH_SWITCH".localize(table: table), isOn: $portraitsPhotoModeEnabled)
                } footer: {
                    Text("PHOTO_MODE_DEPTH_GROUP_FOOTER".localize(table: table))
                }
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("CAM_CAPTURE_DYNAMIC_SHUTTER_SWITCH".localize(table: table), isOn: $prioritizeFasterShootingEnabled)
                } footer: {
                    Text("CAM_CAPTURE_GROUP_FOOTER".localize(table: table))
                }
            }
            
            if UIDevice.LensCorrectionCapability {
                Section {
                    Toggle("IDC_SWITCH".localize(table: table), isOn: $lensCorrectionEnabled)
                } footer: {
                    Text("IDC_FOOTER".localize(table: table))
                }
            }
            
            if UIDevice.MacroLensCapability {
                Section {
                    Toggle("AUTO_MACRO_SWITCH".localize(table: table), isOn: $macroControlEnabled)
                } footer: {
                    Text("AUTO_MACRO_GROUP_FOOTER".localize(table: table))
                }
                
                Section {} footer: {
                    Text(.init("[" + "BUTTON_TITLE".localize(table: table) + "](#)")) // com.apple.onboarding.camera
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CameraView()
    }
}
