//
//  AlwaysAllowedView.swift
//  Preferences
//
//  Settings > Screen Time > Always Allowed
//

import SwiftUI

struct AlwaysAllowedView: View {
    @State private var showingMessagesAlert = false
    @State private var includedControls = ["MessagesAppName", "Maps"]
    @State private var moreControls = ["Calendar", "Contacts", "News", "Photos", "Reminders", "Shortcuts"]
    let allowedAppsOrder = ["MessagesAppName", "Maps", "Calendar", "Contacts", "News", "Photos", "Reminders", "Shortcuts"]
    let chooseAppsOrder = ["Calendar", "Contacts", "Maps", "MessagesAppName", "News", "Photos", "Reminders", "Shortcuts"]
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let appIcons: [String: String] = [
        "MessagesAppName": "com.apple.MobileSMS",
        "Maps": "com.apple.Maps",
        "Calendar": "com.apple.mobilecal",
        "Contacts": "com.apple.MobileAddressBook",
        "News": "com.apple.news",
        "Photos": "com.apple.mobileslideshow",
        "Reminders": "com.apple.reminders",
        "Shortcuts": "com.apple.shortcuts"
    ]

    var body: some View {
        CustomList(title: "AlwaysAllowTitle".localized(path: path), topPadding: true) {
            Section {
                SLabel("Phone", icon: "com.apple.mobilephone")
                ForEach($includedControls, id: \.self) { $control in
                    SLabel(control.localized(path: path), icon: appIcons[control] ?? "app")
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        moreControls.append(includedControls[index])
                    }
                    includedControls.remove(atOffsets: indexSet)
                    moreControls.sort {
                        guard let index1 = chooseAppsOrder.firstIndex(of: $0),
                              let index2 = chooseAppsOrder.firstIndex(of: $1) else {
                            return false
                        }
                        return index1 < index2
                    }
                }
            } header: {
                VStack(alignment: .leading) {
                    Text("AllowedAppsGroupSpecifierName".localized(path: path))
                    Text("AllowedAppsGroupSpecifierFooter".localized(path: path))
                        .textCase(.none)
                }
            }

            Section {
                ForEach($moreControls, id: \.self) { $control in
                    HStack(spacing: 15) {
                        Button {
                            withAnimation {
                                if let index = moreControls.firstIndex(of: control) {
                                    includedControls.append(moreControls.remove(at: index))
                                    includedControls.sort {
                                        guard let index1 = allowedAppsOrder.firstIndex(of: $0),
                                              let index2 = allowedAppsOrder.firstIndex(of: $1) else {
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

                        SLabel(control.localized(path: path), icon: appIcons[control] ?? "app")
                    }
                }
            } header: {
                Text("ChooseAppsGroupSpecifierName".localized(path: path))
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
