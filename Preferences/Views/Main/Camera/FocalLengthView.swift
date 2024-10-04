//
//  FocalLengthView.swift
//  Preferences
//
//  Settings > Camera > [Fusion/Main] Camera
//

import SwiftUI

struct FocalLengthView: View {
    // Variables
    @AppStorage("CameraFirstFocalLensSetting") private var firstAdditionalLens = true
    @AppStorage("CameraSecondFocalLensSetting") private var secondAdditionalLens = true
    @AppStorage("CameraFocalLengthSetting") private var selected = "FOCAL_LENGTH_DEFAULT_OPTION_24_MM_1×"
    let table = "CameraSettings"
    let buttonTable = "CameraSettings-CameraButton"
    
    var body: some View {
        CustomList(title: UIDevice.AdvancedPhotographicStylesCapability && !UIDevice.IsSimulator ? "FOCAL_LENGTH_ROW_TITLE_CAMERA_BUTTON".localize(table: buttonTable) : "FOCAL_LENGTH_ROW_TITLE".localize(table: table), topPadding: true) {
            Section {
                Toggle("FOCAL_LENGTH_%@_MM".localize(table: table, "28"), isOn: $firstAdditionalLens)
                Toggle("FOCAL_LENGTH_%@_MM".localize(table: table, "35"), isOn: $secondAdditionalLens)
            } header: {
                Text("FOCAL_LENGTH_HEADER".localize(table: table))
            } footer: {
                Text("FOCAL_LENGTH_ROW_%@_MM_FOOTER".localize(table: table, "24"))
            }
            
            if firstAdditionalLens || secondAdditionalLens {
                Section {
                    Picker("FOCAL_LENGTH_DEFAULT_TITLE".localize(table: table), selection: $selected) {
                        Text("FOCAL_LENGTH_DEFAULT_OPTION_%@_MM_%@_ZOOM".localize(table: table, "24", "1×")).tag("FOCAL_LENGTH_DEFAULT_OPTION_24_MM_1×")
                        if firstAdditionalLens {
                            Text("FOCAL_LENGTH_DEFAULT_OPTION_%@_MM_%@_ZOOM".localize(table: table, "28", "1.2×")).tag("FOCAL_LENGTH_DEFAULT_OPTION_28_MM_1.2×")
                        }
                        if secondAdditionalLens {
                            Text("FOCAL_LENGTH_DEFAULT_OPTION_%@_MM_%@_ZOOM".localize(table: table, "35", "1.5×")).tag("FOCAL_LENGTH_DEFAULT_OPTION_35_MM_1.5×")
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                    .onChange(of: firstAdditionalLens) {
                        if selected == "FOCAL_LENGTH_DEFAULT_OPTION_28_MM_1.2×" {
                            selected = "FOCAL_LENGTH_DEFAULT_OPTION_24_MM_1×"
                        }
                    }
                    .onChange(of: secondAdditionalLens) {
                        if selected == "FOCAL_LENGTH_DEFAULT_OPTION_35_MM_1.5×" {
                            selected = "FOCAL_LENGTH_DEFAULT_OPTION_28_MM_1.2×"
                        }
                    }
                } header: {
                    Text("FOCAL_LENGTH_DEFAULT_TITLE".localize(table: table))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FocalLengthView()
    }
}
