//
//  ContentRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions
//

import SwiftUI

struct ContentRestrictionsView: View {
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    let rateTable = "RatingProviders"
    
    var body: some View {
        CustomList(title: "ContentRestrictionsSpecifierName".localized(path: path, table: table), topPadding: true) {
            Section {
                SettingsLink("MusicPodcastsNewsWorkoutsSpecifierName".localized(path: path, table: table), status: "ExplicitLabel".localized(path: path, table: table), destination: SelectOptionList("MusicPodcastsNewsWorkoutsSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                SettingsLink("MusicVideosSpecifierName".localized(path: path, table: table), status: "OnLabel".localized(path: path, table: table), destination: SelectOptionList("MusicVideosSpecifierName", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                SettingsLink("MusicProfilesSpecifierName".localized(path: path, table: table), status: "OnLabel".localized(path: path, table: table), destination: SelectOptionList("Music Videos", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                SettingsLink("MoviesSpecifierName".localized(path: path, table: table), status: "AllowAll".localized(path: path, table: rateTable), destination: MoviesView())
                SettingsLink("TVSpecifierName".localize(table: table), status: "AllowAll".localized(path: path, table: rateTable), destination: TVView())
                SettingsLink("BooksSpecifierName".localized(path: path, table: table), status: "ExplicitLabel".localized(path: path, table: table), destination: SelectOptionList("BooksSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                SettingsLink("AppsSpecifierName".localized(path: path, table: table), status: "17+", destination: AppRestrictionsView())
                SettingsLink("AppClipsSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("AppClipsSpecifierName", table: table))
            } header: {
                Text("AllowedContentLabel".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("WebContentSpecifierName".localized(path: path, table: table), status: "UnrestrictedAccessSpecifierName".localized(path: path, table: table), destination: WebContentView())
            } header: {
                Text("WebContentSpecifierName".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("WebSearchContentSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("Web Search Content", table: table))
                SettingsLink("ExplicitLanguageSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ExplicitLanguageSpecifierName", table: table))
            } header: {
                Text("SiriLabel".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("MultiplayerGamesSpecifierName".localized(path: path, table: table), status: "AllowWithEveryoneSpecifierName".localized(path: path, table: table), destination: SelectOptionList("MultiplayerGamesSpecifierName", options: ["DontAllowLabel", "AllowWithFriendsOnlySpecifierName", "AllowWithEveryoneSpecifierName"], selected: "AllowWithEveryoneSpecifierName", table: table))
                SettingsLink("AddingFriendsSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("AddingFriendsSpecifierName", table: table))
                SettingsLink("ConnectWithFriendsSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ConnectWithFriendsSpecifierName", table: table))
                SettingsLink("ScreenRecordingSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ScreenRecordingSpecifierName", table: table))
                SettingsLink("NearbyMultiplayerSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("NearbyMultiplayerSpecifierName", table: table))
                SettingsLink("PrivateMessagingSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("PrivateMessagingSpecifierName", table: table))
                SettingsLink("ProfilePrivacyChangesSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ProfilePrivacyChangesSpecifierName", table: table))
                SettingsLink("AvatarNicknameChangesSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("AvatarNicknameChangesSpecifierName", table: table))
            } header: {
                Text("GameCenterLabel".localized(path: path, table: table))
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        ContentRestrictionsView()
    }
}
