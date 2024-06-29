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
    @State private var selected = "Automatic"
    let options = ["Automatic", "Keep Originals"]
    
    var body: some View {
        CustomList(title: "Photos") {
            PermissionsView(appName: "Photos", cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("Shared Albums", isOn: $sharedAlbumsEnabled)
                    .disabled(true)
            } header: {
                Text("Albums")
            } footer: {
                Text("Create albums to share with other people, and subscribe to other people‘s shared albums.")
            }
            
            Section {
                Toggle("Use Passcode", isOn: $usePasscodeEnabled)
            } footer: {
                Text("Your password is required to view the Hidden and Recently Deleted albums.")
            }
            
            Section {
                Toggle("Show Hidden Album", isOn: $showHiddenAlbumEnabled)
            } footer: {
                Text("The Hidden album will appear in the Albums tab, under Utilities.")
            }
            
            Section {
                Toggle("Auto-Play Videos and Live Photos", isOn: $autoPlayVideosLivePhotosEnabled)
            }
            
            Section {
                Button("Reset Suggested Memories") {
                    Device().isPhone ? showingResetMemoriesAlert.toggle() : showingResetMemoriesPopup.toggle()
                }
                .confirmationDialog("Resetting will allow previously blocked places, dates, or holidays to once again be included in new Memories.", isPresented: $showingResetMemoriesAlert, titleVisibility: .visible) {
                    Button("Reset", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                }
                .alert("Reset", isPresented: $showingResetMemoriesPopup) {
                    Button("Reset", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Resetting will allow previously blocked places, dates, or holidays to once again be included in new Memories.")
                }
                Button("Reset People & Pets Suggestions") {
                    Device().isPhone ? showingResetPeoplePetSuggestionsAlert.toggle() : showingResetPeoplePetSuggestionsPopup.toggle()
                }
                .confirmationDialog("Resetting will allow people and pets suggested less to once again be fully included in new Memories and Featured Photos.", isPresented: $showingResetPeoplePetSuggestionsAlert, titleVisibility: .visible) {
                    Button("Reset", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                }
                .alert("Reset", isPresented: $showingResetPeoplePetSuggestionsPopup) {
                    Button("Reset", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Resetting will allow people and pets suggested less to once again be fully included in new Memories and Featured Photos.")
                }
                Toggle("Show Holiday Events", isOn: $showHolidayEventsEnabled)
            } header: {
                Text("Memories")
            } footer: {
                Text("You can choose to see timely holiday events and those for your home country or region.")
            }
            
            Section {
                Toggle("Show Featured Content", isOn: $showFeaturedContentEnabled)
            } header: {
                Text("Memories & Featured Photos")
            } footer: {
                Text("Allow Featured Photos and Memories to automatically appear on this device in places such as For You and Search in Photos, and in Widgets.")
            }
            
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Transfer to Mac or PC")
            } footer: {
                Text("Automatically transfer photos and videos in a compatible format, or always transfer the original file without checking for compatability.")
            }
            
            Section {} footer: {
                Text("[About Photos & Privacy...](#)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhotosView()
    }
}
