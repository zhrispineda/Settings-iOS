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
    let table = "CameraSettings-CameraButton"
    let options = ["CAPTURE_BUTTON_LAUNCH_SINGLE_CLICK", "CAPTURE_BUTTON_LAUNCH_DOUBLE_CLICK"]
    let apps: [AppSelection] = [
        AppSelection(id: "Camera", icon: "appleCamera"),
        AppSelection(id: "Code Scanner", icon: "appleScanner"),
        AppSelection(id: "Magnifier", icon: "appleMagnifier"),
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
            
            // MARK: App Selection Section
            Section {
                Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table), selection: $selectedApp) {
                    ForEach(apps) { app in
                        SLabel(app.id.localize(table: table), color: .white, icon: app.icon)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("CAMERA_BUTTON_APP_LIST_FOOTER", tableName: table)
            }
            
            // MARK: Accessibility Section
            Section {
                NavigationLink("CAMERA_BUTTON_ACCESSIBILITY".localize(table: table), destination: CameraControlAccessibilityView())
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
