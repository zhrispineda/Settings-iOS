//
//  CameraControlView.swift
//  Preferences
//
//  Settings > Camera > Camera Control
//

import SwiftUI

struct CameraControlView: View {
    // Variables
    @AppStorage("CameraControlCleanPreview") private var cleanPreview = true
    @AppStorage("CameraControlLockFocus") private var lockFocus = false
    @AppStorage("CameraControlGesture") private var selectedGesture = "CAPTURE_BUTTON_LAUNCH_SINGLE_CLICK"
    @AppStorage("CameraControlApp") private var selectedApp = "Camera"
    @AppStorage("CameraControlRequireScreenOn") private var requireScreenOn = true
    @AppStorage("CameraControlVisualIntelligence") private var visualIntelligence = true
    let table = "CameraSettings-CameraButton"
    let options = ["CAPTURE_BUTTON_LAUNCH_SINGLE_CLICK", "CAPTURE_BUTTON_LAUNCH_DOUBLE_CLICK"]
    let apps: [AppSelection] = [
        AppSelection(id: "Camera", icon: "com.apple.camera"),
        AppSelection(id: "Code Scanner", icon: "com.apple.BarcodeScanner"),
        AppSelection(id: "Magnifier", icon: "com.apple.Magnifier"),
        AppSelection(id: "CAMERA_BUTTON_APP_LIST_NO_ACTION", icon: "CSNoActionIcon")
    ]
    
    var body: some View {
        CustomList(title: "CAMERA_BUTTON_TITLE".localize(table: table), topPadding: true) {
            // MARK: Light Press Section
            Section {} header: {
                Text("CAPTURE_BUTTON_LIGHT_PRESS_TITLE", tableName: table)
            } footer: {
                Text("CAPTURE_BUTTON_CAPTURE_FOOTER", tableName: table)
            }
            
            // MARK: Clean Preview Section
            Section {
                Toggle("HIDE_CAMERA_CONTROLS".localize(table: table), isOn: $cleanPreview)
            } footer: {
                Text("CAPTURE_BUTTON_HIDE_CONTROLS_FOOTER", tableName: table)
            }
            
            // MARK: Lock Focus and Exposure Section
            Section {
                Toggle("LOCK_TO_FOCUS".localize(table: table), isOn: $lockFocus)
            } footer: {
                Text("CAPTURE_BUTTON_LOCK_FOCUS_FOOTER", tableName: table)
            }
            
            // MARK: App Selection Section
            Section {
                NavigationLink(selectedApp.localize(table: table)) {
                    CustomList(title: selectedApp.localize(table: table)) {
                        Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table), selection: $selectedApp) {
                            ForEach(apps) { app in
                                SLabel(app.id.localize(table: table), color: .white, icon: app.icon)
                            }
                        }
                        .pickerStyle(.inline)
                        .labelsHidden()
                    }
                }
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_APP_TITLE", tableName: table)
            } footer: {
                Text("CAMERA_BUTTON_APP_LIST_FOOTER", tableName: table)
            }
            
            // MARK: Launch Camera Section
            Section {
                Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table), selection: $selectedGesture) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_APP_TITLE", tableName: table)
            } footer: {
                Text("CAPTURE_BUTTON_APP_LAUNCH_FOOTER", tableName: table)
            }
            
            // MARK: Require Screen On
            Section {
                Toggle("CAPTURE_BUTTON_REQUIRES_SCREEN_ON".localize(table: table), isOn: $requireScreenOn)
            } footer: {
                Text("CAPTURE_BUTTON_REQUIRES_SCREEN_ON_FOOTER", tableName: table)
            }
            
            // MARK: Launch Visual Intelligence
            Section {
                Toggle("CAPTURE_BUTTON_PRESS_AND_HOLD".localize(table: table), isOn: $visualIntelligence)
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_VISUAL_INTELLIGENCE_TITLE", tableName: table)
            } footer: {
                Text("CAPTURE_BUTTON_LAUNCH_VISUAL_INTELLIGENCE_FOOTER", tableName: table)
            }
            
            // MARK: Accessibility Section
            Section {
                NavigationLink("CAMERA_BUTTON_ACCESSIBILITY".localize(table: table)) {
                    BundleControllerView("/System/Library/PrivateFrameworks/AccessibilityUIUtilities.framework/AccessibilityUIUtilities", controller: "AXUICameraButtonController", title: "CAMERA_BUTTON_ACCESSIBILITY", table: table)
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
