//
//  KeyboardView.swift
//  Preferences
//
//  Settings > General > Keyboard
//

import SwiftUI

struct KeyboardView: View {
    // Variables
    @State private var autoCapitalizationEnabled = true
    @State private var autoCorrectionEnabled = true
    @State private var predictiveTextEnabled = true
    @State private var showPredictionsInlineEnabled = true
    @State private var checkSpellingEnabled = true
    @State private var capsLockEnabled = true
    @State private var shortcutsEnabled = true
    @State private var smartPunctuationEnabled = true
    @State private var keyFlicksEnabled = true
    @State private var slideTypeEnabled = true
    @State private var deleteSlideTypeWordEnabled = true
    @State private var characterPreviewEnabled = true
    @State private var periodShortcutEnabled = true
    
    @State private var dictationEnabled = true
    @State private var showingDictationEnableAlert = false
    @State private var showingDictationEnablePopup = false
    @State private var showingDictationDisableAlert = false
    @State private var showingDictationDisablePopup = false
    @State private var autoPunctuationEnabled = true
    
    @State private var stickersEnabled = true
    
    var body: some View {
        CustomList(title: "Keyboards") {
            Section {
                NavigationLink(destination: {}, label: {
                    HRowLabels(title: "Keyboards", subtitle: "2")
                })
                NavigationLink("Hardware Keyboard", destination: {})
            }
            
            Section {
                NavigationLink("Text Replacement", destination: {})
                if DeviceInfo().isPhone {
                    NavigationLink(destination: {}, label: {
                        HRowLabels(title: "One-Handed Keyboard", subtitle: "Off")
                    })
                }
            }
            
            Section(content: {
                Toggle("Auto-Capitalization", isOn: $autoCapitalizationEnabled)
                Toggle("Auto-Correction", isOn: $autoCorrectionEnabled)
                Toggle("Predictive Text", isOn: $predictiveTextEnabled.animation())
                if predictiveTextEnabled {
                    Toggle("Show Predictions Inline", isOn: $showPredictionsInlineEnabled)
                }
                Toggle("Check Spelling", isOn: $checkSpellingEnabled)
                Toggle("Enable Caps Lock", isOn: $capsLockEnabled)
                if DeviceInfo().isTablet {
                    Toggle("Shortcuts", isOn: $shortcutsEnabled)
                }
                Toggle("Smart Punctuation", isOn: $smartPunctuationEnabled)
                if DeviceInfo().isTablet {
                    Toggle("Enable Key Flicks", isOn: $keyFlicksEnabled)
                }
                Toggle("Slide \(DeviceInfo().isPhone ? "" : "on Floating Keyboard ")to Type", isOn: $slideTypeEnabled.animation())
                if slideTypeEnabled {
                    Toggle("Delete Slide-to-Type by Word", isOn: $deleteSlideTypeWordEnabled)
                }
                if DeviceInfo().isPhone {
                    Toggle("Character Preview", isOn: $characterPreviewEnabled)
                }
                Toggle("\u{201C}.\u{201D} Shortcut", isOn: $periodShortcutEnabled)
            }, header: {
                Text("All Keyboards")
            }, footer: {
                Text("Double tapping the space bar will insert a period followed by a space.")
            })
            
            Section(content: {
                Toggle("Enable Dictation", isOn: $dictationEnabled)
                    .alert("Enable Dictation?", isPresented: $showingDictationEnableAlert,
                           actions: {
                        Button("Enable Dictation", role: .none) {}
                        Button("Cancel", role: .cancel) {}
                    }, message: {
                        Text("Dictation sends information like your voice input, contacts, and location to Apple when necessary for processing your requests.")
                    })
                    .alert("Turn Off Dictation?", isPresented: $showingDictationDisableAlert,
                           actions: {
                        Button("Turn Off Dictation", role: .none) {}
                        Button("Cancel", role: .cancel) {  }
                    }, message: {
                        Text("The information Dictation uses to respond to your requests is also used for Siri and will remain on Apple servers unless Siri is also turned off.")
                    })
                    .confirmationDialog("Dictation sends information like your voice input, contacts, and location to Apple when necessary for processing your requests.", isPresented: $showingDictationEnablePopup,
                                        titleVisibility: .visible,
                                        actions: {
                        Button("Enable Dictation", role: .none) {}
                        Button("Cancel", role: .cancel) {}
                    })
                    .confirmationDialog("The information Dictation uses to respond to your requests is also used for Siri and will remain on Apple servers unless Siri is also turned off.", isPresented: $showingDictationDisablePopup,
                                        titleVisibility: .visible,
                                        actions: {
                        Button("Turn Off Dictation", role: .none) {}
                        Button("Cancel", role: .cancel) {}
                    })
                Toggle("Auto-Punctuation", isOn: $autoPunctuationEnabled)
                if dictationEnabled {
                    NavigationLink(destination: {}, label: {
                        HStack {
                            Text("Dictation Shortcut")
                            Spacer()
                            Label("Control", systemImage: "control").foregroundStyle(.secondary)
                        }
                    })
                }
            }, header: {
                Text("Dictation")
            }, footer: {
                VStack(alignment: .leading) {
                    Text("\(dictationEnabled ? "Dictation sends information to Apple when necessary for processing your requests. " : "")[About Dictation & Privacy...](#)")
                    if dictationEnabled {
                        Text("\nSupport for processing voice input on \(UIDevice().localizedModel) is downloading...")
                    }
                }
            })
            .onChange(of: dictationEnabled, {
                dictationEnabled ? (DeviceInfo().isPhone ? showingDictationEnablePopup.toggle() : showingDictationEnableAlert.toggle()) : (DeviceInfo().isPhone ? showingDictationDisablePopup.toggle() : showingDictationDisableAlert.toggle())
            })
            
            Section(content: {
                Toggle("Stickers", isOn: $stickersEnabled)
            }, header: {
                Text("Stickers")
            }, footer: {
                Text("Send stickers from the Emoji keyboard.")
            })
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardView()
    }
}
