//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    var body: some View {
        CustomList(title: "Accessibility") {
            Section(content: {
                if Device().isTablet {
                    SettingsLink(color: .blue, icon: "character.magnify", larger: false, id: "Hover Text", status: "Off", content: {
                        HoverTextView()
                    })
                }
                SettingsLink(color: .blue, icon: "textformat.size", larger: false, id: "Display & Text Size", content: {
                    DisplayTextSizeView()
                })
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", larger: false, id: "Motion", content: {
                    MotionView()
                })
                SettingsLink(icon: "Speech29x29", id: "Spoken Content", content: {
                    SpeakSelectionView()
                })
            }, header: {
                Text("Vision")
            })
            
            Section(content: {
                SettingsLink(color: .blue, icon: "hand.point.up.left.fill", id: "Touch", content: {
                    TouchView()
                })
                if Device().hasFaceAuth {
                    SettingsLink(color: .green, icon: "faceid", id: "Face ID & Attention", content: {
                        FaceAttentionView()
                    })
                }
                if Device().isPhone {
                    SettingsLink(icon: "ControlNearby29x29", id: "Control Nearby Devices", content: {
                        ControlNearbyDevicesView()
                    })
                }
                SettingsLink(color: .gray, icon: "keyboard", larger: false, id: "Keyboards", content: {
                    AccessibilityKeyboardsView()
                })
            }, header: {
                Text("Physical and Motor")
            })
            
            Section(content: {
                SettingsLink(color: .blue, icon: "captions.bubble.fill", larger: false, id: "Subtitles & Captioning", content: {
                    SubtitlesCaptioningView()
                })
            }, header: {
                Text("Hearing")
            })
            
            Section(content: {
                SettingsLink(icon: "LiveSpeech29x29", id: "Live Speech", status: "Off", content: {
                    LiveSpeechView()
                })
            }, header: {
                Text("Speech")
            })
            
            Section(content: {
                // Empty
            }, header: {
                Text("General")
            })
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
