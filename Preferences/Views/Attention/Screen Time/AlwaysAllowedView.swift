//
//  AlwaysAllowedView.swift
//  Preferences
//
//  Settings > Screen Time > Always Allowed
//

import SwiftUI

struct AlwaysAllowedView: View {
    // Variables
    @State private var showingMessagesAlert = false
    @State private var includedControls = ["Messages", "Maps"]
    @State private var moreControls = ["Calendar", "Contacts", "News", "Photos", "Reminders", "Shortcuts"]
    let allowedAppsOrder = ["Messages", "Maps", "Calendar", "Contacts", "News", "Photos", "Reminders", "Shortcuts"]
    let chooseAppsOrder = ["Calendar", "Contacts", "Maps", "Messages", "News", "Photos", "Reminders", "Shortcuts"]
    
    var body: some View {
        CustomList(title: "Always Allowed") {
            Section {
                SettingsLabel(icon: "applephone", id: "Phone")
                ForEach($includedControls, id: \.self) { $control in
                    SettingsLabel(icon: "apple\(control.lowercased())", id: control)
                    // TODO: Figure out swipe controls (change from Delete to Remove) and alert for removing Messages
//                        .swipeActions(edge: .trailing) {
//                            Button(role: .destructive, action: {
//                                if control == "Messages" {
//                                    showingDialog.toggle()
//                                }
//                            }) {
//                                Text("Remove")
//                            }
//                        }
//                        .alert("Remove Messages from Always Allowed?", isPresented: $showingMessagesAlert, actions: {
//                            Button("Remove", role: .destructive, action: {
//                                if let index = includedControls.firstIndex(of: control) {
//                                    includedControls.remove(at: index)
//                                    moreControls.sort { (first, prev) in
//                                        guard let index1 = moreControlsOrder.firstIndex(of: first),
//                                              let index2 = moreControlsOrder.firstIndex(of: prev) else {
//                                            return false
//                                        }
//                                        return index1 < index2
//                                    }
//                                }
//                            })
//                        }, message: {
//                            Text("If Messages is not always allowed, this device will not be able to send or receive messages during downtime or after the app limit is reached, including and from emergency contacts.")
//                        })
                }
                .onDelete { indexSet in
                    for index in indexSet{
                        moreControls.append(includedControls[index])
                    }
                    includedControls.remove(atOffsets: indexSet)
                    moreControls.sort { (first, prev) in
                        guard let index1 = chooseAppsOrder.firstIndex(of: first),
                              let index2 = chooseAppsOrder.firstIndex(of: prev) else {
                            return false
                        }
                        return index1 < index2
                    }
                }
            } header: {
                VStack(alignment: .leading) {
                    Text("\n\nAllowed Apps")
                    Text("Always allowed apps are available during downtime, or if you select the “All Apps & Categories“ app limit.")
                        .textCase(.none)
                }
            }
            
            Section {
                ForEach($moreControls, id: \.self) { $control in
                    HStack(spacing: 15) {
                        Button {
                            withAnimation { // Move element to the Allowed Apps list and sort it
                                if let index = moreControls.firstIndex(of: control) {
                                    includedControls.append(moreControls.remove(at: index))
                                    includedControls.sort { (first, prev) in
                                        guard let index1 = allowedAppsOrder.firstIndex(of: first),
                                              let index2 = allowedAppsOrder.firstIndex(of: prev) else {
                                            return false
                                        }
                                        return index1 < index2
                                    }
                                }
                            }
                        } label: {
                            ZStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.white, .green)
                            }
                        }
                        .buttonStyle(.plain)
                        SettingsLabel(icon: "apple\(control.lowercased())", id: control)
                    }
                }
            } header: {
                Text("Choose Apps:")
            }
        }
        .environment(\.editMode, Binding.constant(EditMode.active))
    }
}

#Preview {
    NavigationStack {
        AlwaysAllowedView()
    }
}
