//
//  PhotosView.swift
//  Preferences
//
//  Settings > Apps > Photos
//

import SwiftUI

struct PhotosView: View {
    // Variables
    @State private var sharedAlbumsEnabled = false
    @State private var usePasscodeEnabled = true
    @State private var showHiddenAlbumEnabled = true
    @State private var autoPlayVideosLivePhotosEnabled = true
    @State private var showingResetMemoriesAlert = false
    @State private var showingResetMemoriesPopup = false
    @State private var showingResetPeoplePetSuggestionsAlert = false
    @State private var showingResetPeoplePetSuggestionsPopup = false
    @State private var showHolidayEventsEnabled = true
    @State private var showFeaturedContentEnabled = true
    @State private var selected = "TRANSFER_SETTING_AUTOMATIC"
    @State private var showingSheet = false
    let options = ["TRANSFER_SETTING_AUTOMATIC", "TRANSFER_SETTING_KEEP_ORIGINALS"]
    let table = "Photos"
    
    var body: some View {
        CustomList(title: "PHOTOS_SETTINGS_TITLE".localize(table: table), topPadding: true) {
            PermissionsView(appName: "PHOTOS_SETTINGS_TITLE".localize(table: table), cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("SHAREDSTREAMS_MAIN_SWITCH".localize(table: table), isOn: $sharedAlbumsEnabled)
                    .disabled(true)
            } header: {
                Text("ALBUMS_TITLE", tableName: table)
            } footer: {
                Text("SHAREDSTREAMS_GROUP_FOOTER_DESCRIPTION", tableName: table)
            }
            
            Section {
                Toggle("CONTENT_PRIVACY_SWITCH_PASSCODE".localize(table: table), isOn: $usePasscodeEnabled)
            } footer: {
                Text("CONTENT_PRIVACY_GROUP_FOOTER_DESCRIPTION_PASSCODE", tableName: table)
            }
            
            Section {
                Toggle("HIDDEN_ALBUM_SWITCH".localize(table: table), isOn: $showHiddenAlbumEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("HIDDEN_ALBUM_GROUP_FOOTER_DESCRIPTION_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("HIDDEN_ALBUM_GROUP_FOOTER_DESCRIPTION_IPAD", tableName: table)
                }
            }
            
            Section {
                Toggle("AUTOPLAY_SWITCH".localize(table: table), isOn: $autoPlayVideosLivePhotosEnabled)
            }
            
            Section {
                Button("MEMORIES_RESET_BLACKLISTED_MEMORIES_SETTINGS_ROW_TITLE".localize(table: table)) {
                    UIDevice.iPhone ? showingResetMemoriesAlert.toggle() : showingResetMemoriesPopup.toggle()
                }
                .confirmationDialog("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_DETAILS".localize(table: table), isPresented: $showingResetMemoriesAlert, titleVisibility: .visible) {
                    Button("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_TITLE".localize(table: table), role: .destructive) {}
                    Button("MEMORIES_BLACKLISTED_MEMORIES_CANCEL_ACTION_TITLE".localize(table: table), role: .cancel) {}
                }
                .alert("MEMORIES_BLACKLISTED_MEMORIES_RESET_ALERT_TITLE".localize(table: table), isPresented: $showingResetMemoriesPopup) {
                    Button("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_TITLE".localize(table: table), role: .destructive) {}
                    Button("MEMORIES_BLACKLISTED_MEMORIES_CANCEL_ACTION_TITLE".localize(table: table), role: .cancel) {}
                } message: {
                    Text("MEMORIES_BLACKLISTED_MEMORIES_RESET_ACTION_DETAILS", tableName: table)
                }
                Button("RESET_PEOPLE_FEEDBACK_SETTINGS_ROW_TITLE".localize(table: table)) {
                    UIDevice.iPhone ? showingResetPeoplePetSuggestionsAlert.toggle() : showingResetPeoplePetSuggestionsPopup.toggle()
                }
                .confirmationDialog("RESET_PEOPLE_FEEDBACK_RESET_ACTION_DETAILS".localize(table: table), isPresented: $showingResetPeoplePetSuggestionsAlert, titleVisibility: .visible) {
                    Button("RESET_PEOPLE_FEEDBACK_RESET_ACTION_TITLE".localize(table: table), role: .destructive) {}
                    Button("RESET_PEOPLE_FEEDBACK_CANCEL_ACTION_TITLE".localize(table: table), role: .cancel) {}
                }
                .alert("RESET_PEOPLE_FEEDBACK_RESET_ACTION_ALERT_TITLE".localize(table: table), isPresented: $showingResetPeoplePetSuggestionsPopup) {
                    Button("RESET_PEOPLE_FEEDBACK_RESET_ACTION_TITLE".localize(table: table), role: .destructive) {}
                    Button("RESET_PEOPLE_FEEDBACK_CANCEL_ACTION_TITLE".localize(table: table), role: .cancel) {}
                } message: {
                    Text("RESET_PEOPLE_FEEDBACK_RESET_ACTION_DETAILS", tableName: table)
                }
                Toggle("MEMORIES_HOLIDAY_CALENDAR_EVENTS_SWITCH".localize(table: table), isOn: $showHolidayEventsEnabled)
            } header: {
                Text("MEMORIES_TITLE", tableName: table)
            } footer: {
                Text("MEMORIES_HOLIDAY_CALENDAR_EVENTS_SWITCH_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("SHOW_FEATURED_CONTENT_SETTINGS_TITLE".localize(table: table), isOn: $showFeaturedContentEnabled)
            } header: {
                Text("SHOW_FEATURED_CONTENT_SETTINGS_SWITCH", tableName: table)
            } footer: {
                Text("SHOW_FEATURED_CONTENT_SETTINGS_SWITCH_FOOTER", tableName: table)
            }
            
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("TRANSFER_SETTINGS_TITLE", tableName: table)
            } footer: {
                Text("TRANSFER_SETTINGS_FOOTER", tableName: table)
            }
            
            Section {} footer: {
                Text("[\("BUTTON_TITLE".localize(table: "OBPhotos"))](photosSettingsOBK://)")
                    .onOpenURL { url in
                        if url.scheme == "photosSettingsOBK" {
                            showingSheet = true
                        }
                    }
                    .sheet(isPresented: $showingSheet) {
                        OnBoardingView(table: "OBPhotos")
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView()
    }
}
