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
            Section {
                Toggle("HIDE_CAMERA_CONTROLS".localize(table: table), isOn: $cleanPreview)
            } header: {
                Text("CAPTURE_BUTTON_LIGHT_PRESS_TITLE".localize(table: table))
            } footer: {
                Text("CAPTURE_BUTTON_CAPTURE_FOOTER".localize(table: table))
            }
            
            Section {
                Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table), selection: $selectedGesture) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table))
            } footer: {
                Text("CAPTURE_BUTTON_APP_LAUNCH_FOOTER".localize(table: table))
            }
            
            Section {
                Picker("CAPTURE_BUTTON_LAUNCH_APP_TITLE".localize(table: table), selection: $selectedApp) {
                    ForEach(apps) { app in
                        SettingsLabel(color: .white, icon: app.icon, id: app.id.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("CAMERA_BUTTON_APP_LIST_FOOTER".localize(table: table))
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
