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
                SettingsLink("MusicPodcastsNewsWorkoutsSpecifierName".localize(table: table), status: "ExplicitLabel".localize(table: table), destination: SelectOptionList("MusicPodcastsNewsWorkoutsSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                SettingsLink("MusicVideosSpecifierName".localize(table: table), status: "OnLabel".localize(table: table), destination: SelectOptionList("MusicVideosSpecifierName", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                SettingsLink("MusicProfilesSpecifierName".localize(table: table), status: "OnLabel".localize(table: table), destination: SelectOptionList("Music Videos", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                SettingsLink("MoviesSpecifierName".localize(table: table), status: "AllowAll".localize(table: rateTable), destination: MoviesView())
                SettingsLink("TVSpecifierName".localize(table: table), status: "AllowAll".localize(table: rateTable), destination: TVView())
                SettingsLink("BooksSpecifierName".localize(table: table), status: "ExplicitLabel".localize(table: table), destination: SelectOptionList("BooksSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                SettingsLink("AppsSpecifierName".localize(table: table), status: "17+", destination: AppRestrictionsView())
                SettingsLink("AppClipsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("AppClipsSpecifierName", table: table))
            } header: {
                Text("AllowedContentLabel", tableName: table)
            }
            
            Section {
                SettingsLink("WebContentSpecifierName".localize(table: table), status: "UnrestrictedAccessSpecifierName".localize(table: table), destination: WebContentView())
            } header: {
                Text("WebContentSpecifierName", tableName: table)
            }
            
            Section {
                SettingsLink("WebSearchContentSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("Web Search Content", table: table))
                SettingsLink("ExplicitLanguageSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ExplicitLanguageSpecifierName", table: table))
            } header: {
                Text("SiriLabel", tableName: table)
            }
            
            Section {
                SettingsLink("MultiplayerGamesSpecifierName".localize(table: table), status: "AllowWithEveryoneSpecifierName".localize(table: table), destination: SelectOptionList("MultiplayerGamesSpecifierName", options: ["DontAllowLabel", "AllowWithFriendsOnlySpecifierName", "AllowWithEveryoneSpecifierName"], selected: "AllowWithEveryoneSpecifierName", table: table))
                SettingsLink("AddingFriendsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("AddingFriendsSpecifierName", table: table))
                SettingsLink("ConnectWithFriendsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ConnectWithFriendsSpecifierName", table: table))
                SettingsLink("ScreenRecordingSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ScreenRecordingSpecifierName", table: table))
                SettingsLink("NearbyMultiplayerSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("NearbyMultiplayerSpecifierName", table: table))
                SettingsLink("PrivateMessagingSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("PrivateMessagingSpecifierName", table: table))
                SettingsLink("ProfilePrivacyChangesSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ProfilePrivacyChangesSpecifierName", table: table))
                SettingsLink("AvatarNicknameChangesSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("AvatarNicknameChangesSpecifierName", table: table))
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
