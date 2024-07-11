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
    @State private var brightness = 0.5
    @State private var trueToneEnabled = true
    @State private var raiseToWakeEnabled = true
    
    var body: some View {
        CustomList(title: "Display & Brightness") {
            Section {
                HStack {
                    Text("") // For listRowSeparator
                    Spacer()
                    Button {
                        appearance = .light
                    } label: {
                        VStack(spacing: 15) {
                            ZStack {
                                Image("\(Device().model.lowercased())-appearance-light")
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
                            Text("Light")
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
                                Image("\(Device().model.lowercased())-appearance-dark")
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
                            Text("Dark")
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
                
                Toggle("Automatic", isOn: $automaticEnabled.animation())
                
                if automaticEnabled {
                    CustomNavigationLink(title: "Options", status: "Light Until Sunset", destination: EmptyView())
                }
            } header: {
                Text("\nAppearance")
            }
            
            Section {
                NavigationLink("Text Size") {}
                Toggle("Bold Text", isOn: $boldTextEnabled)
            }
            
            Section {
                Group {
                    Slider(value: $brightness,
                           in: 0.0...1.0,
                           minimumValueLabel: Image(systemName: "sun.min.fill"),
                           maximumValueLabel: Image(systemName: "sun.max.fill"),
                           label: { Text("Volume")  }
                    )
                }
                .foregroundStyle(.secondary)
                .imageScale(.large)
                .onChange(of: brightness) {
                    UIScreen.main.brightness = brightness
                }
                
                Toggle("True Tone", isOn: $trueToneEnabled)
            } header: {
                Text("Brightness")
            } footer: {
                Text("Automatically adapt \(Device().model) display based on ambient lighting conditions to make colors appear consistent in different environments.")
            }
            
            Section {
                CustomNavigationLink(title: "Night Shift", status: "Off", destination: EmptyView())
            }
            
            Section {
                CustomNavigationLink(title: "Auto-Lock", status: "1 minute", destination: EmptyView())
                Toggle("Raise to Wake", isOn: $raiseToWakeEnabled)
            }
            
            if Device().hasAlwaysOnDisplay {
                Section {
                    CustomNavigationLink(title: "Always On Display", status: "On", destination: EmptyView())
                } footer: {
                    Text("Always On Display dims the Lock Screen while keeping information like time, widgets, and notifications visible using minimal power.")
                }
            }
            
            Section {
                CustomNavigationLink(title: "Display Zoom", status: "Default", destination: EmptyView())
            } header: {
                Text("Display")
            } footer: {
                Text("Choose a view for \(Device().model). Larger Text shows larger controls. Default shows more content.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DisplayBrightnessView()
    }
}
