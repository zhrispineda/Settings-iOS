//
//  DisplayBrightnessView.swift
//  Preferences
//
//  Settings > Display & Brightness
//

import SwiftUI

struct DisplayBrightnessView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("AutomaticAppearanceToggle") private var automaticEnabled = false
    @AppStorage("BoldTextToggle") private var boldTextEnabled = false
    @AppStorage("TrueToneToggle") private var trueToneEnabled = true
    @AppStorage("AutoLockDuration") private var autoLockDuration = UIDevice.iPhone ? "30 seconds" : "2 minutes"
    @AppStorage("RaiseWakeToggle") private var raiseToWakeEnabled = true
    @AppStorage("SmartCoverToggle") private var smartCoverEnabled = true
    @AppStorage("RequireScreenOnCameraControlToggle") private var requireScreenOnCameraControl = true
    @State private var appearance: Theme = .dark
    @State private var brightness = UIScreen.main.brightness
    @State private var lowPowerMode = false
    let path = "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework"
    let table = "Display"
    let phoneOptions = ["30 seconds", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes", "NEVER"]
    let tabletOptions = ["2 minutes", "5 minutes", "10 minutes", "15 minutes", "NEVER"]
    
    enum Theme {
        case dark
        case light
    }
    
    var body: some View {
        CustomList(title: "DISPLAY_AND_BRIGHTNESS".localized(path: path, table: table), topPadding: true) {
            // MARK: Appearance
            Section {
                HStack {
                    Text("") // For listRowSeparator
                    
                    Spacer()
                    
                    // Light
                    Button {
                        appearance = .light
                    } label: {
                        VStack(spacing: 15) {
                            ZStack {
                                if let asset = UIImage.asset(path: path, name: "AppearanceLight") {
                                    Image(uiImage: asset)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.iPhone ? 60 : 90)
                                        .padding(.top, 5)
                                }
                                Text("9:41")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, UIDevice.iPhone ? 75 : 25)
                            }
                            Text("COMPATIBLE_APPEARANCE_CHOICE_LIGHT".localized(path: path, table: table))
                                .font(.subheadline)
                                .padding(.bottom, -5)
                            Image(systemName: appearance == .light ? "checkmark.circle.fill": "circle")
                                .foregroundStyle(appearance == .light ? Color.white : Color.secondary, .blue)
                                .fontWeight(.light)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    // Dark
                    Button {
                        appearance = .dark
                    } label: {
                        VStack(spacing: 15) {
                            ZStack {
                                if let asset = UIImage.asset(path: path, name: "AppearanceDark") {
                                    Image(uiImage: asset)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.iPhone ? 60 : 90)
                                        .padding(.top, 5)
                                }
                                Text("9:41")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, UIDevice.iPhone ? 75 : 25)
                            }
                            Text("COMPATIBLE_APPEARANCE_CHOICE_DARK".localized(path: path, table: table))
                                .font(.subheadline)
                                .padding(.bottom, -5)
                            Image(systemName: appearance == .dark ? "checkmark.circle.fill": "circle")
                                .foregroundStyle(appearance == .dark ? Color.white : Color.secondary, .blue)
                                .fontWeight(.light)
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .onAppear {
                    appearance = colorScheme == .dark ? .dark : .light
                    lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
                }
                
                Toggle("AUTOMATIC".localized(path: path, table: table), isOn: $automaticEnabled.animation())
                
                if automaticEnabled {
                    SettingsLink("APPEARANCE_OPTIONS".localized(path: path, table: table), status: "LIGHT_UNTIL_SUNSET".localized(path: path, table: table), destination: EmptyView())
                }
            } header: {
                Text("APPEARANCE".localized(path: path, table: table))
            }
            
            // MARK: Liquid Glass
            Section {
                SettingsLink(
                    "LIQUID_GLASS".localized(path: path, table: table),
                    status: "CLEAR".localized(path: path, table: table)
                ) {
                    BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                        controller: "DBSLiquidGlassController",
                        title: "LIQUID_GLASS".localized(path: path, table: table)
                    )
                }
            } footer: {
                Text("LIQUID_GLASS_ROOT_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Text
            Section {
                NavigationLink("TEXT_SIZE".localized(path: path, table: table), destination: BundleControllerView("/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings", controller: "DBSLargeTextController", title: "TEXT_SIZE", table: table))
                Toggle("BOLD_TEXT".localized(path: path, table: table), isOn: $boldTextEnabled)
            }
            
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
                    UIScreen.main.brightness = brightness
                }
                
                Toggle("WHITE_BALANCE".localized(path: path, table: table), isOn: $trueToneEnabled)
            } header: {
                Text("BRIGHTNESS".localized(path: path, table: table))
            } footer: {
                Text("WHITE_BALANCE_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Night Shift
            Section {
                SettingsLink("BLUE_LIGHT_REDUCTION".localized(path: path, table: table), status: "OFF".localized(path: path, table: table), destination: EmptyView())
            }
            
            // MARK: Auto-Lock
            Section {
                SettingsLink(
                    "AUTOLOCK".localized(
                        path: path,
                        table: table
                    ),
                    status: autoLockDuration.localized(
                        path: path,
                        table: table
                    ),
                    destination: SelectOptionList(
                        "AUTOLOCK",
                        options: UIDevice.iPhone ? phoneOptions : tabletOptions,
                        selectedBinding: $autoLockDuration,
                        table: "Display"
                    )
                )
                .disabled(lowPowerMode)
                // Raise to Wake
                if UIDevice.iPhone {
                    Toggle("RAISE_TO_WAKE".localized(path: path, table: table), isOn: $raiseToWakeEnabled)
                }
                // Lock / Unlock
                if UIDevice.HallEffectCapability {
                    Toggle("SMART_CASE_LOCK".localized(path: path, table: table), isOn: $smartCoverEnabled)
                }
            } footer: {
                VStack(alignment: .leading) {
                    if UIDevice.HallEffectCapability {
                        Text(lowPowerMode ? "SMART_CASE_LOCK_FOOTER".localized(path: path, table: table) + "\n" : "SMART_CASE_LOCK_FOOTER".localized(path: path, table: table))
                    }
                    if lowPowerMode {
                        Text("AUTOLOCK_LPM_FOOTER".localized(path: path, table: table))
                    }
                }
            }
            
            if UIDevice.AlwaysOnDisplayCapability {
                // MARK: Always-On
                Section {
                    SettingsLink("ALWAYS_ON_DISPLAY".localized(path: path, table: table), status: "ALWAYS_ON_ENABLED".localized(path: path, table: table), destination: EmptyView())
                } footer: {
                    Text("ALWAYS_ON_DESCRIPTION".localized(path: path, table: table))
                }
            }
            
            // MARK: Display
            Section {
                SettingsLink("VIEW".localized(path: path, table: table), status: "DEFAULT".localized(path: "/System/Library/PreferenceBundles/AccessibilitySettings.bundle", table: "Accessibility"), destination: EmptyView())
            } header: {
                Text("DISPLAY_ZOOM_PRO".localized(path: path, table: table))
            } footer: {
                Text("DEFAULT_DISPLAY_ZOOMED_STANDARD_DESCRIPTION".localized(path: path, table: table))
            }
            
            if UIDevice.ReferenceModeCapability {
                // MARK: Reference Mode
                NavigationLink("ADVANCED".localized(path: path, table: table)) {}
            }
        }
        .animation(.default, value: automaticEnabled)
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
