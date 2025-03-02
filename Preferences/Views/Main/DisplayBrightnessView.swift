//
//  DisplayBrightnessView.swift
//  Preferences
//
//  Settings > Display & Brightness
//

import SwiftUI

struct DisplayBrightnessView: View {
    // Variables
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("AutomaticAppearanceToggle") private var automaticEnabled = false
    @AppStorage("BoldTextToggle") private var boldTextEnabled = false
    @AppStorage("TrueToneToggle") private var trueToneEnabled = true
    @AppStorage("AutoLockDuration") private var autoLockDuration: String = "30 seconds"
    @AppStorage("RaiseWakeToggle") private var raiseToWakeEnabled = true
    @AppStorage("RequireScreenOnCameraControlToggle") private var requireScreenOnCameraControl = true
    @State private var appearance: Theme = .dark
    @State private var brightness = UIScreen.main.brightness
    @State private var lowPowerMode = false
    let table = "Display"
    
    enum Theme {
        case dark
        case light
    }
    
    var body: some View {
        CustomList(title: "DISPLAY_AND_BRIGHTNESS".localize(table: table), topPadding: true) {
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
                                Image(.appearanceLight)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIDevice.iPhone ? 60 : 90)
                                    .padding(.top, 5)
                                Text("9:41")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, UIDevice.iPhone ? 70 : 80)
                            }
                            Text("COMPATIBLE_APPEARANCE_CHOICE_LIGHT", tableName: table)
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
                                Image(.appearanceDark)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIDevice.iPhone ? 60 : 90)
                                    .padding(.top, 5)
                                Text("9:41")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, UIDevice.iPhone ? 70 : 80)
                            }
                            Text("COMPATIBLE_APPEARANCE_CHOICE_DARK", tableName: table)
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
                
                Toggle("AUTOMATIC".localize(table: table), isOn: $automaticEnabled.animation())
                
                if automaticEnabled {
                    CustomNavigationLink(title: "APPEARANCE_OPTIONS".localize(table: table), status: "LIGHT_UNTIL_SUNSET".localize(table: table), destination: EmptyView())
                }
            } header: {
                Text("APPEARANCE", tableName: table)
            }
            
            // MARK: Text
            Section {
                NavigationLink("TEXT_SIZE".localize(table: table)) {}
                Toggle("BOLD_TEXT".localize(table: table), isOn: $boldTextEnabled)
            }
            
            // MARK: Brightness
            Section {
                Group {
                    Slider(value: $brightness,
                           in: 0.0...1.0,
                           minimumValueLabel: Image(systemName: "sun.min.fill"),
                           maximumValueLabel: Image(systemName: "sun.max.fill"),
                           label: { Text("BRIGHTNESS", tableName: table)  }
                    )
                }
                .foregroundStyle(.secondary)
                .imageScale(.large)
                .onChange(of: brightness) {
                    UIScreen.main.brightness = brightness
                }
                
                Toggle("WHITE_BALANCE".localize(table: table), isOn: $trueToneEnabled)
            } header: {
                Text("Brightness", tableName: table)
            } footer: {
                Text("WHITE_BALANCE_FOOTER", tableName: table)
            }
            
            // MARK: Night Shift
            Section {
                CustomNavigationLink(title: "BLUE_LIGHT_REDUCTION".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
            }
            
            // MARK: Auto-Lock
            Section {
                CustomNavigationLink(title: "AUTOLOCK".localize(table: table), status: autoLockDuration.localize(table: table), destination: SelectOptionList(title: "AUTOLOCK", options: ["30 seconds", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes", "NEVER"], selectedBinding: $autoLockDuration, table: "Display"))
                    .disabled(lowPowerMode)
                Toggle("RAISE_TO_WAKE".localize(table: table), isOn: $raiseToWakeEnabled)
            } footer: {
                if lowPowerMode {
                    Text("AUTOLOCK_LPM_FOOTER", tableName: table)
                }
            }
            
            if UIDevice.AlwaysOnDisplayCapability {
                // MARK: Always-On
                Section {
                    CustomNavigationLink(title: "ALWAYS_ON_DISPLAY".localize(table: table), status: "ALWAYS_ON_ENABLED".localize(table: table), destination: EmptyView())
                } footer: {
                    Text("ALWAYS_ON_DESCRIPTION", tableName: table)
                }
            }
            
            // MARK: Display
            Section {
                CustomNavigationLink(title: "VIEW".localize(table: table), status: "DEFAULT".localize(table: "Accessibility"), destination: EmptyView())
            } header: {
                Text("DISPLAY_ONLY_TITLE", tableName: "Accessibility")
            } footer: {
                Text("DEFAULT_DISPLAY_ZOOMED_STANDARD_DESCRIPTION", tableName: table)
            }
            
            if UIDevice.AdvancedPhotographicStylesCapability {
                // MARK: Camera Control
                Section {
                    Toggle("REQUIRE_SCREEN_ON".localize(table: table), isOn: $requireScreenOnCameraControl)
                } header: {
                    Text("CAMERA_CONTROL", tableName: table)
                } footer: {
                    Text("LAUNCHING_CAMERA_REQUIRES_SCREEN_ON_FOOTER", tableName: table)
                }
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
