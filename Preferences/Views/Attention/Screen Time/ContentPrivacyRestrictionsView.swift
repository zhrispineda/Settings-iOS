//
//  ContentPrivacyRestrictionsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions
//

import SwiftUI

struct ContentPrivacyRestrictionsView: View {
    @State private var contentPrivacyRestrictionsEnabled = false
    @State private var shareLocationSelection = "AllowLabel"
    @State private var advertisingSelection = "AllowLabel"
    @State private var passcodeChangeSelection = "AllowLabel"
    @State private var accountChangeSelection = "AllowLabel"
    @State private var cellularChangeSelection = "AllowLabel"
    @State private var reduceLoudChangeSelection = "AllowLabel"
    @State private var drivingFocusSelection = "AllowLabel"
    @State private var tvProviderSelection = "AllowLabel"
    @State private var backgroundAppSelection = "AllowLabel"
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "ContentPrivacySpecifierName".localized(path: path, table: table)) {
            Section {
                Toggle("ContentPrivacySpecifierName".localized(path: path, table: table), isOn: $contentPrivacyRestrictionsEnabled)
            }
            
            Section {
                NavigationLink("AppsInstallationsAndPurchasesSpecifierName".localized(path: path, table: table), destination: AppInstallationsPurchasesView())
                NavigationLink("AllowedAppsSpecifierName".localized(path: path, table: table), destination: AllowedAppsView())
                NavigationLink("ContentRestrictionsSpecifierName".localized(path: path, table: table), destination: ContentRestrictionsView())
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                SettingsLink("LocationServicesSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: RestrictionsLocationServicesView())
                SettingsLink("ContactsSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "ContactsSpecifierName"))
                SettingsLink("CalendarsSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "CalendarsSpecifierName"))
                SettingsLink("RemindersSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "RemindersSpecifierName"))
                SettingsLink("PhotosSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "PhotosSpecifierName"))
                SettingsLink("ShareLocationSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("ShareLocationSpecifierName", selected: $shareLocationSelection, table: table))
                SettingsLink("BluetoothSharingSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "BluetoothSharingSpecifierName"))
                SettingsLink("MicrophoneSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MicrophoneSpecifierName"))
                SettingsLink("SpeechRecognitionSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "SpeechRecognitionSpecifierName"))
                SettingsLink("AdvertisingSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("AdvertisingSpecifierName", selected: $advertisingSelection, table: table))
                SettingsLink("UserTrackingSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "UserTrackingSpecifierName"))
                SettingsLink("MediaAppleMusicSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MediaAppleMusicSpecifierName"))
            } header: {
                Text("PrivacySpecifierName".localized(path: path, table: table))
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                SettingsLink("PasscodeChangesSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("PasscodeChangesSpecifierName", selected: $passcodeChangeSelection, table: table))
                SettingsLink("AccountChangesSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("AccountChangesSpecifierName", selected: $accountChangeSelection, table: table))
                SettingsLink("CellularChangesSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("CellularChangesSpecifierName", selected: $cellularChangeSelection, table: table))
                SettingsLink("ReduceLoudAudioSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("ReduceLoudSoundsSpecifierName", selected: $reduceLoudChangeSelection, table: table))
                SettingsLink("DrivingFocusSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("DrivingFocusSpecifierName", selected: $drivingFocusSelection, table: table))
                SettingsLink("TVProviderSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("TVProviderSpecifierName", selected: $tvProviderSelection, table: table))
                SettingsLink("BackgroundAppActivitiesSpecifierName".localized(path: path, table: table), status: "AllowLabel".localized(path: path, table: table), destination: SelectOptionList("BackgroundAppActivitiesSpecifierName", selected: $backgroundAppSelection, table: table))
            } header: {
                Text("AllowChangesLabel".localized(path: path, table: table))
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
