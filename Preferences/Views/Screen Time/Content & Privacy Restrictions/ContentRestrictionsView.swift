//
//  ContentRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions
//

import SwiftUI

struct ContentRestrictionsView: View {
    var body: some View {
        CustomList(title: "Content Restrictions") {
            Section(content: {
                CustomNavigationLink(title: "Music, Podcasts, News, Fitness", status: "Explicit", destination: AllowDenySelection(title: "Music, Podcasts, News, Fitness", options: ["Clean", "Explicit"], selected: "Explicit"))
                CustomNavigationLink(title: "Music Videos", status: "On", destination: AllowDenySelection(title: "Music Videos", options: ["Off", "On"], selected: "On"))
                CustomNavigationLink(title: "Music Profiles", status: "On", destination: AllowDenySelection(title: "Music Videos", options: ["Off", "On"], selected: "On"))
                CustomNavigationLink(title: "Movies", status: "Allow All", destination: MoviesView())
                CustomNavigationLink(title: "TV", status: "Allow All", destination: TVView())
                CustomNavigationLink(title: "Books", status: "Explicit", destination: AllowDenySelection(title: "Books", options: ["Clean", "Explicit"], selected: "Explicit"))
                CustomNavigationLink(title: "Apps", status: "17+", destination: AppsView())
                CustomNavigationLink(title: "App Clips", status: "Allow", destination: AllowDenySelection(title: "App Clips"))
            }, header: {
                Text("Allowed Store Content")
            })
            
            Section(content: {
                CustomNavigationLink(title: "Web Content", status: "Unrestricted", destination: WebContentView())
            }, header: {
                Text("Web Content")
            })
            
            Section(content: {
                CustomNavigationLink(title: "Web Search Content", status: "Allow", destination: AllowDenySelection(title: "Web Search Content"))
                CustomNavigationLink(title: "Explicit Language", status: "Allow", destination: AllowDenySelection(title: "Explicit Language"))
            }, header: {
                Text("Siri")
            })
            
            Section(content: {
                CustomNavigationLink(title: "Multiplayer Games", status: "Allow with Everyone", destination: AllowDenySelection(title: "Multiplayer Games", options: ["Don‘t Allow", "Allow with Friends Only", "Allow with Everyone"], selected: "Allow with Everyone"))
                CustomNavigationLink(title: "Adding Friends", status: "Allow", destination: AllowDenySelection(title: "Adding Friends"))
                CustomNavigationLink(title: "Connect with Friends", status: "Allow", destination: AllowDenySelection(title: "Connect with Friends"))
                CustomNavigationLink(title: "Screen Recording", status: "Allow", destination: AllowDenySelection(title: "Screen Recording"))
                CustomNavigationLink(title: "Nearby Multiplayer", status: "Allow", destination: AllowDenySelection(title: "Nearby Multiplayer"))
                CustomNavigationLink(title: "Private Messaging", status: "Allow", destination: AllowDenySelection(title: "Private Messaging"))
                CustomNavigationLink(title: "Profile Privacy Changes", status: "Allow", destination: AllowDenySelection(title: "Profile Privacy Changes"))
                CustomNavigationLink(title: "Avatar & Nickname Changes", status: "Allow", destination: AllowDenySelection(title: "Avatar & Nickname Changes"))
            }, header: {
                Text("Game Center")
            })
            
        }
    }
}

#Preview {
    NavigationStack {
        ContentRestrictionsView()
    }
}
