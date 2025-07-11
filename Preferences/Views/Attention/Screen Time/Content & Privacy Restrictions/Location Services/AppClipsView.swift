//
//  AppClipsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > App Clips
//

import SwiftUI

struct AppClipsView: View {
    @State private var confirmLocationEnabled = false
    var completeView = true
    var permission = ""
    let path = "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"
    let table = "Dim-Sum"
    let locTable = "Location Services"
    
    var body: some View {
        CustomList(title: "APP_CLIPS".localized(path: path, table: table)) {
            Section {
                if completeView {
                    Toggle("CONFIRM_LOCATION".localized(path: path, table: table), isOn: $confirmLocationEnabled)
                }
            } footer: {
                VStack(alignment: .leading) {
                    if completeView {
                        Text("\("CONFIRM_LOCATION_FOOTER".localized(path: path, table: table))\n\n")
                    }
                    if permission == "MicrophoneSpecifierName" {
                        Text("\("MICROPHONE_CLIPS_FOOTER".localized(path: path, table: table))\n")
                    } else if permission == "BluetoothSharingSpecifierName" {
                        Text("\("BT_PERIPHERAL_CLIPS_FOOTER".localized(path: path, table: table))\n")
                    } else {
                        Text("\("GENERAL_EXPLANATION_CLIPS_ITEM".localized(path: path, table: locTable))\n")
                    }
                    
                    if completeView {
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text("ACTIVE_EXPLANATION_ITEM".localized(path: path, table: locTable))
                        }
                        .padding(.trailing)
                        .padding(.bottom, 5)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "location.fill")
                                .foregroundStyle(.gray)
                                .font(.headline)
                            Text("RECENT_EXPLANATION_ITEM".localized(path: path, table: locTable))
                        }
                        .padding(.trailing)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppClipsView()
    }
}
