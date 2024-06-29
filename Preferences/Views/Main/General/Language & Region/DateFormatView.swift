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
    
    var body: some View {
        CustomList(title: "Date Format") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("""
                     Format Example:
                     • Short: \(selected)
                     • Medium: Aug 19, 2024
                     • Long: August 19, 2024
                     • Full: Monday, August 19, 2024
                     """)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DateFormatView()
    }
}
