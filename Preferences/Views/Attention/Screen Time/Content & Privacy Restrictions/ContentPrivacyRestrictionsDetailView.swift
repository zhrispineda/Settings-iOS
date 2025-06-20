//
//  ContentPrivacyRestrictionsDetailView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > [Selection]
//

import SwiftUI

struct ContentPrivacyRestrictionsDetailView: View {
    // Variables
    var title = String()
    @State private var selected = "AllowChangesSpecifierName"
    let options = ["AllowChangesSpecifierName", "DontAllowChangesSpecifierName"]
    let table = "Restrictions"
    let privTable = "Privacy"
    
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
                        Text("NO_ITEMS", tableName: "LocalizedStrings")
                            .foregroundStyle(.secondary)
                    }
                    .padding(3)
                } footer: {
                    Text("PHOTOS_AUTH_PHOTOKIT_FOOTER", tableName: privTable)
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
                    Text("CONTACTS_FOOTER", tableName: privTable)
                case "CalendarsSpecifierName":
                    Text("CALENDARS_FOOTER", tableName: privTable)
                case "RemindersSpecifierName":
                    Text("REMINDERS_FOOTER", tableName: privTable)
                case "MediaAppleMusicSpecifierName":
                    Text("MEDIALIBRARY_EXPLANATION", tableName: privTable)
                case "UserTrackingSpecifierName":
                    Text("USER_TRACKING_EXPLANATION", tableName: privTable)
                case "SpeechRecognitionSpecifierName":
                    Text("SPEECH_RECOGNITION_FOOTER", tableName: privTable)
                case "MicrophoneSpecifierName":
                    Text("MICROPHONE_FOOTER", tableName: privTable)
                case "BluetoothSharingSpecifierName":
                    Text("BT_PERIPHERAL_FOOTER", tableName: privTable)
                case "PhotosSpecifierName":
                    Text("PHOTOS_NO_APP_FOOTER", tableName: privTable)
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
