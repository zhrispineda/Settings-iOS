//
//  CameraControlAccessibilityView.swift
//  Preferences
//
//  Settings > Camera > Camera Control > Accessibility
//

import SwiftUI

struct CameraControlAccessibilityView: View {
    // Variables
    @AppStorage("CameraControlEnabled") private var cameraControl = true
    @AppStorage("CameraControlLightPress") private var lightPressEnabled = true
    @AppStorage("CameraControlSwipe") private var swipeEnabled = false
    @AppStorage("CameraControlForce") private var selectedForce = "SENSITIVITY_DEFAULT"
    @AppStorage("CameraControlPress") private var selectedPress = "DOUBLE_PRESS_SPEED_DEFAULT"
    @AppStorage("CameraControlClick") private var selectedClick = "DOUBLE_CLICK_SPEED_DEFAULT"
    @Environment(\.colorScheme) private var colorScheme
    let table = "CameraSettings-CameraButton"
    let accTable = "Accessibility-D93"
    let forceOptions = ["SENSITIVITY_SOFTER", "SENSITIVITY_DEFAULT", "SENSITIVITY_HARDER"]
    let lightOptions = ["DOUBLE_PRESS_SPEED_DEFAULT", "DOUBLE_PRESS_SPEED_SLOW", "DOUBLE_PRESS_SPEED_SLOWER"]
    let clickOptions = ["DOUBLE_CLICK_SPEED_DEFAULT", "DOUBLE_CLICK_SPEED_SLOW", "DOUBLE_CLICK_SPEED_SLOWER"]
    
    var body: some View {
        CustomList(title: "CAMERA_BUTTON_ACCESSIBILITY".localize(table: table)) {
            // MARK: Camera Control Section
            Section {
                Toggle("CAMERA_BUTTON_TITLE".localize(table: accTable), isOn: $cameraControl.animation())
            } footer: {
                Text(.init("CAMERA_BUTTON_TOGGLE_FOOTER".localize(table: accTable, "[\("CAMERA_BUTTON_LEARN_MORE_TITLE".localize(table: accTable))](#)")))
            }
            
            if cameraControl {
                // MARK: Controls Gesture Section
                Section {
                    Toggle("SENSITIVITY_LIGHT_PRESS_ENABLED".localize(table: accTable), isOn: $lightPressEnabled)
                    Toggle("SENSITIVITY_SWIPE_ENABLED".localize(table: accTable), isOn: $swipeEnabled)
                } footer: {
                    Text("CONTROLS_GESTURE_FOOTER", tableName: accTable)
                }
                
                // MARK: Light-Press Force Section
                Section {
                    Picker("SENSITIVITY_HEADER".localize(table: table), selection: $selectedForce) {
                        ForEach(forceOptions, id: \.self) {
                            Text($0.localize(table: accTable))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("SENSITIVITY_HEADER", tableName: accTable)
                }
                
                // MARK: Camera Control Preview Section
                Section {
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.8))
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding([.bottom, .horizontal], -10)
                } footer: {
                    Text("SENSITIVITY_TESTER_FOOTER", tableName: accTable)
                }
                .listRowBackground(Color.clear)
                
                // MARK: Double Light-Press Speed Section
                Section {
                    Picker("DOUBLE_PRESS_SPEED_HEADER".localize(table: table), selection: $selectedPress) {
                        ForEach(lightOptions, id: \.self) {
                            Text($0.localize(table: accTable))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("DOUBLE_PRESS_SPEED_HEADER", tableName: accTable)
                }
                
                // MARK: Double Click Speed Section
                Section {
                    Picker("DOUBLE_CLICK_SPEED_HEADER".localize(table: table), selection: $selectedClick) {
                        ForEach(clickOptions, id: \.self) {
                            Text($0.localize(table: accTable))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("DOUBLE_CLICK_SPEED_HEADER", tableName: accTable)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CameraControlAccessibilityView()
    }
}
