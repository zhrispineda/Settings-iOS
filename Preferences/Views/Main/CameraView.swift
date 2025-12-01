//
//  CameraView.swift
//  Preferences
//
//  Settings > Camera
//

import SwiftUI

struct CameraView: View {
    @AppStorage("CameraControlApp") private var selectedApp = "Camera"
    @AppStorage("CameraVideoSetting") private var selectedVideoSetting = "CAM_RECORD_VIDEO_1080p_30"
    @AppStorage("CameraSlomoSetting") private var selectedSlomoSetting = ""
    @AppStorage("CameraCinematicSetting") private var selectedCinematicSetting = "CAM_RECORD_VIDEO_1080p_30"
    @AppStorage("CameraSoundSetting") private var selectedSoundSetting = ""
    @State private var showingPhotographicStylesView = false
    @AppStorage("CameraBurstToggle") private var useVolumeUpBurstEnabled = false
    @AppStorage("CameraQRCodesToggle") private var scanQRCodesEnabled = true
    @AppStorage("CameraDetectTextToggle") private var showDetectedTextEnabled = true
    
    @AppStorage("CameraGridToggle") private var gridEnabled = false
    @AppStorage("CameraLevelToggle") private var levelEnabled = false
    @AppStorage("MirrorFrontCameraToggle") private var mirrorFrontCameraEnabled = false
    @AppStorage("CameraViewOutsideFrameToggle") private var viewOutsideFrameEnabled = true
    
    @AppStorage("CameraSceneDetectionToggle") private var sceneDetectionEnabled = true
    @AppStorage("CameraPortraitsToggle") private var portraitsPhotoModeEnabled = true
    @AppStorage("CameraFasterShootingToggle") private var prioritizeFasterShootingEnabled = true
    @AppStorage("CameraLensCorrectionToggle") private var lensCorrectionEnabled = true
    @AppStorage("CameraKeepNormalPhotoToggle") private var keepNormalPhoto = true
    @AppStorage("CameraMacroControlToggle") private var macroControlEnabled = true
    @AppStorage("CameraSmudgeDetectionToggle") private var smudgeDetection = true
    @AppStorage("CameraLockScreenSwipeToggle") private var lockScreenSwipe = true
    @AppStorage("CameraSaveMessagesPhotosToggle") private var saveMessagesPhotos = true
    @AppStorage("CameraClassicModeSwitchToggle") private var classicModeSwitching = false
    @State private var showingHelpSheet = false
    @State private var showingPrivacySheet = false
    
