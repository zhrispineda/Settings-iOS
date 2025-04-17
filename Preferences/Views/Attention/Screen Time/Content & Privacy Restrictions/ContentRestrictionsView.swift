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
                CustomNavigationLink("MusicPodcastsNewsWorkoutsSpecifierName".localize(table: table), status: "ExplicitLabel".localize(table: table), destination: SelectOptionList("MusicPodcastsNewsWorkoutsSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                CustomNavigationLink("MusicVideosSpecifierName".localize(table: table), status: "OnLabel".localize(table: table), destination: SelectOptionList("MusicVideosSpecifierName", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                CustomNavigationLink("MusicProfilesSpecifierName".localize(table: table), status: "OnLabel".localize(table: table), destination: SelectOptionList("Music Videos", options: ["OffLabel", "OnLabel"], selected: "OnLabel", table: table))
                CustomNavigationLink("MoviesSpecifierName".localize(table: table), status: "AllowAll".localize(table: rateTable), destination: MoviesView())
                CustomNavigationLink("TVSpecifierName".localize(table: table), status: "AllowAll".localize(table: rateTable), destination: TVView())
                CustomNavigationLink("BooksSpecifierName".localize(table: table), status: "ExplicitLabel".localize(table: table), destination: SelectOptionList("BooksSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: "ExplicitLabel", table: table))
                CustomNavigationLink("AppsSpecifierName".localize(table: table), status: "17+", destination: AppRestrictionsView())
                CustomNavigationLink("AppClipsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("AppClipsSpecifierName", table: table))
            } header: {
                Text("AllowedContentLabel", tableName: table)
            }
            
            Section {
                CustomNavigationLink("WebContentSpecifierName".localize(table: table), status: "UnrestrictedAccessSpecifierName".localize(table: table), destination: WebContentView())
            } header: {
                Text("WebContentSpecifierName", tableName: table)
            }
            
            Section {
                CustomNavigationLink("WebSearchContentSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("Web Search Content", table: table))
                CustomNavigationLink("ExplicitLanguageSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ExplicitLanguageSpecifierName", table: table))
            } header: {
                Text("SiriLabel", tableName: table)
            }
            
            Section {
                CustomNavigationLink("MultiplayerGamesSpecifierName".localize(table: table), status: "AllowWithEveryoneSpecifierName".localize(table: table), destination: SelectOptionList("MultiplayerGamesSpecifierName", options: ["DontAllowLabel", "AllowWithFriendsOnlySpecifierName", "AllowWithEveryoneSpecifierName"], selected: "AllowWithEveryoneSpecifierName", table: table))
                CustomNavigationLink("AddingFriendsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("AddingFriendsSpecifierName", table: table))
                CustomNavigationLink("ConnectWithFriendsSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ConnectWithFriendsSpecifierName", table: table))
                CustomNavigationLink("ScreenRecordingSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ScreenRecordingSpecifierName", table: table))
                CustomNavigationLink("NearbyMultiplayerSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("NearbyMultiplayerSpecifierName", table: table))
                CustomNavigationLink("PrivateMessagingSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("PrivateMessagingSpecifierName", table: table))
                CustomNavigationLink("ProfilePrivacyChangesSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("ProfilePrivacyChangesSpecifierName", table: table))
                CustomNavigationLink("AvatarNicknameChangesSpecifierName".localize(table: table), status: "Allow".localize(table: table), destination: SelectOptionList("AvatarNicknameChangesSpecifierName", table: table))
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
