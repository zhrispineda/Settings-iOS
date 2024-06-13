//
//  DisplayBrightnessView.swift
//  Preferences
//
//  Settings > Display & Brightness
//

import SwiftUI

struct DisplayBrightnessView: View {
    // Variables
    @State private var automaticEnabled = false
    @State private var boldTextEnabled = false
    @State private var brightness = 0.5
    @State private var trueToneEnabled = true
    @State private var raiseToWakeEnabled = true
    
    var body: some View {
        CustomList(title: "Display & Brightness") {
            Section(content: {
                // TODO: Light & Dark options
                Toggle("Automatic", isOn: $automaticEnabled.animation())
                if automaticEnabled {
                    CustomNavigationLink(title: "Options", status: "Light Until Sunset", destination: EmptyView())
                }
            }, header: {
                Text("\n\nAppearance")
            })
            
            Section(content: {
                NavigationLink("Text Size", destination: {})
                Toggle("Bold Text", isOn: $boldTextEnabled)
            })
            
            Section(content: {
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
            }, header: {
                Text("Brightness")
            }, footer: {
                Text("Automatically adapt \(UIDevice().localizedModel) display based on ambient lighting conditions to make colors appear consistent in different environments.")
            })
            
            Section {
                CustomNavigationLink(title: "Night Shift", status: "Off", destination: EmptyView())
            }
            
            Section {
                CustomNavigationLink(title: "Auto-Lock", status: "1 minute", destination: EmptyView())
                Toggle("Raise to Wake", isOn: $raiseToWakeEnabled)
            }
            
            if Device().hasAlwaysOnDisplay {
                Section(content: {
                    CustomNavigationLink(title: "Always On Display", status: "On", destination: EmptyView())
                }, footer: {
                    Text("Always On Display dims the Lock Screen while keeping information like time, widgets, and notifications visible using minimal power.")
                })
            }
            
            Section(content: {
                CustomNavigationLink(title: "Display Zoom", status: "Default", destination: EmptyView())
            }, header: {
                Text("Display")
            }, footer: {
                Text("Choose a view for \(UIDevice().localizedModel). Larger Text shows larger controls. Default shows more content.")
            })
        }
    }
}

#Preview {
    NavigationStack {
        DisplayBrightnessView()
    }
}
