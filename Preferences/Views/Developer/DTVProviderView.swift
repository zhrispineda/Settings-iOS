//
//  TVProviderView.swift
//  Preferences
//
//  Settings > Developer > TV Provider
//

import SwiftUI

struct DTVProviderView: View {
    // Variables
    @State private var cacheBusterEnabled = false
    @State private var disableTimeoutsEnabled = false
    @State private var simluateExpiredTokenEnabled = false
    let table = "VideoSubscriberAccount"
    
    var body: some View {
        CustomList(title: "TV_PROVIDER_TITLE".localize(table: table), topPadding: true) {
            Section {
                Toggle("DEVELOPER_IS_CACHEBUSTER_ENABLED_ACTION_TITLE".localize(table: table), isOn: $cacheBusterEnabled)
            } header: {
                Text("DEVELOPER_OPTIONS_GROUP_TITLE", tableName: table)
            } footer: {
                Text("DEVELOPER_IS_CACHEBUSTER_ENABLED_ACTION_DESCRIPTION", tableName: table)
            }
            
            Section {
                Toggle("DEVELOPER_REQUEST_TIMEOUTS_TITLE".localize(table: table), isOn: $disableTimeoutsEnabled)
            } footer: {
                Text("DEVELOPER_REQUEST_TIMEOUTS_DESCRIPTION", tableName: table)
            }
            
            Section {
                Toggle("DEVELOPER_SIMULATE_EXPIRED_TOKEN_TITLE".localize(table: table), isOn: $disableTimeoutsEnabled)
            } footer: {
                Text("DEVELOPER_SIMULATE_EXPIRED_TOKEN_DESCRIPTION", tableName: table)
            }
            
            Section {
                Button {} label: {
                    Text("IDENTITY_PROVIDER_PICKER_OTHER_PROVIDERS_ROW_TITLE_DEVELOPER", tableName: table)
                        .frame(maxWidth: .infinity)
                }
            } header: {
                Text("DEVELOPER_PROVIDERS_TITLE", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DTVProviderView()
    }
}
