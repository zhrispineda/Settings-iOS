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
                    SettingsLink(color: .white, icon: "appclip", id: "AppClipsSpecifierName".localize(table: table)) {
                        AppClipsView(completeView: false)
                    }
                }
            } footer: {
                switch title {
                case "MediaAppleMusicSpecifierName":
                    Text("MEDIALIBRARY_EXPLANATION", tableName: table)
                case "UserTrackingSpecifierName":
                    Text("USER_TRACKING_EXPLANATION", tableName: table)
                case "SpeechRecognitionSpecifierName":
                    Text("SPEECH_RECOGNITION_FOOTER", tableName: table)
                case "MicrophoneSpecifierName":
                    Text("MICROPHONE_FOOTER", tableName: table)
                case "BluetoothSharingSpecifierName":
                    Text("BT_PERIPHERAL_FOOTER", tableName: table)
                case "PhotosSpecifierName":
                    Text("PHOTOS_NO_APP_FOOTER", tableName: table)
                default:
                    Text("Applications that have requested access to your \(title.lowercased()) will appear here.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentPrivacyRestrictionsDetailView()
    }
}
