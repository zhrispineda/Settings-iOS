//
//  AppearanceView.swift
//  Preferences
//
//  Settings > Appearance
//

import SwiftUI

enum Theme {
    case dark
    case light
}

struct DisplayAppearanceOptionView: View {
    let option: Theme
    @Binding var appearance: Theme
    let asset: String
    let text: String
    let path: String
    let table: String
    
    var body: some View {
        Button {
            appearance = option
        } label: {
            VStack(spacing: 15) {
                ZStack {
                    Image(
                        asset,
                        bundle: Bundle(path: UIDevice.RuntimePath + path)
                    )
                    Text("9:41")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .kerning(-1.25)
                        .foregroundStyle(.white)
                        .padding(.bottom, UIDevice.iPhone ? 75 : 25)
                }
                Text(text.localized(path: path, table: table))
                    .padding(.vertical, -5)
                Image(systemName: appearance == option ? "checkmark.circle.fill": "circle")
                    .imageScale(.large)
                    .foregroundStyle(appearance == option ? Color(UIColor.systemBackground) : Color.secondary, .blue)
                    .fontWeight(.light)
            }
        }
        .buttonStyle(.plain)
    }
}

struct AppearanceView: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("AutomaticAppearanceToggle") private var automaticEnabled = false
    @AppStorage("BoldTextToggle") private var boldTextEnabled = false
    @State private var appearance: Theme = .dark
    private let path = "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework"
    private let table = "Display"
    
    var body: some View {
        CustomList(title: "Appearance") {
            // MARK: Appearance
            Section {
                HStack {
                    Text("") // For listRowSeparator
                    
                    Spacer()
                    
                    // Light
                    DisplayAppearanceOptionView(
                        option: .light,
                        appearance: $appearance,
                        asset: "AppearanceLight",
                        text: "COMPATIBLE_APPEARANCE_CHOICE_LIGHT",
                        path: path,
                        table: table
                    )
                    
                    Spacer()
                    
                    // Dark
                    DisplayAppearanceOptionView(
                        option: .dark,
                        appearance: $appearance,
                        asset: "AppearanceDark",
                        text: "COMPATIBLE_APPEARANCE_CHOICE_DARK",
                        path: path,
                        table: table
                    )
                    
                    Spacer()
                }
                .onAppear {
                    appearance = colorScheme == .dark ? .dark : .light
                }

                Toggle("AUTOMATIC".localized(path: path, table: table), isOn: $automaticEnabled.animation())
                
                if automaticEnabled {
                    SLink(
                        "APPEARANCE_OPTIONS".localized(path: path, table: table),
                        status: "LIGHT_UNTIL_SUNSET".localized(path: path, table: table),
                        destination: ControllerBridgeView(
                            "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                            controller: "DBSDeviceAppearanceScheduleController",
                            title: "APPEARANCE_SCHEDULE".localized(
                                path: path,
                                table: "DeviceAppearanceSchedule"
                            )
                        )
                    )
                }
            } header: {
                Text("APPEARANCE".localized(path: path, table: table))
            }
            
            // MARK: Liquid Glass
            Section {
                SLink(
                    "LIQUID_GLASS".localized(path: path, table: table),
                    status: "CLEAR".localized(path: path, table: table),
                    destination: ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                        controller: "DBSLiquidGlassController",
                        title: "LIQUID_GLASS".localized(path: path, table: table)
                    )
                )
            } footer: {
                Text("LIQUID_GLASS_ROOT_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Text
            Section {
                NavigationLink(
                    "TEXT_SIZE".localized(path: path, table: table),
                    destination: ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                        controller: "DBSLargeTextController",
                        title: "TEXT_SIZE".localized(path: path, table: table)
                    )
                )
                Toggle("BOLD_TEXT".localized(path: path, table: table), isOn: $boldTextEnabled)
            }
            
            // MARK: Display
            Section {
                SLink(
                    "VIEW".localized(path: path, table: table),
                    status: "DEFAULT".localized(path: "/System/Library/PreferenceBundles/AccessibilitySettings.bundle", table: "Accessibility"),
                    destination: ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings",
                        controller: "DBSDisplayZoomSelectionListController",
                        title: "VIEW".localized(path: path, table: table)
                    )
                )
            } header: {
                Text("DISPLAY_ZOOM_PRO".localized(path: path, table: table))
            } footer: {
                Text("DEFAULT_DISPLAY_ZOOMED_STANDARD_DESCRIPTION".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    AppearanceView()
}
