/*
Abstract:
 A `CustomList` container template that has options that can be selected and customized.
*/

import SwiftUI

/// A `CustomList` container template that has options that can be selected and customized.
///
/// ```swift
/// SelectOptionList("Receive Updates", options: ["Yes", "No"], selected: "Yes")
/// ```
///
/// - Parameter title: The `String` to display as the navigation title of the `View`.
/// - Parameter options: The `String Array` of available options to pick from.
/// - Parameter selectedBinding: The optional `String Binding` holding the currently selected value.
/// - Parameter selected: The `String` holding the currently selected value.
/// - Parameter table: The `String` table name to use for localization.
struct SelectOptionList: View {
    // Variables
    var title: String
    var options: [String]
    var selectedBinding: Binding<String>? = nil
    @State var selected: String
    var table: String
    
    init(_ title: String, options: [String] = [], selectedBinding: Binding<String>? = nil, selected: String = "", table: String = "Localizable") {
        self.title = title
        self.options = options
        self.selectedBinding = selectedBinding
        self.selected = selected
        self.table = table
    }
    
    var body: some View {
        CustomList(title: title.localize(table: table)) {
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
                case "AccountChangesSpecifierName":
                    Text("AccountChangesFooterText", tableName: table)
                case "kWFLocAskToJoinTitle":
                    switch selected {
                    case "kWFLocAskToJoinDetailOff":
                        Text("kWFLocAskToJoinOffFooter", tableName: table)
                    case "kWFLocAskToJoinDetailNotify":
                        Text("kWFLocAskToJoinNotifyFooter", tableName: table)
                    case "kWFLocAskToJoinDetailAsk":
                        Text("kWFLocAskToJoinAskFooter", tableName: table)
                    default:
                        EmptyView()
                    }
                case "ConnectWithFriendsSpecifierName":
                    Text("\("ConnectWithFriendsExplanatoryFooterText".localize(table: table))\n\n\("ConnectWithFriendsContinuedExplanatoryText".localize(table: table))")
                case "PrivateMessagingSpecifierName":
                    Text("PrivateMessagingFooter", tableName: table)
                case "AUTOLOCK":
                    if selectedBinding?.wrappedValue == "NEVER" {
                        Text("DNB_AUTOLOCK_NEVER_WARNING_DESCRIPTION", tableName: table)
                    }
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectOptionList("Are you sure?", options: ["Yes", "No"], selected: "Yes")
    }
}
