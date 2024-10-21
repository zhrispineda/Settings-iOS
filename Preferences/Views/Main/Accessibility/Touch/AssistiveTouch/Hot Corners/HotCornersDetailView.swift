//
//  HotCornersDetailView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Hot Corners > [Option]
//

import SwiftUI

struct HotCornersDetailView: View {
    // Variables
    var title = String()
    @State private var selected = String()
    let systemOptions = ["NONE", "OPEN_MENU", "ACTION_BUTTON_FULL_WIDTH", "SYSDIAGNOSE_FULL_WIDTH", "APP_SWITCHER", "CAMERA", "CAMERA_BUTTON_FULL_WIDTH", "CAMERA_BUTTON_DOUBLE_LIGHT_PRESS_FULL_WIDTH", "CAMERA_BUTTON_LIGHT_PRESS_FULL_WIDTH", "CONTROL_CENTER_FULL_WIDTH", "DOUBLE_TAP_FULL_WIDTH", "CAMERA_FRONT", "HOLD_AND_DRAG", "HOME_FULL_WIDTH", "ORIENTATION_LOCKED_FULL_WIDTH", "LOCK_FULL_WIDTH", "LONG_PRESS", "MOVE_MENU", "NOTIFICATION_CENTER_FULL_WIDTH", "PINCH", "PINCH_ROTATE", "REACHABILITY", "REBOOT_DEVICE_FULL_WIDTH", "FREEHAND_ROTATE_ONE_LINE", "SCREENSHOT_FULL_WIDTH", "SHAKE", "SIRI", "SOS_FULL_WIDTH", "SPOTLIGHT", "TYPE_TO_SIRI_FULL_WIDTH", "VOLUME_DOWN_ASSISTIVE_TOUCH_FULL_WIDTH", "VOLUME_UP_ASSISTIVE_TOUCH_FULL_WIDTH", "APPLE_PAY_FULL_WIDTH"]
    let accessibilityOptions = ["TRIPLE_CLICK_FULL_WIDTH", "REMOTE_SCREEN_FULL_WIDTH", "BACKGROUND_SOUNDS_FULL_WIDTH", "CAMERA_BUTTON_FULL_WIDTH", "CAMERA_BUTTON_DOUBLE_LIGHT_PRESS_FULL_WIDTH", "CAMERA_BUTTON_LIGHT_PRESS_FULL_WIDTH", "NEARBY_DEVICE_CONTROL_FULL_WIDTH", "DIM_FLASHING_LIGHTS_FULL_WIDTH", "HOVERTEXT_TYPING_FULL_WIDTH", "LIVE_TRANSCRIPTIONS_FULL_WIDTH", "DETECTION_MODE_FULL_WIDTH", "LIVE_SPEECH_FULL_WIDTH", "HAPTIC_MUSIC_FULL_WIDTH", "SPEAK_SCREEN", "MOTION_CUES_FULL_WIDTH"]
    let scrollGestures = ["SCROLL_CONTINUOUS_HORIZONTAL_FULL_WIDTH", "SCROLL_CONTINUOUS_VERTICAL_FULL_WIDTH", "Scroll-Down", "Scroll-Left", "Scroll-Right", "SCROLL_TO_BOTTOM_FULL_WIDTH", "SCROLL_TO_TOP_FULL_WIDTH", "Scroll-Up"]
    let assistiveTouchOptions = ["CALIBRATE_ON_DEVICE_EYE_TRACKING_FULL_WIDTH", "ZOOM_SCREEN_ON_DEVICE_EYE_TRACKING_FULL_WIDTH"]
    let dwellControls = ["DWELL_LOCK_TOGGLE", "MOVE_MENU", "TAP", "DWELL_PAUSE_TOGGLE_FULL_WIDTH"]
    let table = "LocalizedStrings"
    let handTable = "HandSettings"
    let stacTable = "LocalizedStrings-Staccato"
    let camTable = "LocalizedStrings-D94"
    let detectTable = "LocalizedStrings-DetectionMode"
    
    var body: some View {
        CustomList(title: title, topPadding: true) {
            Group {
                Picker("SystemHeading".localize(table: handTable), selection: $selected) {
                    ForEach(systemOptions, id: \.self) { option in
                        if option.localize(table: table) != option {
                            Text(option.localize(table: table))
                        } else if option.localize(table: handTable) != option {
                            Text(option.localize(table: handTable))
                        } else if option.localize(table: stacTable) != option {
                            Text(option.localize(table: stacTable))
                        } else if option.localize(table: camTable) != option && UIDevice.AdvancedPhotographicStylesCapability {
                            Text(option.localize(table: camTable))
                        }
                    }
                }
                
                Picker("Accessibility".localize(table: handTable), selection: $selected) {
                    ForEach(accessibilityOptions, id: \.self) { option in
                        if option.localize(table: table) != option {
                            Text(option.localize(table: table))
                        } else if option.localize(table: camTable) != option && UIDevice.AdvancedPhotographicStylesCapability {
                            Text(option.localize(table: camTable))
                        } else if option.localize(table: detectTable) != option {
                            Text(option.localize(table: detectTable))
                        }
                    }
                }
                
                Picker("ScrollHeading".localize(table: handTable), selection: $selected) {
                    ForEach(scrollGestures, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                
                Picker("AssistiveTouch".localize(table: handTable), selection: $selected) {
                    ForEach(assistiveTouchOptions, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                
                Picker("DwellHeading".localize(table: handTable), selection: $selected) {
                    ForEach(dwellControls, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        HotCornersDetailView(title: "Option")
    }
}
