//
//  MessagesView.swift
//  Preferences
//
//  Settings > Apps > Messages
//

import SwiftUI

struct MessagesView: View {
    @State private var messagesEnabled = false
    @State private var showContactPhoto = true
    @State private var mmsMessaging = true
    @State private var showSubjectField = false
    @State private var characterCountEnabled = false
    @State private var notifyMe = true
    @State private var filterUnknownSenders = false
    @State private var lowQualityImageMode = false
    @State private var showingSheet = false
    let path = "/System/Library/PrivateFrameworks/MessagesSettingsUI.framework"
    let table = "MessagesSettings"
    let comm = "/System/Library/PrivateFrameworks/CommunicationsSetupUI.framework"
    let msgTable = "Messages"
    
    var body: some View {
        CustomList(title: "MESSAGES".localized(path: path, table: table), topPadding: true) {
            PermissionsView(appName: "MESSAGES".localized(path: path, table: table), cellular: false, focus: true, location: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("IMESSAGE".localized(path: path, table: table), isOn: $messagesEnabled)
            } footer: {
                Text("\("MESSAGES_WIRELESS_DATA_DESCRIPTION".localized(path: path, table: table)) [\("MESSAGE_FACETIME_PRIVACY_BUTTON".localized(path: path, table: table))…](pref://)")
            }
            
            Section {
                NavigationLink("MESSAGE_APPS".localized(path: path, table: table)) {}
            }
            
            Section {
                SettingsLink("SHARE_NAME_AND_PHOTO".localized(path: path, table: table), status: "OFF".localized(path: path, table: table), destination: EmptyView())
            } footer: {
                Text("NAME_AND_PHOTO_SHARING_NOT_SHARING_FOOTER".localized(path: comm, table: msgTable))
            }
            
            Section {
                SettingsLink("SHARED_WITH_YOU".localized(path: path, table: table), status: "ON".localized(path: path, table: table), destination: EmptyView())
            } footer: {
                Text("SHARED_WITH_YOU_GROUP_DESCRIPTION".localized(path: comm, table: msgTable))
            }
            
            Section {
                Toggle("SHOW_CONTACT_PHOTOS".localized(path: path, table: table), isOn: $showContactPhoto)
            } footer: {
                Text("CONTACT_PHOTO_DESCRIPTION".localized(path: comm, table: msgTable))
            }
            
            Section("MMS_LABEL".localized(path: comm, table: msgTable)) {
                Toggle("MMS_MESSAGING".localized(path: path, table: table), isOn: $mmsMessaging)
                Toggle("SHOW_SUBJECT_FIELD".localized(path: path, table: table), isOn: $showSubjectField)
                Toggle("CHARACTER_COUNT".localized(path: path, table: table), isOn: $characterCountEnabled)
                NavigationLink("BLOCKED_CONTACTS".localized(path: path, table: table)) {}
            }
            
            Section("MESSAGE_HISTORY".localized(path: comm, table: msgTable)) {
                SettingsLink("KEEP_MESSAGES".localized(path: comm, table: msgTable), status: "FOREVER".localized(path: path, table: table), destination: EmptyView())
            }
            
            Section {
                Toggle("NOTIFY_ME".localized(path: path, table: table), isOn: $notifyMe)
            } header: {
                Text("MENTIONS_TITLE".localized(path: comm, table: msgTable))
            } footer: {
                Text("SEND_READ_RECEIPTS_FOOTER".localized(path: path, table: table))
            }
            
            Section {
                Toggle("FILTER_UNKNOWN_SENDERS".localized(path: path, table: table), isOn: $filterUnknownSenders)
            } header: {
                Text("MESSAGES_FILTERING_LABEL".localized(path: comm, table: msgTable))
            } footer: {
                Text("FILTER_UNKNOWN_SENDERS_DESCRIPTION".localized(path: path, table: table))
            }
            
            Section {
                Toggle("PREVIEW_TRANSCODING".localized(path: comm, table: msgTable), isOn: $lowQualityImageMode)
            } footer: {
                Text("PREVIEW_TRANSCODING_DESCRIPTION".localized(path: path, table: table))
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .background {
            OBCombinedSplashView(["com.apple.onboarding.appstore", "com.apple.onboarding.applearcade"], showingSheet: $showingSheet)
        }
    }
}

#Preview {
    NavigationStack {
        MessagesView()
    }
}
