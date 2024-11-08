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
                Placard(title: "CONTACTS".localize(table: table), icon: "appleContacts", description: "SETTINGS_SUBTITLE".localize(table: table) + " [\("LEARN_MORE".localize(table: table))](#)")
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
                CustomNavigationLink(title: "CONTACTS_ACCOUNTS".localize(table: table), status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "CONTACTS".localize(table: table), cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Button {} label: {
                    CustomNavigationLink(title: "Share Name and Photo".localize(table: table), status: "NAME_AND_PHOTO_SHARING_OFF".localize(table: table), destination: EmptyView())
                }
                .foregroundStyle(Color["Label"])
            } footer: {
                Text("NAME_AND_PHOTO_SHARING_NOT_SHARING_FOOTER", tableName: table)
            }
            
            Section {
                NavigationLink("Providers".localize(table: table)) {}
            }
            
            Section {
                CustomNavigationLink(title: "Sort Order".localize(table: table), status: "LAST".localize(table: table), destination: SelectOptionList(title: "Sort Order", options: ["FIRST", "LAST"], selected: "LAST", table: table))
                CustomNavigationLink(title: "Display Order".localize(table: table), status: "LAST".localize(table: table), destination: EmptyView())
                NavigationLink("Short Name".localize(table: table)) {}
                Button {} label: {
                    NavigationLink("My Info".localize(table: table)) {}
                }
                .foregroundStyle(Color["Label"])
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
