//
//  ContactsView.swift
//  Preferences
//
//  Settings > Apps > Contacts
//

import SwiftUI

struct ContactsView: View {
    // Variables
    @State private var opacity = Double()
    @State private var frameY = Double()
    let table = "Contacts"
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                Placard(title: "CONTACTS".localize(table: table), icon: "com.apple.MobileAddressBook", description: "SETTINGS_SUBTITLE".localize(table: table) + " [\("LEARN_MORE".localize(table: table))](#)", frameY: $frameY, opacity: $opacity)
                Button("ADD_ACCOUNT".localize(table: "PSSystemPolicy")) {}
            }
            
            PermissionsView(appName: "CONTACTS".localize(table: table), cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Button {} label: {
                    SettingsLink("Share Name and Photo".localize(table: table), status: "NAME_AND_PHOTO_SHARING_OFF".localize(table: table), destination: EmptyView())
                }
                .foregroundStyle(.primary)
            } footer: {
                Text("NAME_AND_PHOTO_SHARING_NOT_SHARING_FOOTER", tableName: table)
            }
            
            Section {
                NavigationLink("Providers".localize(table: table)) {}
            }
            
            Section {
                SettingsLink("Sort Order".localize(table: table), status: "LAST".localize(table: table), destination: SelectOptionList("Sort Order", options: ["FIRST", "LAST"], selected: "LAST", table: table))
                SettingsLink("Display Order".localize(table: table), status: "LAST".localize(table: table), destination: EmptyView())
                NavigationLink("Short Name".localize(table: table)) {}
                Button {} label: {
                    NavigationLink("My Info".localize(table: table)) {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                Button("Import SIM Contacts".localize(table: table)) {}
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CONTACTS", tableName: table)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
