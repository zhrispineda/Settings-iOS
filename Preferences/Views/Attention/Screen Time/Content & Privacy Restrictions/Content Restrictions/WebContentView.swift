//
//  WebContentView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Web Content
//

import SwiftUI

struct WebContentView: View {
    // Variables
    @State private var selectedOption = "Unrestricted"
    let options = ["Unrestricted", "Limit Adult Websites", "Allowed Websites"]
    
    @State private var allowedWebsites = ["Apple – Start", "CBeebies (by BBC", "Disney", "HowStuffWorks", "National Geographic - Kids", "PBS Kids", "Scholastic.com", "Smithsonian Institution", "Time for Kids"]
    
    var body: some View {
        CustomList(title: "Web Content") {
            Section {
                ForEach(options, id: \.self) { option in
                    Button { selectedOption = option } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } header: {
                Text("Web Content")
            } footer: {
                if selectedOption == "Allowed Websites" {
                    Text("Allow access only to the websites below.")
                } else if selectedOption == "Limit Adult Websites" {
                    Text("Limit access to many adult websites automatically. Specific allowed and restricted websites can be added below.")
                }
            }
            
            if selectedOption == "Allowed Websites" {
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
            
            if selectedOption == "Limit Adult Websites" {
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
