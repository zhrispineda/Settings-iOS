//
//  MultitaskingGesturesView.swift
//  Preferences
//
//  Settings > Multitasking & Gestures
//

import SwiftUI

struct MultitaskingGesturesView: View {
    // Variables
    @State private var multitaskingMode = 1
    @State private var recentAppsEnabled = true
    @State private var dockEnabled = true
    @State private var startPipAutomaticallyEnabled = true
    @State private var productivityGesturesEnabled = true
    @State private var fourFiveFingerGesturesEnabled = true
    @State private var shakeUndoEnabled = true
    @State private var swipeFingerCornerEnabled = false
    @State private var bottomLeftCornerGesture = "Quick Note"
    @State private var bottomRightCornerGesture = "Screenshot"
    let gestures = ["Off", "Quick Note", "Screenshot"]
    let table = "MultitaskingAndGesturesSettings"
    
    var body: some View {
        CustomList(title: "Multitasking & Gestures".localize(table: table)) {
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        Button {
                            multitaskingMode = 0
                        } label: {
                            VStack(spacing: 15) {
                                Image("OneAppAtATime")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 125)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .padding(.top)
                                Text("Off", tableName: table)
                                    .font(.subheadline)
                                Image(systemName: multitaskingMode == 0 ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(multitaskingMode == 0 ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                    VStack(spacing: 15) {
                        Button {
                            multitaskingMode = 1
                        } label: {
                            VStack(spacing: 15) {
                                Image("SplitViewSlideOver")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 125)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .padding(.top)
                                Text("Split View & Slide Over", tableName: table)
                                    .font(.subheadline)
                                Image(systemName: multitaskingMode == 1 ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(multitaskingMode == 1 ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                    .font(.title)
                                    .fontWeight(.light)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                    if UIDevice.DeviceSupportsEnhancedMultitasking {
                        VStack(spacing: 15) {
                            Button {
                                multitaskingMode = 2
                            } label: {
                                VStack(spacing: 15) {
                                    Image("iPad_Messages_Safari_StageManager")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 125)
                                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                        .padding(.top)
                                    Text("Stage Manager", tableName: table)
                                        .font(.subheadline)
                                    Image(systemName: multitaskingMode == 2 ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(multitaskingMode == 2 ? Color(UIColor.systemBackground) : Color(UIColor.tertiaryLabel), .blue)
                                        .font(.title)
                                        .fontWeight(.light)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)
                if multitaskingMode == 2 {
                    Toggle("Recent Apps".localize(table: table), isOn: $recentAppsEnabled)
                    Toggle("Dock".localize(table: table), isOn: $dockEnabled)
                }
            } header: {
                Text("Multitasking", tableName: table)
            } footer: {
                switch multitaskingMode {
                case 1:
                    Text("In Split View, two apps appear side-by-side, and you can resize apps by dragging the slider that appears between them. In Slide Over, one app appears in a smaller floating window that you can drag to the left or right side of your screen.", tableName: table) + Text(" [\("Learn more...".localize(table: table))](https://support.apple.com/en-us/102576)")
                case 2:
                    Text("Use Stage Manager to multitask with ease. You can group, resize, and arrange windows in your ideal layout then tap to switch between apps. If your iPad is connected to an external display, you can use Stage Manager to move windows between iPad and your external display.") + Text(" [\("Learn more...".localize(table: table))](https://support.apple.com/guide/ipad/move-resize-and-organize-windows-ipad1240f36f/ipados)")
                default:
                    if UIDevice.DeviceSupportsEnhancedMultitasking {
                        Text("You can use multitasking to work with more than one app at the same time. Turn on multitasking by choosing either Split View & Slide Over or Stage Manager.", tableName: table)
                    } else {
                        Text("You can use multitasking to work with more than one app at the same time. Turn on multitasking by choosing Split View & Slide Over.", tableName: table)
                    }
                }
            }
            
            Section {
                Toggle("Start PiP Automatically".localize(table: table), isOn: $startPipAutomaticallyEnabled)
            } header: {
                Text("Picture in Picture", tableName: table)
            } footer: {
                Text("When you swipe up to go Home or use other apps, videos and FaceTime calls will automatically continue in Picture in Picture.", tableName: table)
            }
            
            Section {
                Toggle("Productivity Gestures".localize(table: table), isOn: $productivityGesturesEnabled)
            } header: {
                Text("Gestures", tableName: table)
            } footer: {
                Text("""
                     - Double-tap with three fingers to undo.
                     - Pinch and spread with three fingers to copy and paste.
                     - Swipe left with three fingers to undo and swipe right to redo.
                     """, tableName: table)
            }
            
            Section {
                Toggle("Four & Five Finger Gestures".localize(table: table), isOn: $fourFiveFingerGesturesEnabled)
            } footer: {
                Text("""
                     - Switch apps by swiping left and right with four or five fingers.
                     - Go home by pinching with four or five fingers.
                     - Open the App Switcher by pinching and pausing with four or five fingers.
                     """, tableName: table)
            }
            
            Section {
                Toggle("Shake to Undo".localize(table: table), isOn: $shakeUndoEnabled)
            } footer: {
                Text("Shake to Undo Footer", tableName: table)
            }
            
            Section {
                Toggle("Swipe Finger from Corner".localize(table: table), isOn: $swipeFingerCornerEnabled)
                if swipeFingerCornerEnabled {
                    HStack {
                        Text("Bottom Left Corner", tableName: table)
                        Spacer()
                        Picker("", selection: $bottomLeftCornerGesture) {
                            ForEach(gestures, id: \.self) {
                                Text($0.description).tag($0)
                            }
                        }
                    }
                    HStack {
                        Text("Bottom Right Corner", tableName: table)
                        Spacer()
                        Picker("", selection: $bottomRightCornerGesture) {
                            ForEach(gestures, id: \.self) {
                                Text($0.description).tag($0)
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

#Preview {
    MultitaskingGesturesView()
}
