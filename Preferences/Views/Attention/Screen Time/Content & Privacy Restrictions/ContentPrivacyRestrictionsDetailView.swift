//
//  ContentPrivacyRestrictionsDetailView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > [Selection]
//

import SwiftUI

struct ContentPrivacyRestrictionsDetailView: View {
    @State private var selected = "AllowChangesSpecifierName"
    var title = ""
    let options = ["AllowChangesSpecifierName", "DontAllowChangesSpecifierName"]
    let table = "Restrictions"
    let privacy = "/System/Library/PreferenceBundles/PrivacyAndSecuritySettings.bundle"
    
    var body: some View {
        CustomList(title: title.localize(table: table)) {
            Section {
                Picker("AllowChangesLabel".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                switch title {
                case "ContactsSpecifierName":
                    Text("CONTACTS_EXPLANATION", tableName: table)
                case "CalendarsSpecifierName":
                    Text("CALENDARS_EXPLANATION", tableName: table)
                case "RemindersSpecifierName":
                    Text("REMINDERS_EXPLANATION", tableName: table)
                case "PhotosSpecifierName":
                    Text("PHOTOS_EXPLANATION", tableName: table)
                case "MediaAppleMusicSpecifierName":
                    Text("MEDIALIBRARY_EXPLANATION", tableName: table)
                case "UserTrackingSpecifierName":
                    Text("USER_TRACKING_EXPLANATION", tableName: table)
                case "SpeechRecognitionSpecifierName":
                    Text("SPEECH_RECOGNITION_EXPLANATION", tableName: table)
                case "MicrophoneSpecifierName":
                    Text("MICROPHONE_EXPLANATION", tableName: table)
                case "BluetoothSharingSpecifierName":
                    Text("BT_PERIPHERAL_EXPLANATION", tableName: table)
                default:
                    Text("Disallowing changes locks the settings shown below and prevents new apps from using your \(title.lowercased()).")
                }
            }
            
            if title == "PhotosSpecifierName" {
                Section {
                    VStack(alignment: .leading) {
                        Text("Full Photo Library Access")
                            .fontWeight(.semibold)
                        Text("PLLocalizedCountDescriptionNoItemsTitleCase".localized(path: "/System/Library/PrivateFrameworks/PhotoLibraryServicesCore.framework", table: "AssetsLibraryServices"))
                            .foregroundStyle(.secondary)
                    }
                    .padding(3)
                } footer: {
                    Text("PHOTOS_AUTH_PHOTOKIT_FOOTER".localized(path: "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework", table: "Privacy"))
                }
            }
            
            Section {
                if title == "BluetoothSharingSpecifierName" || title == "MicrophoneSpecifierName" {
                    SLink("AppClipsSpecifierName".localize(table: table), icon: "com.apple.graphic-icon.app-clips") {
                        AppClipsView(completeView: false, permission: title)
                    }
                }
            } footer: {
                switch title {
                case "ContactsSpecifierName":
                    Text("CONTACTS_FOOTER".localized(path: privacy))
                case "CalendarsSpecifierName":
                    Text("CALENDARS_FOOTER".localized(path: privacy))
                case "RemindersSpecifierName":
                    Text("REMINDERS_FOOTER".localized(path: privacy))
                case "MediaAppleMusicSpecifierName":
                    Text("MEDIALIBRARY_EXPLANATION".localized(path: privacy))
                case "UserTrackingSpecifierName":
                    Text("USER_TRACKING_EXPLANATION".localized(path: privacy))
                case "SpeechRecognitionSpecifierName":
                    Text("SPEECH_RECOGNITION_FOOTER".localized(path: privacy))
                case "MicrophoneSpecifierName":
                    Text("MICROPHONE_FOOTER".localized(path: privacy))
                case "BluetoothSharingSpecifierName":
                    Text("BT_PERIPHERAL_FOOTER".localized(path: privacy))
                case "PhotosSpecifierName":
                    Text("PHOTOS_NO_APP_FOOTER".localized(path: privacy))
                default:
                    Text("Applications that have requested access to your \(title.lowercased()) will appear here.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentPrivacyRestrictionsDetailView(title: "Example")
    }
}
