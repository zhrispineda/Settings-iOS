//
//  ContentRestrictionsView.swift
//  Preferences
//

import SwiftUI

/// View for Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions
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
    private let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    private let table = "Restrictions"
    private let rateTable = "RatingProviders"
    
    var body: some View {
        CustomList(title: "ContentRestrictionsSpecifierName".localized(path: path, table: table), topPadding: true) {
            Section {
                SLink(
                    "MusicPodcastsNewsWorkoutsSpecifierName".localized(path: path, table: table),
                    status: "ExplicitLabel".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "MusicPodcastsNewsWorkoutsSpecifierName",
                        options: ["CleanLabel", "ExplicitLabel"],
                        selected: $musicPodcastsNewsWorkoutsSelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "MusicVideosSpecifierName".localized(path: path, table: table),
                    status: "OnLabel".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "MusicVideosSpecifierName",
                        options: ["OffLabel", "OnLabel"],
                        selected: $musicVideoSelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "MusicProfilesSpecifierName".localized(path: path, table: table),
                    status: "OnLabel".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "Music Videos",
                        options: ["OffLabel", "OnLabel"],
                        selected: $musicProfileSelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "MoviesSpecifierName".localized(path: path, table: table),
                    status: "AllowAll".localized(path: path, table: rateTable),
                    destination: MoviesView()
                )
                SLink(
                    "TVSpecifierName".localized(path: path, table: table),
                    status: "AllowAll".localized(path: path, table: rateTable),
                    destination: TVView()
                )
                SLink(
                    "BooksSpecifierName".localized(path: path, table: table),
                    status: "ExplicitLabel".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "BooksSpecifierName",
                        options: ["CleanLabel", "ExplicitLabel"],
                        selected: $explicitSelection,
                        path: path,
                        table: table
                    )
                )
                SLink(
                    "AppsSpecifierName".localized(path: path, table: table),
                    status: "17+",
                    destination: AppRestrictionsView()
                )
                SLink(
                    "AppClipsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "AppClipsSpecifierName",
                        selected: $appClipsSelection,
                        path: path,
                        table: table)
                )
            } header: {
                Text("AllowedContentLabel".localized(path: path, table: table))
            }
            
            Section {
                SLink(
                    "WebContentSpecifierName".localized(path: path, table: table),
                    status: "UnrestrictedAccessSpecifierName".localized(path: path, table: table),
                    destination: WebContentView()
                )
            } header: {
                Text("WebContentSpecifierName".localized(path: path, table: table))
            }
            
            Section {
                SLink(
                    "WebSearchContentSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "Web Search Content",
                        selected: $webSearchSelection,
                        table: table
                    )
                )
                SLink(
                    "ExplicitLanguageSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "ExplicitLanguageSpecifierName",
                        selected: $explicitLanguageSelection,
                        table: table
                    )
                )
            } header: {
                Text("SiriLabel".localized(path: path, table: table))
            }
            
            Section {
                SLink(
                    "MultiplayerGamesSpecifierName".localized(path: path, table: table),
                    status: "AllowWithEveryoneSpecifierName".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "MultiplayerGamesSpecifierName",
                        options: ["DontAllowLabel", "AllowWithFriendsOnlySpecifierName", "AllowWithEveryoneSpecifierName"],
                        selected: $multiplayerSelection,
                        table: table
                    )
                )
                SLink(
                    "AddingFriendsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "AddingFriendsSpecifierName",
                        selected: $addingFriendSelection,
                        table: table
                    )
                )
                SLink(
                    "ConnectWithFriendsSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "ConnectWithFriendsSpecifierName",
                        selected: $addingFriendSelection,
                        table: table
                    )
                )
                SLink(
                    "ScreenRecordingSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "ScreenRecordingSpecifierName",
                        selected: $screenRecordingSelection,
                        table: table
                    )
                )
                SLink(
                    "NearbyMultiplayerSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "NearbyMultiplayerSpecifierName",
                        selected: $nearbyMultiplayerSelection,
                        table: table
                    )
                )
                SLink(
                    "PrivateMessagingSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "PrivateMessagingSpecifierName",
                        selected: $privateMessagingSelection,
                        table: table
                    )
                )
                SLink(
                    "ProfilePrivacyChangesSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "ProfilePrivacyChangesSpecifierName",
                        selected: $profilePrivacySelection,
                        table: table
                    )
                )
                SLink(
                    "AvatarNicknameChangesSpecifierName".localized(path: path, table: table),
                    status: "Allow".localized(path: path, table: table),
                    destination: SelectOptionList(
                        "AvatarNicknameChangesSpecifierName",
                        selected: $avatarNicknameSelection,
                        table: table
                    )
                )
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
