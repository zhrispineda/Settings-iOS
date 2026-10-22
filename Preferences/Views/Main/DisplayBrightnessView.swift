//
//  DisplayBrightnessView.swift
//  Preferences
//
//  Settings > Display & Brightness
//

import SwiftUI

struct DisplayBrightnessView: View {
    @AppStorage("TrueToneToggle") private var trueToneEnabled = true
    @AppStorage("AutoLockDuration") private var autoLockDuration = UIDevice.iPhone ? "30 seconds" : "2 minutes"
    @AppStorage("RaiseWakeToggle") private var raiseToWakeEnabled = true
    @AppStorage("SmartCoverToggle") private var smartCoverEnabled = true
    @AppStorage("RequireScreenOnCameraControlToggle") private var requireScreenOnCameraControl = true
    @State private var brightness: CGFloat = 0.5
    @State private var lowPowerMode = false
    private let path = "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework"
    private let table = "Display"
    private let phoneOptions = ["30 seconds", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes", "NEVER"]
    private let tabletOptions = ["2 minutes", "5 minutes", "10 minutes", "15 minutes", "NEVER"]
    private var screen: UIScreen? {
        (UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene)?.screen
    }
    
    var body: some View {
        CustomList(title: "DISPLAY_AND_BRIGHTNESS".localized(path: path, table: table), topPadding: true) {
            // MARK: Brightness
            Section {
                Group {
                    Slider(value: $brightness,
                           in: 0.0...1.0,
                           minimumValueLabel: Image(systemName: "sun.min.fill"),
                           maximumValueLabel: Image(systemName: "sun.max.fill"),
                           label: { Text("BRIGHTNESS".localized(path: path, table: table))  }
                    )
                }
                .foregroundStyle(.secondary)
                .imageScale(.large)
                .onChange(of: brightness) {
                    screen?.brightness = brightness
                }
                
                Toggle("WHITE_BALANCE".localized(path: path, table: table), isOn: $trueToneEnabled)
            } header: {
                Text("BRIGHTNESS".localized(path: path, table: table))
            } footer: {
                Text("WHITE_BALANCE_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Night Shift
            Section {
                SLink(
                    "BLUE_LIGHT_REDUCTION".localized(path: path, table: table),
                    status: "OFF".localized(path: path, table: table)
                ) {}
            }
            
            // MARK: Auto-Lock
            Section {
                SLink(
                    "AUTOLOCK".localized(path: path, table: table),
                    status: autoLockDuration.localized(path: path, table: table),
                    destination: SelectOptionList(
                        "AUTOLOCK",
                        options: UIDevice.iPhone ? phoneOptions : tabletOptions,
                        selected: $autoLockDuration,
                        path: path,
                        table: "Display"
                    )
                )
                .disabled(lowPowerMode)
                // Raise to Wake
                if UIDevice.iPhone {
                    Toggle("RAISE_TO_WAKE".localized(path: path, table: table), isOn: $raiseToWakeEnabled)
                }
                // Lock / Unlock
                if UIDevice.`hall-effect-sensor` {
                    Toggle("SMART_CASE_LOCK".localized(path: path, table: table), isOn: $smartCoverEnabled)
                }
            } footer: {
                VStack(alignment: .leading) {
                    if UIDevice.`hall-effect-sensor` {
                        Text(lowPowerMode
                             ? "SMART_CASE_LOCK_FOOTER".localized(path: path, table: table) + "\n"
                             : "SMART_CASE_LOCK_FOOTER".localized(path: path, table: table)
                        )
                    }
                    if lowPowerMode {
                        Text("AUTOLOCK_LPM_FOOTER".localized(path: path, table: table))
                    }
                }
            }
            
            if UIDevice.DeviceSupportsAlwaysOnTime {
                // MARK: Always On Display
                Section {
                    SLink(
                        "ALWAYS_ON_DISPLAY".localized(path: path, table: table),
                        status: "ALWAYS_ON_ENABLED".localized(path: path, table: table),
                        destination: ControllerBridgeView(
                            "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                            controller: "DBSAlwaysOnViewController",
                            title: "ALWAYS_ON_DISPLAY".localized(path: path, table: table)
                        )
                    )
                } footer: {
                    Text("ALWAYS_ON_DESCRIPTION".localized(path: path, table: table))
                }
            }
            
            if UIDevice.ReferenceModeCapability {
                // MARK: Reference Mode
                NavigationLink("ADVANCED".localized(path: path, table: table)) {
                    ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                        controller: "DBSReferenceAndCalibrationController",
                        title: "ADVANCED".localized(path: path, table: table)
                    )
                }
            }
        }
        .onChange(of: ProcessInfo.processInfo.isLowPowerModeEnabled) {
            lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
        }
    }
}

#Preview {
    NavigationStack {
        DisplayBrightnessView()
    }
}
