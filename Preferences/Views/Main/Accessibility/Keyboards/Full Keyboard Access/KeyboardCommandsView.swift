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
        CommandShortcut(name: "Help", shortcut: "Tab H"),
        CommandShortcut(name: "Move forward", shortcut: "Tab"),
        CommandShortcut(name: "Move backward", shortcut: "\u{21E7} Tab"),
        CommandShortcut(name: "Move up", shortcut: "\u{2191}"),
        CommandShortcut(name: "Move down", shortcut: "\u{2193}"),
        CommandShortcut(name: "Move left", shortcut: "\u{2190}"),
        CommandShortcut(name: "Move right", shortcut: "\u{2192}"),
        CommandShortcut(name: "Activate", shortcut: "Space"),
        CommandShortcut(name: "Home", shortcut: "Fn H")
    ]
    @State private var movementShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "Move forward", shortcut: "Tab"),
        CommandShortcut(name: "Move backward", shortcut: "\u{21E7} Tab"),
        CommandShortcut(name: "Move up", shortcut: "\u{2191}"),
        CommandShortcut(name: "Move down", shortcut: "\u{2193}"),
        CommandShortcut(name: "Move left", shortcut: "\u{2190}"),
        CommandShortcut(name: "Move right", shortcut: "\u{2192}"),
        CommandShortcut(name: "Move to beginning", shortcut: "Tab \u{2190}"),
        CommandShortcut(name: "Move to end", shortcut: "Tab \u{2192}"),
        CommandShortcut(name: "Move to next item", shortcut: "\u{005E} Tab"),
        CommandShortcut(name: "Move to previous item", shortcut: "\u{005E} \u{21E7} Tab"),
        CommandShortcut(name: "Find", shortcut: "Tab F")
    ]
    @State private var interactionShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "Activate", shortcut: "Space"),
        CommandShortcut(name: "Go back", shortcut: "Tab B"),
        CommandShortcut(name: "Contextual menu", shortcut: "Tab M"),
        CommandShortcut(name: "Actions", shortcut: "Tab Z")
    ]
    @State private var deviceShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "Home", shortcut: "Fn H"),
        CommandShortcut(name: "Control Center", shortcut: "Fn C"),
        CommandShortcut(name: "Notification Center", shortcut: "Fn N"),
        CommandShortcut(name: "Restart", shortcut: "\u{005E} \u{2325} \u{21E7} \u{2318} R"),
        CommandShortcut(name: "Siri", shortcut: "Fn S"),
        CommandShortcut(name: "Accessibility Shortcut", shortcut: "Tab X"),
        CommandShortcut(name: "Analytics", shortcut: "\u{005E} \u{2325} \u{21E7} \u{2318} \u{002E}"),
        CommandShortcut(name: "Pass-Through Mode", shortcut: "\u{005E} \u{2325} \u{2318} P")
    ]
    @State private var gestureShortcuts: [CommandShortcut] = [
        CommandShortcut(name: "Keyboard Gestures", shortcut: "Tab G"),
        CommandShortcut(name: "Touch", shortcut: ""),
        CommandShortcut(name: "Swipe up", shortcut: ""),
        CommandShortcut(name: "Swipe down", shortcut: ""),
        CommandShortcut(name: "Swipe left", shortcut: ""),
        CommandShortcut(name: "Swipe right", shortcut: ""),
        CommandShortcut(name: "Zoom out", shortcut: ""),
        CommandShortcut(name: "Zoom in", shortcut: ""),
        CommandShortcut(name: "Rotate left", shortcut: ""),
        CommandShortcut(name: "Rotate right", shortcut: ""),
        CommandShortcut(name: "Two finger touch", shortcut: ""),
        CommandShortcut(name: "Two finger swipe down", shortcut: ""),
        CommandShortcut(name: "Two finger swipe left", shortcut: ""),
        CommandShortcut(name: "Two finger swipe right", shortcut: ""),
        CommandShortcut(name: "Two finger swipe up", shortcut: "")
    ]
    
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
                        HText(shortcut.name, status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("Keyboard Shortcut", isPresented: $showingKeyboardShortcutAlert) {
                        Button("Done") {}.disabled(true)
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter a key combination on your keyboard.")
                    }
                }
            } header: {
                Text("Basic")
            }
            
            Section {
                ForEach($movementShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name, status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("Keyboard Shortcut", isPresented: $showingKeyboardShortcutAlert) {
                        Button("Done") {}.disabled(true)
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter a key combination on your keyboard.")
                    }
                }
            } header: {
                Text("Movement")
            }
            
            Section {
                ForEach($interactionShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name, status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("Keyboard Shortcut", isPresented: $showingKeyboardShortcutAlert) {
                        Button("Done") {}.disabled(true)
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter a key combination on your keyboard.")
                    }
                }
            } header: {
                Text("Interaction")
            }
            
            Section {
                ForEach($deviceShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name, status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("Keyboard Shortcut", isPresented: $showingKeyboardShortcutAlert) {
                        Button("Done") {}.disabled(true)
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter a key combination on your keyboard.")
                    }
                }
            } header: {
                Text("Device")
            }
            
            Section {
                ForEach($gestureShortcuts) { $shortcut in
                    Button {
                        showingKeyboardShortcutAlert.toggle()
                    } label: {
                        HText(shortcut.name, status: shortcut.shortcut)
                            .foregroundStyle(Color["Label"])
                    }
                    .alert("Keyboard Shortcut", isPresented: $showingKeyboardShortcutAlert) {
                        Button("Done") {}.disabled(true)
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Enter a key combination on your keyboard.")
                    }
                }
            } header: {
                Text("Gestures")
            }
            
            Section {
                Button("Restore Defaults") {
                    UIDevice.iPhone ? showingRestoreDefaultsDialog.toggle() : showingRestoreDefaultsAlert.toggle()
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.red)
                .confirmationDialog("This will reset all keyboard shortcuts to their default values.", isPresented: $showingRestoreDefaultsDialog,
                                    titleVisibility: .visible,
                                    actions: {
                    Button("Restore Defaults", role: .destructive) {}
                })
                .alert("Restore Defaults", isPresented: $showingRestoreDefaultsAlert) {
                    Button("Restore Defaults", role: .destructive) {}
                } message: {
                    Text("This will reset all keyboard shortcuts to their default values.")
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
