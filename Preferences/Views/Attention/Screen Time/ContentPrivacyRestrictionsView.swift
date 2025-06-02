//
//  ContentPrivacyRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions
//

import SwiftUI

struct ContentPrivacyRestrictionsView: View {
    // Variables
    @State private var contentPrivacyRestrictionsEnabled = false
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "ContentPrivacySpecifierName".localize(table: table)) {
            Section {
                Toggle("ContentPrivacySpecifierName".localize(table: table), isOn: $contentPrivacyRestrictionsEnabled)
            }
            
            Section {
                NavigationLink("AppsInstallationsAndPurchasesSpecifierName".localize(table: table), destination: AppInstallationsPurchasesView())
                NavigationLink("AllowedAppsSpecifierName".localize(table: table), destination: AllowedAppsView())
                NavigationLink("ContentRestrictionsSpecifierName".localize(table: table), destination: ContentRestrictionsView())
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                SettingsLink("LocationServicesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: RestrictionsLocationServicesView())
                SettingsLink("ContactsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "ContactsSpecifierName"))
                SettingsLink("CalendarsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "CalendarsSpecifierName"))
                SettingsLink("RemindersSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "RemindersSpecifierName"))
                SettingsLink("PhotosSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "PhotosSpecifierName"))
                SettingsLink("ShareLocationSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("ShareLocationSpecifierName", table: table))
                SettingsLink("BluetoothSharingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "BluetoothSharingSpecifierName"))
                SettingsLink("MicrophoneSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MicrophoneSpecifierName"))
                SettingsLink("SpeechRecognitionSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "SpeechRecognitionSpecifierName"))
                SettingsLink("AdvertisingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("AdvertisingSpecifierName", table: table))
                SettingsLink("UserTrackingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "UserTrackingSpecifierName"))
                SettingsLink("MediaAppleMusicSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MediaAppleMusicSpecifierName"))
            } header: {
                Text("PrivacySpecifierName", tableName: table)
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                SettingsLink("PasscodeChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("PasscodeChangesSpecifierName", table: table))
                SettingsLink("AccountChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("AccountChangesSpecifierName", table: table))
                SettingsLink("CellularChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("CellularChangesSpecifierName", table: table))
                SettingsLink("ReduceLoudSoundsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("ReduceLoudSoundsSpecifierName", table: table))
                SettingsLink("DrivingFocusSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("DrivingFocusSpecifierName", table: table))
                SettingsLink("TVProviderSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("TVProviderSpecifierName", table: table))
                SettingsLink("BackgroundAppActivitiesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList("BackgroundAppActivitiesSpecifierName", table: table))
            } header: {
                Text("AllowChangesLabel", tableName: table)
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
        }
    }
}

#Preview {
    NavigationStack {
        ContentPrivacyRestrictionsView()
    }
}
