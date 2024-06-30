//
//  WebContentView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Web Content
//

import SwiftUI

struct WebContentView: View {
    // Variables
    @State private var selected = "Unrestricted"
    let options = ["Unrestricted", "Limit Adult Websites", "Allowed Websites"]
    
    @State private var allowedWebsites = ["Apple – Start", "CBeebies (by BBC", "Disney", "HowStuffWorks", "National Geographic - Kids", "PBS Kids", "Scholastic.com", "Smithsonian Institution", "Time for Kids"]
    
    var body: some View {
        CustomList(title: "Web Content") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Web Content")
            } footer: {
                if selected == "Allowed Websites" {
                    Text("Allow access only to the websites below.")
                } else if selected == "Limit Adult Websites" {
                    Text("Limit access to many adult websites automatically. Specific allowed and restricted websites can be added below.")
                }
            }
            
            if selected == "Allowed Websites" {
                Section {
                    ForEach($allowedWebsites, id: \.self, editActions: .delete) { $option in
                        Text(option)
                    }
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("Add Website")
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("Only Allow These Websites:")
                }
            }
            
            if selected == "Limit Adult Websites" {
                Section {
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("Add Website")
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("Always Allow:")
                }
                
                Section {
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("Add Website")
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("Never Allow:")
                }
            }
        }
    }
}

#Preview {
    WebContentView()
}
