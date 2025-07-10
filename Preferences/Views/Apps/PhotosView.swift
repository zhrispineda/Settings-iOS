//
//  PhotosView.swift
//  Preferences
//
//  Settings > Apps > Photos
//

import SwiftUI

struct PhotosView: View {
    @State private var sharedAlbumsEnabled = false
    @State private var usePasscodeEnabled = false
    @State private var showHiddenAlbumEnabled = true
    @State private var showRecents = true
    @State private var autoPlayVideosLivePhotosEnabled = true
    @State private var loopVideos = true
    @State private var showingResetMemoriesAlert = false
    @State private var showingResetMemoriesPopup = false
    @State private var showingResetPeoplePetSuggestionsAlert = false
    @State private var showingResetPeoplePetSuggestionsPopup = false
    @State private var showHolidayEventsEnabled = true
    @State private var showFeaturedContentEnabled = true
    @State private var selected = "TRANSFER_SETTING_AUTOMATIC"
    @State private var enhancedVisualSearch = true
    @State private var spatialPhotosControl = true
    @State private var showingSheet = false
    let options = ["TRANSFER_SETTING_AUTOMATIC", "TRANSFER_SETTING_KEEP_ORIGINALS"]
    let path = "/System/Library/PreferenceBundles/MobileSlideShowSettings.bundle"
    let table = "Photos"

