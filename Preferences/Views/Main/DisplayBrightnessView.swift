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
    @State private var appearance: Theme = .dark
    
    enum Theme {
        case dark
        case light
    }
    
    @State private var automaticEnabled = false
    @State private var boldTextEnabled = false
    @State private var brightness = UIScreen.main.brightness
    @State private var trueToneEnabled = true
    @State private var raiseToWakeEnabled = true
    let table = "Display"
    
    var body: some View {
        CustomList(title: "DISPLAY_AND_BRIGHTNESS".localize(table: table), topPadding: true) {
            Section {
                HStack {
                    Text("") // For listRowSeparator
                    Spacer()
                    Button {
                        appearance = .light
                    } label: {
                        VStack(spacing: 15) {
                            ZStack {
                                Image("\(UIDevice.current.model.lowercased())-appearance-light")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    .padding(.top, 5)
                                Text("9:41")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 70)
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
                    Button {
                        appearance = .dark
                    } label: {
                        VStack(spacing: 15) {
                            ZStack {
                                Image("\(UIDevice.current.model.lowercased())-appearance-dark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    .padding(.top, 5)
                                Text("9:41")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 70)
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
                }
                
                Toggle("AUTOMATIC".localize(table: table), isOn: $automaticEnabled.animation())
                
                if automaticEnabled {
                    CustomNavigationLink(title: "APPEARANCE_OPTIONS".localize(table: table), status: "LIGHT_UNTIL_SUNSET".localize(table: table), destination: EmptyView())
                }
            } header: {
                Text("APPEARANCE", tableName: table)
            }
            
            Section {
                NavigationLink("TEXT_SIZE".localize(table: table)) {}
                Toggle("BOLD_TEXT".localize(table: table), isOn: $boldTextEnabled)
            }
            
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
            
            Section {
                CustomNavigationLink(title: "BLUE_LIGHT_REDUCTION".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
            }
            
            Section {
                CustomNavigationLink(title: "AUTOLOCK".localize(table: table), status: "1 minute", destination: EmptyView())
                Toggle("RAISE_TO_WAKE".localize(table: table), isOn: $raiseToWakeEnabled)
            }
            
            if UIDevice.AlwaysOnDisplayCapability {
                Section {
                    CustomNavigationLink(title: "ALWAYS_ON_DISPLAY".localize(table: table), status: "ALWAYS_ON_ENABLED".localize(table: table), destination: EmptyView())
                } footer: {
                    Text("ALWAYS_ON_DESCRIPTION", tableName: table)
                }
            }
            
            Section {
                CustomNavigationLink(title: "VIEW".localize(table: table), status: "DEFAULT".localize(table: "Accessibility"), destination: EmptyView())
            } header: {
                Text("DISPLAY_ONLY_TITLE", tableName: "Accessibility")
            } footer: {
                Text("DEFAULT_DISPLAY_ZOOMED_STANDARD_DESCRIPTION", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DisplayBrightnessView()
    }
}
