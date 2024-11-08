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
/// - Parameter selectedBinding: The optional ``<Binding>String`` holding the currently selected value.
/// - Parameter selected: The ``String`` holding the currently selected value.
/// - Parameter table: The ``String`` table name to use for localization.
struct SelectOptionList: View {
    // Variables
    var title = String()
    var options = ["Allow", "Don‘t Allow"]
    var selectedBinding: Binding<String>? = nil
    @State var selected = "Allow"
    var table = "Restrictions"
    
    var body: some View {
        CustomList(title: title) {
            Section {
                if let selectedBinding = selectedBinding {
                    Picker(title, selection: selectedBinding) {
                        ForEach(options, id: \.self) { option in
                            Text(option.localize(table: table))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } else {
                    Picker(title, selection: $selected) {
                        ForEach(options, id: \.self) { option in
                            Text(option.localize(table: table))
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                }
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
