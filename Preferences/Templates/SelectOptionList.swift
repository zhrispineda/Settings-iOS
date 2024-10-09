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
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: title) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                switch title {
                case "Account Changes":
                    Text("AccountChangesFooterText", tableName: table)
                case "Ask to Join Networks":
                    Text("kWFLocAskToJoin\(selected)Footer".localize(table: "WiFiKitUILocalizableStrings"))
                case "Connect with Friends":
                    VStack(alignment: .leading) {
                        Text("ConnectWithFriendsExplanatoryFooterText", tableName: table)
                        Text("\n" + "ConnectWithFriendsContinuedExplanatoryText".localize(table: table))
                    }
                case "Private Messaging":
                    Text("PrivateMessagingFooter", tableName: table)
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectOptionList(title: "ConnectWithFriendsSpecifierName".localize(table: "Restrictions"))
    }
}
