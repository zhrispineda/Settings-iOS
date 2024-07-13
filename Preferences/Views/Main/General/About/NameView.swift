//
//  NameView.swift
//  Preferences
//
//  Settings > General > About > Name
//

import SwiftUI

struct NameView: View {
    // Variables
    @AppStorage("DeviceName") private var deviceName = UIDevice().model
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedName: Bool
    
    var body: some View {
        CustomList(title: "Name") {
            HStack {
                TextField("Name", text: $deviceName, prompt: Text(Device().model))
                    .focused($focusedName)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.focusedName = true
                        }
                    }
                    .onSubmit {
                        if deviceName.isEmpty {
                            deviceName = Device().model
                        }
                        dismiss()
                    }
                if deviceName.count > 0 {
                    Button {
                        deviceName = ""
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
