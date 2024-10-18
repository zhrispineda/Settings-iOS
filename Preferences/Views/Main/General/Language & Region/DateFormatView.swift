//
//  DateFormatView.swift
//  Preferences
//
//  Settings > General > Language & Region > Date Format
//

import SwiftUI

struct DateFormatView: View {
    @State private var selected = "8/19/24"
    let options = [
        "8/19/24",
        "19/8/24",
        "19/08/2024",
        "19.08.2024",
        "19-08-2024",
        "2024/8/19",
        "2024.08.19",
        "2024-08-19"
    ]
    let table = "InternationalSettings"
    
    var body: some View {
        CustomList(title: "DATE_FORMAT".localize(table: table)) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("DATE_FORMAT_EXAMPLE_%@_%@_%@_%@".localize(table: table, selected, "Aug 19, 2024", "August 19, 2024", "Monday, August 19, 2024"))
            }
        }
    }
}

#Preview {
    NavigationStack {
        DateFormatView()
    }
}
