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
                // TODO: Hover Text (iPad)
                SettingsLink(color: .blue, icon: "textformat.size", larger: false, id: "Display & Text Size", content: {
                    DisplayTextSizeView()
                })
                SettingsLink(color: .green, icon: "circle.dotted.and.circle", larger: false, id: "Motion", content: {
                    MotionView()
                })
                SettingsLink(color: Color(UIColor.systemGray3), icon: "rectangle.3.group.bubble.fill", larger: false, id: "Spoken Content", content: {
                    SpeakSelectionView()
                })
            }, header: {
                Text("Vision")
            })
            
            Section(content: {
                SettingsLink(color: .blue, icon: "hand.point.up.left.fill", id: "Touch", content: {
                    TouchView()
                })
                // TODO: Face ID & Attention
                if DeviceInfo().isPhone {
                    SettingsLink(color: .blue, icon: "dot.radiowaves.up.forward", id: "Control Nearby Devices", content: {
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
                SettingsLink(color: Color(UIColor.systemGray3), icon: "keyboard", larger: false, id: "Live Speech", content: {
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
