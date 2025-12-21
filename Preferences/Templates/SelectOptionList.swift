//
//  SelectionOptionList.swift
//  Preferences
//

import SwiftUI

/// A `CustomList` container template that has options that can be selected and customized.
///
/// ```swift
/// SelectOptionList("Receive Updates", options: ["Yes", "No"], selected: $currentOption)
/// ```
///
/// - Parameter title: The `String` to display as the navigation title of the `View`.
/// - Parameter options: The `String Array` of available options to pick from.
/// - Parameter selectedBinding: The `String` `Binding` holding the currently selected value.
/// - Parameter path: The `String` path to use for localization.
/// - Parameter table: The `String` table name to use for localization.
struct SelectOptionList: View {
    var title: String
    var options: [String]
    var selected: Binding<String>
    var path: String
    var table: String
    
    init(
        _ title: String,
        options: [String] = [],
        selected: Binding<String>,
        path: String = "",
        table: String = "Localizable"
    ) {
        self.title = title
        self.options = options
        self.selected = selected
        self.path = path
        self.table = table
    }
    
    var body: some View {
        CustomList(title: title.localized(path: path, table: table)) {
            Section {
                Picker(title, selection: selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                switch title {
                case "AccountChangesSpecifierName":
                    Text("AccountChangesFooterText".localized(path: path, table: table))
                case "kWFLocAskToJoinTitle":
                    switch selected.wrappedValue {
                    case "kWFLocAskToJoinDetailOff":
                        Text("kWFLocAskToJoinOffFooter".localized(path: path, table: table))
                    case "kWFLocAskToJoinDetailNotify":
                        Text("kWFLocAskToJoinNotifyFooter".localized(path: path, table: table))
                    case "kWFLocAskToJoinDetailAsk":
                        Text("kWFLocAskToJoinAskFooter".localized(path: path, table: table))
                    default:
                        EmptyView()
                    }
                case "ConnectWithFriendsSpecifierName":
                    Text("\("ConnectWithFriendsExplanatoryFooterText".localized(path: path, table: table))\n\n\("ConnectWithFriendsContinuedExplanatoryText".localized(path: path, table: table))")
                case "PrivateMessagingSpecifierName":
                    Text("PrivateMessagingFooter".localized(path: path, table: table))
                case "AUTOLOCK":
                    if selected.wrappedValue == "NEVER" {
                        Text("DNB_AUTOLOCK_NEVER_WARNING_DESCRIPTION".localized(path: path, table: table))
                    }
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var currentOption = "Yes"
    
    NavigationStack {
        SelectOptionList("Are you sure?", options: ["Yes", "No"], selected: $currentOption)
    }
}
