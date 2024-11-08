//
//  ContentRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions
//

import SwiftUI

struct ContentRestrictionsView: View {
    // Variables
    let table = "Restrictions"
    let rateTable = "RatingProviders"
    
    var body: some View {
        CustomList(title: "ContentRestrictionsSpecifierName".localize(table: table), topPadding: true) {
            Section {
                CustomNavigationLink(title: "MusicPodcastsNewsWorkoutsSpecifierName".localize(table: table), status: "ExplicitLabel".localize(table: table), destination: SelectOptionList(title: "MusicPodcastsNewsWorkoutsSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                CustomNavigationLink(title: "MusicVideosSpecifierName".localize(table: table), status: "OnLabel".localize(table: table), destination: SelectOptionList(title: "MusicVideosSpecifierName", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                CustomNavigationLink(title: "MusicProfilesSpecifierName".localize(table: table), status: "OnLabel".localize(table: table), destination: SelectOptionList(title: "Music Videos", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                CustomNavigationLink(title: "MoviesSpecifierName".localize(table: table), status: "AllowAll".localize(table: rateTable), destination: MoviesView())
                CustomNavigationLink(title: "TVSpecifierName".localize(table: table), status: "AllowAll".localize(table: rateTable), destination: TVView())
                CustomNavigationLink(title: "BooksSpecifierName".localize(table: table), status: "ExplicitLabel".localize(table: table), destination: SelectOptionList(title: "BooksSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                CustomNavigationLink(title: "AppsSpecifierName".localize(table: table), status: "17+", destination: AppRestrictionsView())
                CustomNavigationLink(title: "AppClipsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "AppClipsSpecifierName", table: table))
            } header: {
                Text("AllowedContentLabel", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "WebContentSpecifierName".localize(table: table), status: "UnrestrictedAccessSpecifierName".localize(table: table), destination: WebContentView())
            } header: {
                Text("WebContentSpecifierName", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "WebSearchContentSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "Web Search Content", table: table))
                CustomNavigationLink(title: "ExplicitLanguageSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "ExplicitLanguageSpecifierName", table: table))
            } header: {
                Text("SiriLabel", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "MultiplayerGamesSpecifierName".localize(table: table), status: "AllowWithEveryoneSpecifierName".localize(table: table), destination: SelectOptionList(title: "MultiplayerGamesSpecifierName", options: ["DontAllowLabel", "AllowWithFriendsOnlySpecifierName", "AllowWithEveryoneSpecifierName"], selected: "AllowWithEveryoneSpecifierName", table: table))
                CustomNavigationLink(title: "AddingFriendsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "AddingFriendsSpecifierName", table: table))
                CustomNavigationLink(title: "ConnectWithFriendsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "ConnectWithFriendsSpecifierName", table: table))
                CustomNavigationLink(title: "ScreenRecordingSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "ScreenRecordingSpecifierName", table: table))
                CustomNavigationLink(title: "NearbyMultiplayerSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "NearbyMultiplayerSpecifierName", table: table))
                CustomNavigationLink(title: "PrivateMessagingSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "PrivateMessagingSpecifierName", table: table))
                CustomNavigationLink(title: "ProfilePrivacyChangesSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "ProfilePrivacyChangesSpecifierName", table: table))
                CustomNavigationLink(title: "AvatarNicknameChangesSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList(title: "AvatarNicknameChangesSpecifierName", table: table))
            } header: {
                Text("GameCenterLabel", tableName: table)
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        ContentRestrictionsView()
    }
}
