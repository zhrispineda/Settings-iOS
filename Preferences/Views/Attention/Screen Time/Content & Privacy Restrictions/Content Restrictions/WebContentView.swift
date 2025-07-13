//
//  WebContentView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Web Content
//

import SwiftUI

struct WebContentView: View {
    @State private var selected = "UnrestrictedAccessSpecifierName"
    @State private var allowedWebsites = ["Apple – Start", "CBeebies (by BBC", "Disney", "HowStuffWorks", "National Geographic - Kids", "PBS Kids", "Scholastic.com", "Smithsonian Institution", "Time for Kids"]
    let options = ["UnrestrictedAccessSpecifierName", "LimitAdultWebsitesSpecifierName", "AllowedWebsitesSpecifierName"]
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "WebContentSpecifierName".localized(path: path, table: table), topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("WebContentSpecifierName".localized(path: path, table: table))
            } footer: {
                if selected == "AllowedWebsitesSpecifierName" {
                    Text("WebContentCustomFilterFooterText".localized(path: path, table: table))
                } else if selected == "LimitAdultWebsitesSpecifierName" {
                    Text("WebContentAutoFilterFooterText".localized(path: path, table: table))
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
                        Text("AddWebsiteButton".localized(path: path, table: table))
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("OnlyAllowLabel".localized(path: path, table: table))
                }
            }
            
            if selected == "LimitAdultWebsitesSpecifierName" {
                Section {
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("AddWebsiteButton".localized(path: path, table: table))
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("AlwaysAllowLabel".localized(path: path, table: table))
                }
                
                Section {
                    ZStack(alignment: .leading) {
                        NavigationLink("", destination: {})
                            .opacity(0)
                        Text("AddWebsiteButton".localized(path: path, table: table))
                            .foregroundStyle(.blue)
                    }
                } header: {
                    Text("NeverAllowLabel".localized(path: path, table: table))
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
