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
    @State private var showingSheet = false
    
    let table = "CameraSettings"
    let buttonTable = "CameraSettings-CameraButton"
    let stylesTable = "CameraSettings-SmartStyles"
    let kitTable = "CameraEditKit"
    let cineTable = "CameraSettings-CinematicAudio"
    let privacyTable = "Camera"
    
    init() {
        if selectedSlomoSetting.isEmpty && !UIDevice.ProDevice || UIDevice.iPad {
            selectedSlomoSetting = "CAM_RECORD_SLOMO_1080p_240"
        } else if selectedSlomoSetting.isEmpty && UIDevice.AdvancedPhotographicStylesCapability && UIDevice.ProDevice {
            selectedSlomoSetting = "CAM_RECORD_SLOMO_1080p_120"
        }
        
        if selectedSoundSetting.isEmpty && UIDevice.AdvancedPhotographicStylesCapability || UIDevice.identifier == "iPhone17,5" {
            selectedSoundSetting = "CAM_AUDIO_CONFIGURATION_CINEMATIC"
        } else if selectedSoundSetting.isEmpty {
            selectedSoundSetting = "CAM_AUDIO_CONFIGURATION_STEREO"
        }
    }
    
    var body: some View {
        CustomList(title: "CAMERA_SETTINGS_TITLE".localize(table: table), topPadding: true) {
            // MARK: System Settings Section
            if !UIDevice.IsSimulator && UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    CustomNavigationLink("CAMERA_BUTTON_TITLE".localize(table: buttonTable), status: selectedApp.localize(table: buttonTable), destination: CameraControlView())
                } header: {
                    Text("SYSTEM_SETTINGS_HEADER", tableName: stylesTable)
                } footer: {
                    Text(.init("CAMERA_BUTTON_%@_FOOTER".localize(table: buttonTable, "[\("CAMERA_BUTTON_LEARN_MORE_TITLE".localize(table: buttonTable))](#)")))
                }
            }
            
            // MARK: App Settings Section
            if UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    Button {
                        showingPhotographicStylesView.toggle()
                    } label: {
                        CustomNavigationLink("SYSTEM_STYLES_TITLE".localize(table: stylesTable), status: "SEMANTIC_STYLES_LABEL_STANDARD".localize(table: kitTable), destination: EmptyView())
                    }
                    .foregroundStyle(Color["Label"])
                    .fullScreenCover(isPresented: $showingPhotographicStylesView) {
                        NavigationStack {
                            PhotographicStylesView()
                        }
                    }
                } header: {
                    if !UIDevice.IsSimulator {
                        Text("APP_SETTINGS_HEADER", tableName: stylesTable)
                    }
                } footer: {
                    Text("SYSTEM_STYLES_FOOTER", tableName: stylesTable)
                }
            }
            
            // MARK: Camera Options Section
            Section {
                CustomNavigationLink("CAM_RECORD_VIDEO_TITLE".localize(table: table), status: "\(selectedVideoSetting)_SHORT".localize(table: table), destination: RecordVideoView())
                CustomNavigationLink("CAM_RECORD_SLOMO_TITLE".localize(table: table), status: "\(selectedSlomoSetting)_SHORT".localize(table: table), destination: RecordSlomoView())
                if UIDevice.HigherResolutionCinematicModeCapability {
                    CustomNavigationLink("CAM_RECORD_CINEMATIC_TITLE".localize(table: table), status: "\(selectedCinematicSetting)_SHORT".localize(table: table), destination: RecordCinematicView())
                }
                CustomNavigationLink("CAM_AUDIO_CONFIGURATION_TITLE".localize(table: table), status: selectedSoundSetting.localize(table: selectedSoundSetting.contains("CINEMATIC") ? cineTable : table), destination: RecordSoundView())
                NavigationLink("CAM_FORMATS_TITLE".localize(table: table)) {
                    FormatsView()
                }
                
                if UIDevice.iPhone {
                    NavigationLink("CAM_PRESERVE_SETTINGS_TITLE".localize(table: table)) {
                        PreserveSettingsView()
                    }
                    Toggle("VOLUME_UP_BURST".localize(table: table), isOn: $useVolumeUpBurstEnabled)
                }
                
                Toggle("QR_CODES".localize(table: table), isOn: $scanQrCodesEnabled)
                Toggle("TEXT_ANALYSIS".localize(table: table), isOn: $showDetectedTextEnabled)
                
                if UIDevice.iPad {
                    NavigationLink("CAM_PRESERVE_SETTINGS_TITLE".localize(table: table)) {
                        PreserveSettingsView()
                    }
                }
            }
            
            // MARK: Composition Section
            Section {
                Toggle("Grid".localize(table: table), isOn: $gridEnabled)
                Toggle("HORIZON_LEVEL".localize(table: table), isOn: $levelEnabled)
                Toggle("MIRROR_FRONT_CAPTURES".localize(table: table), isOn: $mirrorFrontCameraEnabled)
                if UIDevice.ViewOutsideFrameCapability && UIDevice.iPhone {
                    Toggle("OVER_CAPTURE_VIEW_OUTSIDE_THE_FRAME_SWITCH".localize(table: table), isOn: $viewOutsideFrameEnabled)
                }
            } header: {
                Text("COMPOSITION_GROUP_TITLE", tableName: table)
            }
            
            // MARK: Photo Capture Section
            if UIDevice.PhotographicStylesCapability {
                Section {
                    Button("SEMANTIC_STYLES_ROW_TITLE".localize(table: table)) {}
                } header: {
                    Text("CAM_PHOTO_CAPTURE_GROUP_TITLE", tableName: table)
                } footer: {
                    Text("SEMANTIC_STYLES_ROW_FOOTER", tableName: table)
                }
            } else if UIDevice.SceneDetectionCapability {
                Section {
                    Toggle("SEM_DEV_SWITCH".localize(table: table), isOn: $sceneDetectionEnabled)
                } header: {
                    Text("CAM_PHOTO_CAPTURE_HEADER", tableName: table)
                } footer: {
                    Text("SEM_DEV_GROUP_FOOTER", tableName: table)
                }
            }
            
            if UIDevice.ProDevice && UIDevice.iPhone {
                Section {
                    CustomNavigationLink(UIDevice.AdvancedPhotographicStylesCapability && !UIDevice.IsSimulator ? "FOCAL_LENGTH_ROW_TITLE_CAMERA_BUTTON".localize(table: buttonTable) : "FOCAL_LENGTH_ROW_TITLE".localize(table: table), status: "FOCAL_LENGTH_GROUP_%@_AND_%@_AND_%@_MM".localize(table: table, "24", "28", "35"), destination: FocalLengthView())
                } header: {
                    if UIDevice.AdvancedPhotographicStylesCapability {
                        Text("CAM_PHOTO_CAPTURE_HEADER", tableName: table)
                    }
                } footer: {
                    Text("FOCAL_LENGTH_ROW_%@_MM_FOOTER".localize(table: table, "24"))
                }
            }
            
            if UIDevice.AlwaysCaptureDepthCapability {
                Section {
                    Toggle("PHOTO_MODE_DEPTH_SWITCH".localize(table: table), isOn: $portraitsPhotoModeEnabled)
                } footer: {
                    Text("PHOTO_MODE_DEPTH_GROUP_FOOTER", tableName: table)
                }
            }
            
            // MARK: Prioritize Faster Shooting
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    Toggle("CAM_CAPTURE_DYNAMIC_SHUTTER_SWITCH".localize(table: table), isOn: $prioritizeFasterShootingEnabled)
                } footer: {
                    Text("CAM_CAPTURE_GROUP_FOOTER", tableName: table)
                }
            }
            
            // MARK: Lens Correction Section
            if UIDevice.LensCorrectionCapability {
                Section {
                    Toggle("IDC_SWITCH".localize(table: table), isOn: $lensCorrectionEnabled)
                } footer: {
                    Text(UIDevice.LimitedLensCorrectionCapability ? "IDC_FOOTER_FRONT_ONLY" : "IDC_FOOTER", tableName: table)
                    
                }
            }
            
            // MARK: Macro Control Section
            if UIDevice.MacroLensCapability {
                Section {
                    Toggle("AUTO_MACRO_SWITCH".localize(table: table), isOn: $macroControlEnabled)
                } footer: {
                    Text("AUTO_MACRO_GROUP_FOOTER", tableName: table)
                }
            }
            
            // MARK: Camera & ARKit Privacy Footer
            if UIDevice.LiDARCapability {
                Section {} footer: {
                    Text(.init("[\("BUTTON_TITLE".localize(table: privacyTable))](pref://)"))
                }
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingView(table: privacyTable)
        }
    }
}

#Preview {
    NavigationStack {
        CameraView()
    }
}
