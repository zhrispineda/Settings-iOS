/*
Abstract:
A CustomList container template for having options that can be selected and can also be customized.
*/

import SwiftUI

/// A `CustomList` container template for having options that can be selected and can also be customized.
/// ```swift
/// SelectOptionList(title: "Receive Updates", options: ["Yes", "No"], selected: "Yes")
/// ```
/// - Parameter title: The `String` to display as the navigation title of the `View`.
/// - Parameter options: The `String Array` of available options to pick from.
/// - Parameter selectedBinding: The optional `String Binding` holding the currently selected value.
/// - Parameter selected: The `String` holding the currently selected value.
/// - Parameter table: The `String` table name to use for localization.
struct SelectOptionList: View {
    // Variables
    var title: String
    var options: [String] = []
    var selectedBinding: Binding<String>? = nil
    @State var selected = String()
    var table = String()
    
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
                    VStack(alignment: .leading) {
                        Text("ConnectWithFriendsExplanatoryFooterText", tableName: table)
                        Text("\n") + Text("ConnectWithFriendsContinuedExplanatoryText", tableName: table)
                    }
                case "PrivateMessagingSpecifierName":
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
        SelectOptionList(title: "Receive Updates", options: ["Yes", "No"], selected: "Yes")
    }
}
