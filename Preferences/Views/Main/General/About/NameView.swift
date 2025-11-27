//
//  NameView.swift
//  Preferences
//
//  Settings > General > About > Name
//

import SwiftUI

struct NameView: View {
    @AppStorage("DeviceName") private var deviceName = UIDevice.current.model
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedName: Bool
    private let path = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"
    private let table = "General"
    
    var body: some View {
        CustomList(title: "Device_Name".localized(path: path, table: table)) {
            HStack {
                TextField(
                    "Device_Name".localized(path: path, table: table),
                    text: $deviceName,
                    prompt: Text(UIDevice.current.model)
                )
                .focused($focusedName)
                .onAppear {
                    focusedName = true
                }
                .onSubmit {
                    if deviceName.isEmpty {
                        deviceName = UIDevice.current.model
                    }
                    dismiss()
                }
                .submitLabel(.done)
                if deviceName.count > 0 {
                    Button {
                        deviceName = String()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.fill)
                    }
                    .buttonStyle(.plain)
                }
            }
        }

    }
}

#Preview {
    NavigationStack {
        NameView()
    }
}
