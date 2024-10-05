//
//  RadioAddressLabel.swift
//  Preferences
//
//  For displaying values such as Wi-Fi and Bluetooth addresses.
//

import SwiftUI

struct RadioAddressLabel: View {
    var label = String()
    var value = String()
    
    init(_ label: String = String(), value: String = String()) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            HStack(spacing: 0) {
                ForEach(value.map { String($0) }, id: \.self) { character in
                    if character == ":" || character == "1" || character == "." {
                        Text(character)
                    } else {
                        Text(character)
                            .fontDesign(.monospaced)
                            .kerning(-1)
                    }
                }
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        CustomList(title: "RadioAddressLabel Example") {
            RadioAddressLabel("Label", value: "01:AB:23:4C:56:78")
        }
    }
}
