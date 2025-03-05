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
                CustomNavigationLink("LocationServicesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: RestrictionsLocationServicesView())
                CustomNavigationLink("ContactsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "ContactsSpecifierName"))
                CustomNavigationLink("CalendarsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "CalendarsSpecifierName"))
                CustomNavigationLink("RemindersSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "RemindersSpecifierName"))
                CustomNavigationLink("PhotosSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "PhotosSpecifierName"))
                CustomNavigationLink("ShareLocationSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "ShareLocationSpecifierName"))
                CustomNavigationLink("BluetoothSharingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "BluetoothSharingSpecifierName"))
                CustomNavigationLink("MicrophoneSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MicrophoneSpecifierName"))
                CustomNavigationLink("SpeechRecognitionSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "SpeechRecognitionSpecifierName"))
                CustomNavigationLink("AdvertisingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "AdvertisingSpecifierName"))
                CustomNavigationLink("UserTrackingSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "UserTrackingSpecifierName"))
                CustomNavigationLink("MediaAppleMusicSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: ContentPrivacyRestrictionsDetailView(title: "MediaAppleMusicSpecifierName"))
            } header: {
                Text("PrivacySpecifierName", tableName: table)
            }
            .disabled(!contentPrivacyRestrictionsEnabled)
            
            Section {
                CustomNavigationLink("PasscodeChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "PasscodeChangesSpecifierName", table: table))
                CustomNavigationLink("AccountChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "AccountChangesSpecifierName", table: table))
                CustomNavigationLink("CellularChangesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "CellularChangesSpecifierName", table: table))
                CustomNavigationLink("ReduceLoudSoundsSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "ReduceLoudSoundsSpecifierName", table: table))
                CustomNavigationLink("DrivingFocusSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "DrivingFocusSpecifierName", table: table))
                CustomNavigationLink("TVProviderSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "TVProviderSpecifierName", table: table))
                CustomNavigationLink("BackgroundAppActivitiesSpecifierName".localize(table: table), status: "AllowLabel".localize(table: table), destination: SelectOptionList(title: "BackgroundAppActivitiesSpecifierName", table: table))
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