    var body: some View {
        CustomList(title: "PHOTOS_SETTINGS_TITLE".localized(path: path, table: table), topPadding: true) {
            // MARK: Albums
            Section {
                Toggle("SHAREDSTREAMS_MAIN_SWITCH".localized(path: path, table: table), isOn: $sharedAlbumsEnabled)
                    .foregroundStyle(.secondary)
                    .disabled(true)
            } header: {
                Text("ALBUMS_TITLE".localized(path: path, table: table))
            } footer: {
                Text("SHAREDSTREAMS_GROUP_FOOTER_DESCRIPTION".localized(path: path, table: table))
            }
            
            // MARK: Authentication
            Section {
                Toggle("CONTENT_PRIVACY_SWITCH_PASSCODE".localized(path: path, table: table), isOn: $usePasscodeEnabled)
                    .foregroundStyle(.secondary)
                    .disabled(true)
            } footer: {
                Text("CONTENT_PRIVACY_GROUP_FOOTER_DESCRIPTION_PASSCODE".localized(path: path, table: table))
            }
            
            // MARK: Hidden Album
            Section {
                Toggle("HIDDEN_ALBUM_SWITCH".localized(path: path, table: table), isOn: $showHiddenAlbumEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("HIDDEN_ALBUM_GROUP_FOOTER_DESCRIPTION_IPHONE".localized(path: path, table: table))
                } else if UIDevice.iPad {
                    Text("HIDDEN_ALBUM_GROUP_FOOTER_DESCRIPTION_IPAD".localized(path: path, table: table))
                }
            }
            
            // MARK: Recently Viewed & Shared
            Section {
                Toggle("RECENTLY_VIEWED_AND_SHARED_ALBUM_SWITCH".localized(path: path, table: table), isOn: $showRecents)
            } footer: {
                if UIDevice.iPhone {
                    Text("RECENTLY_VIEWED_AND_SHARED_ALBUM_GROUP_FOOTER_DESCRIPTION_IPHONE".localized(path: path, table: table))
                } else if UIDevice.iPad {
                    Text("RECENTLY_VIEWED_AND_SHARED_ALBUM_GROUP_FOOTER_DESCRIPTION_IPAD".localized(path: path, table: table))
                }
            }
            
            // MARK: Auto-Play & Loop
            Section {
                Toggle("AUTOPLAY_SWITCH".localized(path: path, table: table), isOn: $autoPlayVideosLivePhotosEnabled)
                Toggle("AUTOLOOP_VIDEO_SWITCH".localized(path: path, table: table), isOn: $loopVideos)
            }
            
            // MARK: Memories
            Section {
                Button("MEMORIES_RESET_BLACKLISTED_MEMORIES_SETTINGS_ROW_TITLE".localized(path: path, table: table)) {
                    UIDevice.iPhone ? showingResetMemoriesAlert.toggle() : showingResetMemoriesPopup.toggle()
                }
                .confirmationDialog("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_DETAILS".localized(path: path, table: table), isPresented: $showingResetMemoriesAlert, titleVisibility: .visible) {
                    Button("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_TITLE".localized(path: path, table: table), role: .destructive) {}
                    Button("MEMORIES_BLACKLISTED_MEMORIES_CANCEL_ACTION_TITLE".localized(path: path, table: table), role: .cancel) {}
                }
                .alert("MEMORIES_BLACKLISTED_MEMORIES_RESET_ALERT_TITLE".localized(path: path, table: table), isPresented: $showingResetMemoriesPopup) {
                    Button("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_TITLE".localized(path: path, table: table), role: .destructive) {}
                    Button("MEMORIES_BLACKLISTED_MEMORIES_CANCEL_ACTION_TITLE".localized(path: path, table: table), role: .cancel) {}
                } message: {
                    Text("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_DETAILS".localized(path: path, table: table))
                }
                Button("RESET_PEOPLE_FEEDBACK_SETTINGS_ROW_TITLE".localized(path: path, table: table)) {
                    UIDevice.iPhone ? showingResetPeoplePetSuggestionsAlert.toggle() : showingResetPeoplePetSuggestionsPopup.toggle()
                }
                .confirmationDialog("RESET_PEOPLE_FEEDBACK_RESET_ACTION_DETAILS".localized(path: path, table: table), isPresented: $showingResetPeoplePetSuggestionsAlert, titleVisibility: .visible) {
                    Button("RESET_PEOPLE_FEEDBACK_RESET_ACTION_TITLE".localized(path: path, table: table), role: .destructive) {}
                    Button("RESET_PEOPLE_FEEDBACK_CANCEL_ACTION_TITLE".localized(path: path, table: table), role: .cancel) {}
                }
                .alert("RESET_PEOPLE_FEEDBACK_RESET_ACTION_ALERT_TITLE".localized(path: path, table: table), isPresented: $showingResetPeoplePetSuggestionsPopup) {
                    Button("RESET_PEOPLE_FEEDBACK_RESET_ACTION_TITLE".localized(path: path, table: table), role: .destructive) {}
                    Button("RESET_PEOPLE_FEEDBACK_CANCEL_ACTION_TITLE".localized(path: path, table: table), role: .cancel) {}
                } message: {
                    Text("RESET_PEOPLE_FEEDBACK_RESET_ACTION_DETAILS".localized(path: path, table: table))
                }
                Toggle("MEMORIES_HOLIDAY_CALENDAR_EVENTS_SWITCH".localized(path: path, table: table), isOn: $showHolidayEventsEnabled)
            } header: {
                Text("MEMORIES_TITLE".localized(path: path, table: table))
            } footer: {
                Text("MEMORIES_HOLIDAY_CALENDAR_EVENTS_SWITCH_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Featured Content
            Section {
                Toggle("SHOW_FEATURED_CONTENT_SETTINGS_TITLE".localized(path: path, table: table), isOn: $showFeaturedContentEnabled)
            } header: {
                Text("SHOW_FEATURED_CONTENT_SETTINGS_SWITCH".localized(path: path, table: table))
            } footer: {
                Text("SHOW_FEATURED_CONTENT_SETTINGS_SWITCH_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Transfer to Mac or PC
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("TRANSFER_SETTINGS_TITLE".localized(path: path, table: table))
            } footer: {
                Text("TRANSFER_SETTINGS_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Enhanced Visual Search
            Section {
                Toggle("ENHANCED_VISUAL_SEARCH_SWITCH_TITLE".localized(path: path, table: table), isOn: $enhancedVisualSearch)
            } footer: {
                Text("ENHANCED_VISUAL_SEARCH_FOOTER_DESCRIPTION".localized(path: path, table: table))
            }
            
            // MARK: Spatial Photos and Videos
            Section {
                Toggle("ALCHEMIZE_BUTTON_SETTINGS_SWITCH".localized(path: path, table: table), isOn: $spatialPhotosControl)
            } header: {
                Text("SPATIAL_SETTINGS_TITLE".localized(path: path, table: table))
            } footer: {
                Text("ALCHEMIZE_BUTTON_SETTINGS_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Privacy Footer
            Section {} footer: {
                Text("[\("BUTTON_TITLE".localized(path: "/System/Library/OnBoardingBundles/com.apple.onboarding.photos.bundle", table: "Photos"))](pref://)")
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.photos")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView()
    }
}
