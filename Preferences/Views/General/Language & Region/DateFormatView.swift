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
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    })
                }
            }, footer: {
                Text("""
                     Format Example:
                     • Short: \(selected)
                     • Medium: Aug 19, 2024
                     • Long: August 19, 2024
                     • Full: Monday, August 19, 2024
                     """)
            })
        }
    }
}

#Preview {
    DateFormatView()
}
