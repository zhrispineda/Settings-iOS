//
//  KeyboardCommandsView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Full Keyboard Access > Commands
//

import SwiftUI

struct CommandShortcut: Identifiable {
    var id: String { name }
    let name: String
    let shortcut: String
}

struct KeyboardCommandsView: View {
    // Variables
    @State private var showingRestoreDefaultsDialog = false
    @State private var showingRestoreDefaultsAlert = false
    @State private var showingKeyboardShortcutAlert = false
    @State private var basicShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "COMMAND_Help", shortcut: "Tab H"),
        CommandShortcut(name: "COMMAND_GoToNextElement", shortcut: "Tab"),
        CommandShortcut(name: "COMMAND_GoToPreviousElement", shortcut: "\u{21E7} Tab"),
        CommandShortcut(name: "COMMAND_MoveUp", shortcut: "\u{2191}"),
        CommandShortcut(name: "COMMAND_MoveDown", shortcut: "\u{2193}"),
        CommandShortcut(name: "COMMAND_MoveLeft", shortcut: "\u{2190}"),
        CommandShortcut(name: "COMMAND_MoveRight", shortcut: "\u{2192}"),
        CommandShortcut(name: "COMMAND_PerformDefaultAction", shortcut: "Space"),
        CommandShortcut(name: "COMMAND_GoHome", shortcut: "Fn H")
    ]
    @State private var movementShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "COMMAND_GoToNextElement", shortcut: "Tab"),
        CommandShortcut(name: "COMMAND_GoToPreviousElement", shortcut: "\u{21E7} Tab"),
        CommandShortcut(name: "COMMAND_MoveUp", shortcut: "\u{2191}"),
        CommandShortcut(name: "COMMAND_MoveDown", shortcut: "\u{2193}"),
        CommandShortcut(name: "COMMAND_MoveLeft", shortcut: "\u{2190}"),
        CommandShortcut(name: "COMMAND_MoveRight", shortcut: "\u{2192}"),
        CommandShortcut(name: "COMMAND_GoToFirstElement", shortcut: "Tab \u{2190}"),
        CommandShortcut(name: "COMMAND_GoToLastElement", shortcut: "Tab \u{2192}"),
        CommandShortcut(name: "COMMAND_MoveInsideNext", shortcut: "\u{005E} Tab"),
        CommandShortcut(name: "COMMAND_MoveInsidePrevious", shortcut: "\u{005E} \u{21E7} Tab"),
        CommandShortcut(name: "COMMAND_ActivateTypeahead", shortcut: "Tab F")
    ]
    @State private var interactionShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "COMMAND_PerformDefaultAction", shortcut: "Space"),
        CommandShortcut(name: "COMMAND_PerformEscape", shortcut: "Tab B"),
        CommandShortcut(name: "COMMAND_OpenContextualMenu", shortcut: "Tab M"),
        CommandShortcut(name: "COMMAND_ShowAccessibilityActions", shortcut: "Tab Z")
    ]
    @State private var deviceShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "COMMAND_GoHome", shortcut: "Fn H"),
        CommandShortcut(name: "COMMAND_ToggleControlCenter", shortcut: "Fn C"),
        CommandShortcut(name: "COMMAND_ToggleNotificationCenter", shortcut: "Fn N"),
        CommandShortcut(name: "COMMAND_RebootDevice", shortcut: "\u{005E} \u{2325} \u{21E7} \u{2318} R"),
        CommandShortcut(name: "COMMAND_ActivateSiri", shortcut: "Fn S"),
        CommandShortcut(name: "COMMAND_ActivateAccessibilityShortcut", shortcut: "Tab X"),
        CommandShortcut(name: "COMMAND_PerformSysdiagnose", shortcut: "\u{005E} \u{2325} \u{21E7} \u{2318} \u{002E}"),
        CommandShortcut(name: "COMMAND_TogglePassthroughMode", shortcut: "\u{005E} \u{2325} \u{2318} P")
    ]
    @State private var gestureShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "COMMAND_Gestures", shortcut: "Tab G"),
        CommandShortcut(name: "COMMAND_PressAndLift", shortcut: ""),
        CommandShortcut(name: "COMMAND_SwipeUp", shortcut: ""),
        CommandShortcut(name: "COMMAND_SwipeDown", shortcut: ""),
        CommandShortcut(name: "COMMAND_SwipeLeft", shortcut: ""),
        CommandShortcut(name: "COMMAND_SwipeRight", shortcut: ""),
        CommandShortcut(name: "COMMAND_PinchIn", shortcut: ""),
        CommandShortcut(name: "COMMAND_PinchOut", shortcut: ""),
        CommandShortcut(name: "COMMAND_RotateLeft", shortcut: ""),
        CommandShortcut(name: "COMMAND_RotateRight", shortcut: ""),
        CommandShortcut(name: "COMMAND_TwoFingerPressAndLift", shortcut: ""),
        CommandShortcut(name: "COMMAND_TwoFingerSwipeDown", shortcut: ""),
        CommandShortcut(name: "COMMAND_TwoFingerSwipeLeft", shortcut: ""),
        CommandShortcut(name: "COMMAND_TwoFingerSwipeRight", shortcut: ""),
        CommandShortcut(name: "COMMAND_TwoFingerSwipeUp", shortcut: "")
    ]
    let table = "FullKeyboardAccess"
    let accTable = "Accessibility"
    let keyTable = "FullKeyboardAccessSettings"
    
    var body: some View {
        CustomList(title: "Commands") {
            Section {} footer: {
                Text("Tap any command to customize its keyboard shortcut.")
            }
            
            Section {
                ForEach($basicShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name.localize(table: table), status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("KEYBOARD_SHORTCUT".localize(table: accTable), isPresented: $showingKeyboardShortcutAlert) {
                        Button("DONE".localize(table: table)) {}.disabled(true)
                        Button("CANCEL".localize(table: table), role: .cancel) {}
                    } message: {
                        Text("KEYBOARD_SHORTCUT_INSTRUCTIONS", tableName: accTable)
                    }
                }
            } header: {
                Text("BASIC", tableName: table)
            }
            
            Section {
                ForEach($movementShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name.localize(table: table), status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("KEYBOARD_SHORTCUT".localize(table: accTable), isPresented: $showingKeyboardShortcutAlert) {
                        Button("DONE".localize(table: table)) {}.disabled(true)
                        Button("CANCEL".localize(table: table), role: .cancel) {}
                    } message: {
                        Text("KEYBOARD_SHORTCUT_INSTRUCTIONS", tableName: accTable)
                    }
                }
            } header: {
                Text("MOVEMENT", tableName: table)
            }
            
            Section {
                ForEach($interactionShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name.localize(table: table), status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("KEYBOARD_SHORTCUT".localize(table: accTable), isPresented: $showingKeyboardShortcutAlert) {
                        Button("DONE".localize(table: table)) {}.disabled(true)
                        Button("CANCEL".localize(table: table), role: .cancel) {}
                    } message: {
                        Text("KEYBOARD_SHORTCUT_INSTRUCTIONS", tableName: accTable)
                    }
                }
            } header: {
                Text("INTERACTION", tableName: table)
            }
            
            Section {
                ForEach($deviceShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name.localize(table: table), status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("KEYBOARD_SHORTCUT".localize(table: accTable), isPresented: $showingKeyboardShortcutAlert) {
                        Button("DONE".localize(table: table)) {}.disabled(true)
                        Button("CANCEL".localize(table: table), role: .cancel) {}
                    } message: {
                        Text("KEYBOARD_SHORTCUT_INSTRUCTIONS", tableName: accTable)
                    }
                }
            } header: {
                Text("DEVICE", tableName: table)
            }
            
            Section {
                ForEach($gestureShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name.localize(table: table), status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("KEYBOARD_SHORTCUT".localize(table: accTable), isPresented: $showingKeyboardShortcutAlert) {
                        Button("DONE".localize(table: table)) {}.disabled(true)
                        Button("CANCEL".localize(table: table), role: .cancel) {}
                    } message: {
                        Text("KEYBOARD_SHORTCUT_INSTRUCTIONS", tableName: accTable)
                    }
                }
            } header: {
                Text("GESTURES", tableName: table)
            }
            
            Section {
                Button("RESTORE_DEFAULTS".localize(table: keyTable)) {
                    UIDevice.iPhone ? showingRestoreDefaultsDialog.toggle() : showingRestoreDefaultsAlert.toggle()
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.red)
                .confirmationDialog("RESTORE_DEFAULTS_PROMPT_MESSAGE".localize(table: keyTable), isPresented: $showingRestoreDefaultsDialog,
                                    titleVisibility: .visible,
                                    actions: {
                    Button("RESTORE_DEFAULTS_PROMPT_BUTTON".localize(table: keyTable), role: .destructive) {}
                })
                .alert("RESTORE_DEFAULTS_PROMPT_TITLE".localize(table: keyTable), isPresented: $showingRestoreDefaultsAlert) {
                    Button("RESTORE_DEFAULTS_PROMPT_BUTTON".localize(table: keyTable), role: .destructive) {}
                } message: {
                    Text("RESTORE_DEFAULTS_PROMPT_MESSAGE", tableName: keyTable)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardCommandsView()
    }
}