    let path = "/System/Library/PreferenceBundles/CameraSettings.bundle"
    let table = "CameraSettings"
    let buttonTable = "CameraSettings-CameraButton"
    let stylesTable = "CameraSettings-SmartStyles"
    let privacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.camera.bundle"
    
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
        CustomList(title: "CAMERA_SETTINGS_TITLE".localized(path: path, table: table), topPadding: true) {
            // MARK: - System Settings
            if !UIDevice.IsSimulator && UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    SettingsLink(
                        "CAMERA_BUTTON_TITLE".localized(path: path, table: buttonTable),
                        status: selectedApp.localized(path: path, table: buttonTable),
                        destination: CameraControlView()
                    )
                } header: {
                    Text("SYSTEM_SETTINGS_HEADER".localized(path: path, table: stylesTable))
                } footer: {
                    Text(.init(
                        "CAMERA_BUTTON_%@_FOOTER".localized(
                            path: path,
                            table: buttonTable,
                            "[\("CAMERA_BUTTON_LEARN_MORE_TITLE".localized(path: path, table: buttonTable))](pref://helpkit)"
                        )
                    ))
                }
            }
            
            // MARK: - App Settings
            if UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    Button {
                        showingPhotographicStylesView = true
                    } label: {
                        SettingsLink(
                            "SYSTEM_STYLES_TITLE".localized(path: path, table: stylesTable),
                            status: "SEMANTIC_STYLES_LABEL_STANDARD".localized(
                                path: "/System/Library/PrivateFrameworks/CameraEditKit.framework",
                                table: "CameraEditKit"
                            )
                        ) {}
                    }
                    .foregroundStyle(.primary)
                } header: {
                    if !UIDevice.IsSimulator {
                        Text("APP_SETTINGS_HEADER".localized(path: path, table: stylesTable))
                    }
                } footer: {
                    Text("SYSTEM_STYLES_FOOTER".localized(path: path, table: stylesTable))
                }
            }
            
            // MARK: - Camera Options
            Section {
                SettingsLink(
                    "CAM_RECORD_VIDEO_TITLE".localized(path: path, table: table),
                    status: "\(selectedVideoSetting)_SHORT".localized(path: path, table: table),
                    destination: RecordVideoView()
                )
                SettingsLink(
                    "CAM_RECORD_SLOMO_TITLE".localized(path: path, table: table),
                    status: "\(selectedSlomoSetting)_SHORT".localized(path: path, table: table),
                    destination: RecordSlomoView()
                )
                if UIDevice.HigherResolutionCinematicModeCapability {
                    SettingsLink(
                        "CAM_RECORD_CINEMATIC_TITLE".localized(path: path, table: table),
                        status: "\(selectedCinematicSetting)_SHORT".localized(path: path, table: table),
                        destination: RecordCinematicView()
                    )
                }
                SettingsLink(
                    "CAM_AUDIO_CONFIGURATION_TITLE".localized(path: path, table: table),
                    status: selectedSoundSetting.localized(path: path, table: table),
                    destination: RecordSoundView()
                )
                NavigationLink(
                    "CAM_FORMATS_TITLE".localized(path: path, table: table)
                ) {
                    FormatsView()
                }
                if UIDevice.iPhone {
                    NavigationLink(
                        "CAM_PRESERVE_SETTINGS_TITLE".localized(path: path, table: table)
                    ) {
                        BundleControllerView(
                            "CameraSettings",
                            controller: "CameraPreserveSettingsController",
                            title: "CAM_PRESERVE_SETTINGS_TITLE".localized(path: path, table: table)
                        )
                    }
                    Toggle(
                        "VOLUME_UP_BURST".localized(path: path, table: table),
                        isOn: $useVolumeUpBurstEnabled
                    )
                }
                
                Toggle(
                    "QR_CODES".localized(path: path, table: table),
                    isOn: $scanQRCodesEnabled
                )
                Toggle(
                    "TEXT_ANALYSIS".localized(path: path, table: table),
                    isOn: $showDetectedTextEnabled
                )
                
                if UIDevice.iPad {
                    NavigationLink(
                        "CAM_PRESERVE_SETTINGS_TITLE".localized(path: path, table: table)
                    ) {
                        BundleControllerView(
                            "CameraSettings",
                            controller: "CameraPreserveSettingsController",
                            title: "CAM_PRESERVE_SETTINGS_TITLE".localized(path: path, table: table)
                        )
                    }
                }
            }
            
            // MARK: - Composition
            Section {
                Toggle(
                    "Grid".localized(path: path, table: table),
                    isOn: $gridEnabled
                )
                Toggle(
                    "HORIZON_LEVEL".localized(path: path, table: table),
                    isOn: $levelEnabled
                )
                Toggle(
                    "MIRROR_FRONT_CAPTURES".localized(path: path, table: table),
                    isOn: $mirrorFrontCameraEnabled
                )
                if UIDevice.ViewOutsideFrameCapability && UIDevice.iPhone {
                    Toggle(
                        "OVER_CAPTURE_VIEW_OUTSIDE_THE_FRAME_SWITCH".localized(path: path, table: table),
                        isOn: $viewOutsideFrameEnabled
                    )
                }
                NavigationLink(
                    "CAM_INDICATORS_TITLE".localized(path: path, table: table)
                ) {
                    BundleControllerView(
                        "CameraSettings",
                        controller: "CameraIndicatorSettingsController",
                        title: "CAM_INDICATORS_TITLE".localized(path: path, table: table)
                    )
                }
            } header: {
                Text("COMPOSITION_GROUP_TITLE".localized(path: path, table: table))
            }
            
            // MARK: - Photo Capture
            if UIDevice.PhotographicStylesCapability {
                Section {
                    Button("SEMANTIC_STYLES_ROW_TITLE".localized(path: path, table: table)) {
                        showingPhotographicStylesView = true
                    }
                } header: {
                    Text("CAM_PHOTO_CAPTURE_GROUP_TITLE".localized(path: path, table: table))
                } footer: {
                    Text("SEMANTIC_STYLES_ROW_FOOTER".localized(path: path, table: table))
                }
            } else if UIDevice.SceneDetectionCapability {
                Section {
                    Toggle("SEM_DEV_SWITCH".localized(path: path, table: table), isOn: $sceneDetectionEnabled)
                } header: {
                    Text("CAM_PHOTO_CAPTURE_HEADER".localized(path: path, table: table))
                } footer: {
                    Text("SEM_DEV_GROUP_FOOTER".localized(path: path, table: table))
                }
            }
            
            if UIDevice.ProDevice && UIDevice.iPhone {
                Section {
                    SettingsLink(
                        UIDevice.AdvancedPhotographicStylesCapability && !UIDevice.IsSimulator
                        ? "FOCAL_LENGTH_ROW_TITLE_CAMERA_BUTTON".localized(path: path, table: buttonTable)
                        : "FOCAL_LENGTH_ROW_TITLE".localized(path: path, table: table),
                        status: "FOCAL_LENGTH_GROUP_%@_AND_%@_AND_%@_MM".localized(path: path, table: table, "24", "28", "35"),
                        destination: FocalLengthView()
                    )
                } header: {
                    if UIDevice.AdvancedPhotographicStylesCapability {
                        Text("CAM_PHOTO_CAPTURE_HEADER".localized(path: path, table: table))
                    }
                } footer: {
                    Text("FOCAL_LENGTH_ROW_%@_MM_FOOTER".localized(path: path, table: table, "24"))
                }
            }
            
            // MARK: - Portraits in Photo Mode
            if UIDevice.AlwaysCaptureDepthCapability {
                Section {
                    Toggle(
                        "PHOTO_MODE_DEPTH_SWITCH".localized(path: path, table: table),
                        isOn: $portraitsPhotoModeEnabled
                    )
                } footer: {
                    Text("PHOTO_MODE_DEPTH_GROUP_FOOTER".localized(path: path, table: table))
                }
            }
            
            // MARK: - Prioritize Faster Shooting
            if UIDevice.iPhone && !UIDevice.IsSimulator {
                Section {
                    Toggle(
                        "CAM_CAPTURE_DYNAMIC_SHUTTER_SWITCH".localized(path: path, table: table),
                        isOn: $prioritizeFasterShootingEnabled
                    )
                } footer: {
                    Text("CAM_CAPTURE_GROUP_FOOTER".localized(path: path, table: table))
                }
            }
            
            // MARK: - Lens Correction
            if UIDevice.LensCorrectionCapability {
                Section {
                    Toggle(
                        "IDC_SWITCH".localized(path: path, table: table),
                        isOn: $lensCorrectionEnabled
                    )
                } footer: {
                    Text(
                        UIDevice.LimitedLensCorrectionCapability
                        ? "IDC_FOOTER_FRONT_ONLY".localized(path: path, table: table)
                        : "IDC_FOOTER".localized(path: path, table: table)
                    )
                    
                }
            }
            
            // MARK: - HDR (High Dynamic Range)
            // MARK: REQUIRED CAPABILITIES:
            // - cameraRestriction: false
            // - hdr-image-capture: true
            if UIDevice.cameraRestriction && UIDevice.`hdr-image-capture` {
                Section {
                    Toggle(
                        "HDR_KEEP_ORIGINAL_PHOTO".localized(path: path, table: table),
                        isOn: $keepNormalPhoto
                    )
                } header: {
                    Text("HDR_TITLE".localized(path: path, table: table))
                } footer: {
                    Text("HDR_TITLE_FOOTER_TEXT".localized(path: path, table: table))
                }
            }
            
            // MARK: - Macro Control
            if UIDevice.MacroLensCapability {
                Section {
                    Toggle(
                        "AUTO_MACRO_SWITCH".localized(path: path, table: table),
                        isOn: $macroControlEnabled
                    )
                } footer: {
                    Text("AUTO_MACRO_GROUP_FOOTER".localized(path: path, table: table))
                }
            }
            
            // MARK: - Lens Cleaning
            Section {
                Toggle(
                    "SMUDGE_DETECTION_SWITCH".localized(path: path, table: table),
                    isOn: $smudgeDetection
                )
            } footer: {
                Text("SMUDGE_DETECTION_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: - Lock Screen Swipe to Open Camera
            Section {
                Toggle(
                    "LOCK_SCREEN_SWIPE_SWITCH".localized(path: path, table: table),
                    isOn: $lockScreenSwipe
                )
            } footer: {
                Text(
                    "LOCK_SCREEN_SWIPE_%@_FOOTER".localized(
                        path: path,
                        table: table,
                        "SWIPE_LEFT".localized(path: path, table: table)
                    )
                )
            }
            
            // MARK: - Messages
            // MARK: Save Captures to Photo Library
            Section {
                Toggle(
                    "CAM_SAVE_MESSAGES_ASSETS_PHOTO_LIBRARY_SWITCH".localized(path: path, table: table),
                    isOn: $saveMessagesPhotos
                )
            } header: {
                Text("CAM_SAVE_MESSAGES_ASSETS_PHOTO_LIBRARY_TITLE".localized(path: path, table: table))
            } footer: {
                Text("CAM_SAVE_MESSAGES_ASSETS_PHOTO_LIBRARY_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: - Camera & ARKit Privacy Footer
            if UIDevice.LiDARCapability {
                Section {} footer: {
                    Text("[\("BUTTON_TITLE".localized(path: privacy, table: "Camera"))](pref://privacy)")
                }
            }
        }
        .fullScreenCover(isPresented: $showingPhotographicStylesView) {
            NavigationStack {
                BundleControllerView(
                    "/System/Library/PrivateFrameworks/CameraUI.framework/CameraUI",
                    controller: UIDevice.PhotographicStylesCapability
                    ? "CAMSemanticStyleSettingsController"
                    : "CAMSmartStyleSettingsController"
                )
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            } else if url.absoluteString == "pref://privacy" {
                showingPrivacySheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: "iph0c397b154")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.camera")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        CameraView()
    }
}
