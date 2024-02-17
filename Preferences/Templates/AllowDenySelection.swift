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
            Section(content: {
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
            }, footer: {
                if title == "Connect with Friends" {
                    VStack {
                        Text("By selecting “Allow,“ apps can ask for permission to connect you with your Game Center friends.\n")
                        Text("\nDisallowing prevents apps from asking if they can connect you with your Game Center friends and restricts this device from sharing your Game Center friends list with other apps.")
                    }
                } else if title == "Private Messaging" {
                    Text("Disallowing prevents you from sending custom messages to other players and using voice chat in games.")
                } else if title == "Account Changes" {
                    Text("Disallowing changes prevents adding, removing, or modifying accounts in Passwords & Accounts.")
                }
            })
        }
    }
}

#Preview {
    AllowDenySelection()
}
