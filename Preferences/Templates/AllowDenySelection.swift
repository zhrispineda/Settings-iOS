//
//  AllowDenySelection.swift
//  Preferences
//
/// View with a selectable List for holding two options: `Allow` or `Don‘t Allow`, which can be customized.
/// - Parameters:
///   - title: The navigation title to use for the view.
///   - options: Available options to choose from.
///   - selected: Select option to be chosen by default.

import SwiftUI

struct AllowDenySelection: View {
    // Variables
    var title = String()
    var options = ["Allow", "Don‘t Allow"]
    @State var selected = "Allow"
    
    var body: some View {
        CustomList(title: title) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selected = option
                }, label: {
                    HStack {
                        Text(option)
                            .foregroundStyle(Color(UIColor.label))
                        Spacer()
                        Image(systemName: "\(selected == option ? "checkmark" : "")")
                    }
                })
            }
        }
    }
}

#Preview {
    AllowDenySelection()
}
