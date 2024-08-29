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
    
    var body: some View {
        CustomList(title: "Back") {
            Section {
                SectionHelp(title: "Contacts", icon: "appleContacts", description: "Add and remove accounts, manage Siri & Search, and customize how contacts appears. [Learn more...](https://support.apple.com/guide/\(UIDevice.current.model))")
                    .overlay { // For calculating opacity of the principal toolbar item
                        GeometryReader { geo in
                            Color.clear
                                .onChange(of: geo.frame(in: .scrollView).minY) {
                                    frameY = geo.frame(in: .scrollView).minY
                                    opacity = frameY / -30
                                }
                        }
                    }
                CustomNavigationLink(title: "Contacts Accounts", status: "1", destination: EmptyView())
            }
            
            PermissionsView(appName: "Contacts", cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Button {} label: {
                    CustomNavigationLink(title: "Share Name and Photo", status: "Off", destination: EmptyView())
                }
                .foregroundStyle(Color["Label"])
            } footer: {
                Text("To personalize your messages, choose your name and photo, and who can see what you share.")
            }
            
            Section {
                NavigationLink("Providers") {}
            }
            
            Section {
                CustomNavigationLink(title: "Sort Order", status: "Last, First", destination: SelectOptionList(title: "Sort Order", options: ["First, Last", "Last, First"], selected: "Last, First"))
                CustomNavigationLink(title: "Display Order", status: "Last, First", destination: EmptyView())
                NavigationLink("Short Name") {}
                Button {} label: {
                    NavigationLink("My Info") {}
                }
                .foregroundStyle(Color["Label"])
            }
            
            Section {
                Button("Import SIM Contacts") {}
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Contacts")
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
