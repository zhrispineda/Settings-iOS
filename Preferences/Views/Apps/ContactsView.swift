//
//  ContactsView.swift
//  Preferences
//
//  Settings > Apps > Contacts
//

import SwiftUI

struct ContactsView: View {
    @State private var opacity = Double()
    @State private var frameY = Double()
    @State private var showingHelpSheet = false
    let path = "/System/Library/PreferenceBundles/ContactsSettings.bundle"
    let table = "Contacts"
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                Placard(title: "CONTACTS".localized(path: path, table: table), icon: "com.apple.MobileAddressBook", description: "SETTINGS_SUBTITLE".localized(path: path, table: table) + " [\("LEARN_MORE".localized(path: path, table: table))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
                Button("ADD_ACCOUNT".localized(path: path, table: table)) {}
            }
            
            PermissionsView(appName: "CONTACTS".localized(path: path, table: table), cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Button {} label: {
                    SettingsLink("Share Name and Photo".localized(path: path, table: table), status: "NAME_AND_PHOTO_SHARING_OFF".localized(path: path, table: table), destination: EmptyView())
                }
                .foregroundStyle(.primary)
            } footer: {
                Text("NAME_AND_PHOTO_SHARING_NOT_SHARING_FOOTER".localized(path: path, table: table))
            }
            
            Section {
                NavigationLink("Providers".localized(path: path, table: table)) {}
            }
            
            Section {
                SettingsLink("Sort Order".localized(path: path, table: table), status: "LAST".localized(path: path, table: table), destination: SelectOptionList("Sort Order", options: ["FIRST", "LAST"], selected: "LAST", table: table))
                SettingsLink("Display Order".localized(path: path, table: table), status: "LAST".localized(path: path, table: table), destination: EmptyView())
                NavigationLink("Short Name".localized(path: path, table: table)) {}
                Button {} label: {
                    NavigationLink("My Info".localized(path: path, table: table)) {}
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                Button("Import SIM Contacts".localized(path: path, table: table)) {}
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CONTACTS".localized(path: path, table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph7edacccf9" : "ipad99df07d1")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
