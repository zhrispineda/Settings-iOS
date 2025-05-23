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
    let table = "General"
    
    var body: some View {
        CustomList(title: "Device_Name".localize(table: table)) {
            HStack {
                TextField("Device_Name".localize(table: table), text: $deviceName, prompt: Text(UIDevice.current.model))
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
                if deviceName.count > 0 {
                    Button {
                        deviceName = String()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.background, Color(UIColor.separator))
                    }
                    .foregroundStyle(.gray)
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
