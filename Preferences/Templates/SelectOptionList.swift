//
//  SelectOptionList.swift
//  Preferences
//

import SwiftUI

/// A ``CustomList`` ``View`` template for having options that can be selected and can also be customized.
/// ```swift
/// SelectOptionList(title: "Receive Updates", options: ["Yes", "No"], selected: "Yes")
/// ```
/// - Parameter title: The ``String`` to display as the title of the ``View``.
/// - Parameter options: The ``String Array``of available options to pick from..
/// - Parameter selected: The ``String`` holding the currently selected value.
struct SelectOptionList: View {
    // Variables
    var title = String()
    var options = ["Allow", "Don‘t Allow"]
    @State var selected = "Allow"
    
    var body: some View {
        CustomList(title: title) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                switch title {
                case "Account Changes":
                    Text("Disallowing changes prevents adding, removing, or modifying accounts in Passwords & Accounts.")
                case "Ask to Join Networks":
                    Text("kWFLocAskToJoin\(selected)Footer".localize(table: "WiFiKitUILocalizableStrings"))
                case "Connect with Friends":
                    VStack {
                        Text("By selecting “Allow,“ apps can ask for permission to connect you with your Game Center friends.\n")
                        Text("\nDisallowing prevents apps from asking if they can connect you with your Game Center friends and restricts this device from sharing your Game Center friends list with other apps.")
                    }
                case "Private Messaging":
                    Text("Disallowing prevents you from sending custom messages to other players and using voice chat in games.")
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectOptionList()
    }
}
