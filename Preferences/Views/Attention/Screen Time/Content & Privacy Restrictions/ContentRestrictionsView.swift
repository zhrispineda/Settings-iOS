//
//  ContentRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions
//

import SwiftUI

struct ContentRestrictionsView: View {
    @State private var musicPodcastsNewsWorkoutsSelection = "ExplicitLabel"
    @State private var musicVideoSelection = "OnLabel"
    @State private var musicProfileSelection = "OnLabel"
    @State private var explicitSelection = "ExplicitLabel"
    @State private var appClipsSelection = "AppClipsSpecifierName"
    @State private var webSearchSelection = "Allow"
    @State private var explicitLanguageSelection = "Allow"
    @State private var multiplayerSelection = "AllowWithEveryoneSpecifierName"
    @State private var addingFriendSelection = "Allow"
    @State private var screenRecordingSelection = "Allow"
    @State private var nearbyMultiplayerSelection = "Allow"
    @State private var privateMessagingSelection = "Allow"
    @State private var profilePrivacySelection = "Allow"
    @State private var avatarNicknameSelection = "Allow"
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    let rateTable = "RatingProviders"
    
    var body: some View {
        CustomList(title: "ContentRestrictionsSpecifierName".localized(path: path, table: table), topPadding: true) {
            Section {
                SettingsLink("MusicPodcastsNewsWorkoutsSpecifierName".localized(path: path, table: table), status: "ExplicitLabel".localized(path: path, table: table), destination: SelectOptionList("MusicPodcastsNewsWorkoutsSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: $musicPodcastsNewsWorkoutsSelection, table: table))
                SettingsLink("MusicVideosSpecifierName".localized(path: path, table: table), status: "OnLabel".localized(path: path, table: table), destination: SelectOptionList("MusicVideosSpecifierName", options: ["OffLabel", "OnLabel"], selected: $musicVideoSelection, table: table))
                SettingsLink("MusicProfilesSpecifierName".localized(path: path, table: table), status: "OnLabel".localized(path: path, table: table), destination: SelectOptionList("Music Videos", options: ["OffLabel", "OnLabel"], selected: $musicProfileSelection, table: table))
                SettingsLink("MoviesSpecifierName".localized(path: path, table: table), status: "AllowAll".localized(path: path, table: rateTable), destination: MoviesView())
                SettingsLink("TVSpecifierName".localize(table: table), status: "AllowAll".localized(path: path, table: rateTable), destination: TVView())
                SettingsLink("BooksSpecifierName".localized(path: path, table: table), status: "ExplicitLabel".localized(path: path, table: table), destination: SelectOptionList("BooksSpecifierName", options: ["CleanLabel", "ExplicitLabel"], selected: $explicitSelection, table: table))
                SettingsLink("AppsSpecifierName".localized(path: path, table: table), status: "17+", destination: AppRestrictionsView())
                SettingsLink("AppClipsSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("AppClipsSpecifierName", selected: $appClipsSelection, table: table))
            } header: {
                Text("AllowedContentLabel".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("WebContentSpecifierName".localized(path: path, table: table), status: "UnrestrictedAccessSpecifierName".localized(path: path, table: table), destination: WebContentView())
            } header: {
                Text("WebContentSpecifierName".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("WebSearchContentSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("Web Search Content", selected: $webSearchSelection, table: table))
                SettingsLink("ExplicitLanguageSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ExplicitLanguageSpecifierName", selected: $explicitLanguageSelection, table: table))
            } header: {
                Text("SiriLabel".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("MultiplayerGamesSpecifierName".localized(path: path, table: table), status: "AllowWithEveryoneSpecifierName".localized(path: path, table: table), destination: SelectOptionList("MultiplayerGamesSpecifierName", options: ["DontAllowLabel", "AllowWithFriendsOnlySpecifierName", "AllowWithEveryoneSpecifierName"], selected: $multiplayerSelection, table: table))
                SettingsLink("AddingFriendsSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("AddingFriendsSpecifierName", selected: $addingFriendSelection, table: table))
                SettingsLink("ConnectWithFriendsSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ConnectWithFriendsSpecifierName", selected: $addingFriendSelection, table: table))
                SettingsLink("ScreenRecordingSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ScreenRecordingSpecifierName", selected: $screenRecordingSelection, table: table))
                SettingsLink("NearbyMultiplayerSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("NearbyMultiplayerSpecifierName", selected: $nearbyMultiplayerSelection, table: table))
                SettingsLink("PrivateMessagingSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("PrivateMessagingSpecifierName", selected: $privateMessagingSelection, table: table))
                SettingsLink("ProfilePrivacyChangesSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("ProfilePrivacyChangesSpecifierName", selected: $profilePrivacySelection, table: table))
                SettingsLink("AvatarNicknameChangesSpecifierName".localized(path: path, table: table), status: "Allow".localized(path: path, table: table), destination: SelectOptionList("AvatarNicknameChangesSpecifierName", selected: $avatarNicknameSelection, table: table))
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
