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
    @State private var includedControls = ["MessagesAppName", "Maps"]
    @State private var moreControls = ["Calendar", "Contacts", "News", "Photos", "Reminders", "Shortcuts"]
    let allowedAppsOrder = ["MessagesAppName", "Maps", "Calendar", "Contacts", "News", "Photos", "Reminders", "Shortcuts"]
    let chooseAppsOrder = ["Calendar", "Contacts", "Maps", "MessagesAppName", "News", "Photos", "Reminders", "Shortcuts"]
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        CustomList(title: "AlwaysAllowTitle".localize(table: table), topPadding: true) {
            Section {
                SLabel("Phone", icon: "applePhone")
                ForEach($includedControls, id: \.self) { $control in
                    SLabel(control.localize(table: table), icon: "apple\(control.localize(table: table))")
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
                    Text("AllowedAppsGroupSpecifierName", tableName: table)
                    Text("AllowedAppsGroupSpecifierFooter", tableName: table)
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
                        SLabel(control, icon: "apple\(control.localize(table: table))")
                    }
                }
            } header: {
                Text("ChooseAppsGroupSpecifierName", tableName: table)
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
