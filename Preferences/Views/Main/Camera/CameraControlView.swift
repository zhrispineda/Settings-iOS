//
//  CameraControlView.swift
//  Preferences
//
//  Settings > Camera > Camera Control
//

import SwiftUI

struct CameraControlView: View {
    @AppStorage("CameraControlCleanPreview") private var cleanPreview = true
    @AppStorage("CameraControlLockFocus") private var lockFocus = false
    @AppStorage("CameraControlGesture") private var selectedGesture = "CAPTURE_BUTTON_LAUNCH_SINGLE_CLICK"
    @AppStorage("CameraControlApp") private var selectedApp = "Camera"
    @AppStorage("CameraControlRequireScreenOn") private var requireScreenOn = true
    @AppStorage("CameraControlVisualIntelligence") private var visualIntelligence = true
    let path = "/System/Library/PreferenceBundles/CameraSettings.bundle"
    let table = "CameraSettings-CameraButton"
    let options = ["CAPTURE_BUTTON_LAUNCH_SINGLE_CLICK", "CAPTURE_BUTTON_LAUNCH_DOUBLE_CLICK"]
    let apps: [AppSelection] = [
        AppSelection(id: "Camera", icon: "com.apple.camera"),
        AppSelection(id: "Code Scanner", icon: "com.apple.BarcodeScanner"),
        AppSelection(id: "Magnifier", icon: "com.apple.Magnifier"),
        AppSelection(id: "CAMERA_BUTTON_APP_LIST_NO_ACTION", icon: "no-action-icon")
    ]
    
    var body: some View {
        CustomList(title: "CAMERA_BUTTON_TITLE".localized(path: path, table: table), topPadding: true) {
            // MARK: Light Press Section
            Section {} header: {
                Text("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localized(path: path, table: table))
            } footer: {
                Text("CAPTURE_BUTTON_CAPTURE_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Clean Preview Section
            Section {
                Toggle("HIDE_CAMERA_CONTROLS".localized(path: path, table: table), isOn: $cleanPreview)
            } footer: {
                Text("CAPTURE_BUTTON_HIDE_CONTROLS_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Lock Focus and Exposure Section
            Section {
                Toggle("LOCK_TO_FOCUS".localized(path: path, table: table), isOn: $lockFocus)
            } footer: {
                Text("CAPTURE_BUTTON_LOCK_FOCUS_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: App Selection Section
            Section {
                NavigationLink(selectedApp.localized(path: path, table: table)) {
                    CustomList(title: selectedApp.localized(path: path, table: table)) {
                        Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localized(path: path, table: table), selection: $selectedApp) {
                            ForEach(apps) { app in
                                HStack {
                                    IconView(app.icon)
                                    Text(app.id.localized(path: path, table: table))
                                }
                            }
                        }
                        .pickerStyle(.inline)
                        .labelsHidden()
                    }
                }
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localized(path: path, table: table))
            } footer: {
                Text("CAMERA_BUTTON_APP_LIST_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Launch Camera Section
            Section {
                Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table), selection: $selectedGesture) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localized(path: path, table: table))
            } footer: {
                Text("CAPTURE_BUTTON_APP_LAUNCH_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Require Screen On
            Section {
                Toggle("CAPTURE_BUTTON_REQUIRES_SCREEN_ON".localized(path: path, table: table), isOn: $requireScreenOn)
            } footer: {
                Text("CAPTURE_BUTTON_REQUIRES_SCREEN_ON_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Launch Visual Intelligence
            Section {
                Toggle("CAPTURE_BUTTON_PRESS_AND_HOLD".localized(path: path, table: table), isOn: $visualIntelligence)
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_VISUAL_INTELLIGENCE_TITLE".localized(path: path, table: table))
            } footer: {
                Text("CAPTURE_BUTTON_LAUNCH_VISUAL_INTELLIGENCE_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Accessibility Section
            Section {
                NavigationLink("CAMERA_BUTTON_ACCESSIBILITY".localized(path: path, table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/AccessibilityUIUtilities.framework/AccessibilityUIUtilities", controller: "AXUICameraButtonController", title: "CAMERA_BUTTON_ACCESSIBILITY".localized(path: path, table: table))
                }
            }
        }
    }
}

struct AppSelection: Identifiable {
    var id: String
    var icon: String
}

#Preview {
    NavigationStack {
        CameraControlView()
    }
}
