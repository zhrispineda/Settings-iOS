//
//  MultitaskingGesturesView.swift
//  Preferences
//
//  Settings > Multitasking & Gestures
//

import SwiftUI

enum MultitaskOption: String, CaseIterable {
    case off
    case splitViewSlideOver
    case stageManager
}

struct MultitaskingGesturesView: View {
    // Variables
    @AppStorage("MultitaskingModeOption") private var multitaskingMode: MultitaskOption = .splitViewSlideOver
    @AppStorage("MultitaskingRecentAppsToggle") private var recentAppsEnabled = true
    @AppStorage("MultitaskingDockToggle") private var dockEnabled = true
    @AppStorage("MultitaskingPIPToggle") private var startPIPAutomaticallyEnabled = true
    @AppStorage("MultitaskingProdGesturesToggle") private var productivityGesturesEnabled = true
    @AppStorage("MultitaskingFingerGesturesToggle") private var fourFiveFingerGesturesEnabled = true
    @AppStorage("ShakeUndoToggle") private var shakeUndoEnabled = true
    @AppStorage("SwipeCornerToggle") private var swipeFingerCornerEnabled = false
    @AppStorage("SwipeCornerLeftOption") private var bottomLeftCornerGesture = "Quick Note"
    @AppStorage("SwipeCornerRightOption") private var bottomRightCornerGesture = "Screenshot"
    let gestures = ["Off", "Quick Note", "Screenshot"]
    let table = "MultitaskingAndGesturesSettings"
    
    var body: some View {
        CustomList(title: "Multitasking & Gestures".localize(table: table)) {
            // MARK: Multitasking
            Section {
                HStack {
                    Spacer()
                    MultitaskingOption(mode: $multitaskingMode, value: .off, image: "OneAppAtATime", option: "Off")
                    Spacer()
                    MultitaskingOption(mode: $multitaskingMode, value: .splitViewSlideOver, image: "SplitViewSlideOver", option: "Split View & Slide Over")
                    Spacer()
                    if UIDevice.DeviceSupportsEnhancedMultitasking {
                        MultitaskingOption(mode: $multitaskingMode, value: .stageManager, image: "iPad_Messages_Safari_StageManager", option: "Stage Manager")
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
                if multitaskingMode == .stageManager {
                    Toggle(isOn: $recentAppsEnabled) {
                        Text("Recent Apps", tableName: table)
                    }
                    Toggle(isOn: $dockEnabled) {
                        Text("Dock", tableName: table)
                    }
                }
            } header: {
                Text("Multitasking", tableName: table)
            } footer: {
                switch multitaskingMode {
                case .off:
                    if UIDevice.DeviceSupportsEnhancedMultitasking {
                        Text("You can use multitasking to work with more than one app at the same time. Turn on multitasking by choosing either Split View & Slide Over or Stage Manager.", tableName: table)
                    } else {
                        Text("You can use multitasking to work with more than one app at the same time. Turn on multitasking by choosing Split View & Slide Over.", tableName: table)
                    }
                case .splitViewSlideOver:
                    Text("In Split View, two apps appear side-by-side, and you can resize apps by dragging the slider that appears between them. In Slide Over, one app appears in a smaller floating window that you can drag to the left or right side of your screen.", tableName: table) + Text(" [\("Learn more...".localize(table: table))](https://support.apple.com/en-us/102576)")
                case .stageManager:
                    Text("Use Stage Manager to multitask with ease. You can group, resize, and arrange windows in your ideal layout then tap to switch between apps. If your iPad is connected to an external display, you can use Stage Manager to move windows between iPad and your external display.", tableName: table) + Text(" [\("Learn more…".localize(table: table))](https://support.apple.com/guide/ipad/move-resize-and-organize-windows-ipad1240f36f/ipados)")
                }
            }
            
            // MARK: Picture in Picture
            Section {
                Toggle(isOn: $startPIPAutomaticallyEnabled) {
                    Text("Start PiP Automatically", tableName: table)
                }
            } header: {
                Text("Picture in Picture", tableName: table)
            } footer: {
                Text("When you swipe up to go Home or use other apps, videos and FaceTime calls will automatically continue in Picture in Picture.", tableName: table)
            }
            
            // MARK: Gestures
            Section {
                Toggle(isOn: $productivityGesturesEnabled) {
                    Text("Productivity Gestures", tableName: table)
                }
            } header: {
                Text("Gestures", tableName: table)
            } footer: {
                Text("""
                     - Double-tap with three fingers to undo.
                     - Pinch and spread with three fingers to copy and paste.
                     - Swipe left with three fingers to undo and swipe right to redo.
                     """, tableName: table)
            }
            
            // MARK: Four & Five Finger Gestures
            Section {
                Toggle(isOn: $fourFiveFingerGesturesEnabled) {
                    Text("Four & Five Finger Gestures", tableName: table)
                }
            } footer: {
                Text("""
                     - Switch apps by swiping left and right with four or five fingers.
                     - Go home by pinching with four or five fingers.
                     - Open the App Switcher by pinching and pausing with four or five fingers.
                     """, tableName: table)
            }
            
            // MARK: Shake to Undo
            Section {
                Toggle(isOn: $shakeUndoEnabled) {
                    Text("Shake to Undo", tableName: table)
                }
            } footer: {
                Text("Shake to Undo Footer", tableName: table)
            }
            
            // MARK: Swipe Finger from Corner
            Section {
                Toggle(isOn: $swipeFingerCornerEnabled) {
                    Text("Swipe Finger from Corner", tableName: table)
                }
                
                if swipeFingerCornerEnabled {
                    HStack {
                        Text("Bottom Left Corner", tableName: table)
                        Spacer()
                        Picker("", selection: $bottomLeftCornerGesture) {
                            ForEach(gestures, id: \.self) {
                                Text(LocalizedStringKey($0.description), tableName: table).tag($0)
                            }
                        }
                    }
                    HStack {
                        Text("Bottom Right Corner", tableName: table)
                        Spacer()
                        Picker("", selection: $bottomRightCornerGesture) {
                            ForEach(gestures, id: \.self) {
                                Text(LocalizedStringKey($0.description), tableName: table).tag($0)
                            }
                        }
                    }
                }
            } footer: {
                Text("Select the action that occurs when you swipe diagonally from the bottom corner.", tableName: table)
            }
            .listRowSeparator(.hidden)
        }
    }
}

// MARK: MultitaskingOption struct
struct MultitaskingOption: View {
    @Binding var mode: MultitaskOption
    var value: MultitaskOption
    var image: String
    var option: String
    let table = "MultitaskingAndGesturesSettings"
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                mode = value
            } label: {
                VStack(spacing: 10) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5.0)
                                .stroke(.gray, lineWidth: 0.5)
                                .frame(height: 80)
                        )
                    Text(LocalizedStringKey(option), tableName: table)
                        .frame(minWidth: 140)
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                    Image(systemName: mode == value ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(mode == value ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                        .font(.title3)
                        .fontWeight(.light)
                }
                .padding(.top)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        MultitaskingGesturesView()
    }
}
