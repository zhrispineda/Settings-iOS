//
//  WebContentView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Web Content
//

import SwiftUI

struct WebContentView: View {
    // Variables
    @State private var selected = "UnrestrictedAccessSpecifierName"
    let options = ["UnrestrictedAccessSpecifierName", "LimitAdultWebsitesSpecifierName", "AllowedWebsitesSpecifierName"]
    
    @State private var allowedWebsites = ["Apple – Start", "CBeebies (by BBC", "Disney", "HowStuffWorks", "National Geographic - Kids", "PBS Kids", "Scholastic.com", "Smithsonian Institution", "Time for Kids"]
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "WebContentSpecifierName".localize(table: table), topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("WebContentSpecifierName", tableName: table)
            } footer: {
                if selected == "AllowedWebsitesSpecifierName" {
                    Text("WebContentCustomFilterFooterText", tableName: table)
                } else if selected == "LimitAdultWebsitesSpecifierName" {
                    Text("WebContentAutoFilterFooterText", tableName: table)
                }
            }
            
            if selected == "AllowedWebsitesSpecifierName" {
                Section {
                    ForEach($allowedWebsites, id: \.self, editActions: .delete) { $option in
                        Text(option)
                    }
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("AddWebsiteButton", tableName: table)
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("OnlyAllowLabel", tableName: table)
                }
            }
            
            if selected == "LimitAdultWebsitesSpecifierName" {
                Section {
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("AddWebsiteButton", tableName: table)
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("AlwaysAllowLabel", tableName: table)
                }
                
                Section {
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("AddWebsiteButton", tableName: table)
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("NeverAllowLabel", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WebContentView()
    }
}
