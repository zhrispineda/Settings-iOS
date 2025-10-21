//
//  ScreenCaptureView.swift
//  Preferences
//
//  Settings > General > Screen Capture
//

import SwiftUI

struct ScreenCaptureView: View {
    @State private var fullScreenPreviews = false
    @State private var autoVisualLookup = true
    @State private var carPlayScreenshots = false
    @State private var format = "SCREEN_CAPTURE_SDR_ITEM"
    let options = ["SCREEN_CAPTURE_HDR_ITEM", "SCREEN_CAPTURE_SDR_ITEM"]
    let path = "/System/Library/PreferenceBundles/ScreenshotServicesSettings.bundle"

    var body: some View {
        CustomList(title: "SCREENSHOT_SERVICES_SETTINGS_TITLE".localized(path: path)) {
            Section {
                Toggle("ENABLE_PIP_LABEL".localized(path: path), isOn: $fullScreenPreviews)
            } footer: {
                Text("ENABLE_PIP_FOOTER_TEXT".localized(path: path))
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("ENABLE_VI_LABEL".localized(path: path), isOn: $autoVisualLookup)
                } footer: {
                    Text("ENABLE_VI_FOOTER_TEXT".localized(path: path))
                }
                
                Section {
                    Toggle("ENABLE_CARPLAYSCREENSHOTS_TEXT".localized(path: path), isOn: $carPlayScreenshots)
                } footer: {
                    Text("ENABLE_CARPLAYSCREENSHOTS_FOOTER_TEXT".localized(path: path))
                }
            }
            
            if !UIDevice.IsSimulator {
                Section {
                    Picker("Format", selection: $format) {
                        ForEach(options, id: \.self) { option in
                            Text(option.localized(path: path))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("SCREEN_CAPTURE_LABEL".localized(path: path))
                } footer: {
                    Text("SCREEN_CAPTURE_FOOTER_TEXT".localized(path: path))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenCaptureView()
    }
}
