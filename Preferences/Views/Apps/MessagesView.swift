//
//  MessagesView.swift
//  Preferences
//
//  Settings > Apps > Messages
//

import SwiftUI

struct MessagesView: View {
    // Variables
    @State private var messagesEnabled = false
    @State private var showContactPhoto = true
    @State private var mmsMessaging = true
    @State private var showSubjectField = false
    @State private var characterCountEnabled = false
    @State private var notifyMe = true
    @State private var filterUnknownSenders = false
    @State private var lowQualityImageMode = false
    @State private var showingSheet = false
    let table = "MessagesSettings"
    let msgTable = "Messages"
    
    var body: some View {
        CustomList(title: "MESSAGES".localize(table: table), topPadding: true) {
            PermissionsView(appName: "MESSAGES".localize(table: table), cellular: false, focus: true, location: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("IMESSAGE".localize(table: table), isOn: $messagesEnabled)
            } footer: {
                Text("MESSAGES_WIRELESS_DATA_DESCRIPTION", tableName: table) + Text("[\("MESSAGE_FACETIME_PRIVACY_BUTTON".localize(table: table))...](pref://)")
            }
            
            Section {
                NavigationLink("MESSAGE_APPS".localize(table: table)) {}
            }
            
            Section {
                CustomNavigationLink("SHARE_NAME_AND_PHOTO".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
            } footer: {
                Text("NAME_AND_PHOTO_SHARING_NOT_SHARING_FOOTER", tableName: msgTable)
            }
            
            Section {
                CustomNavigationLink("SHARED_WITH_YOU".localize(table: table), status: "ON".localize(table: table), destination: EmptyView())
            } footer: {
                Text("SHARED_WITH_YOU_GROUP_DESCRIPTION", tableName: msgTable)
            }
            
            Section {
                Toggle("SHOW_CONTACT_PHOTOS".localize(table: table), isOn: $showContactPhoto)
            } footer: {
                Text("CONTACT_PHOTO_DESCRIPTION", tableName: msgTable)
            }
            
            Section("MMS_LABEL".localize(table: msgTable)) {
                Toggle("MMS_MESSAGING".localize(table: table), isOn: $mmsMessaging)
                Toggle("SHOW_SUBJECT_FIELD".localize(table: table), isOn: $showSubjectField)
                Toggle("CHARACTER_COUNT".localize(table: table), isOn: $characterCountEnabled)
                NavigationLink("BLOCKED_CONTACTS".localize(table: table)) {}
            }
            
            Section("MESSAGE_HISTORY".localize(table: msgTable)) {
                CustomNavigationLink("KEEP_MESSAGES".localize(table: msgTable), status: "FOREVER".localize(table: table), destination: EmptyView())
            }
            
            Section {
                Toggle("NOTIFY_ME".localize(table: table), isOn: $notifyMe)
            } header: {
                Text("MENTIONS_TITLE", tableName: msgTable)
            } footer: {
                Text("SEND_READ_RECEIPTS_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("FILTER_UNKNOWN_SENDERS".localize(table: table), isOn: $filterUnknownSenders)
            } header: {
                Text("MESSAGES_FILTERING_LABEL", tableName: msgTable)
            } footer: {
                Text("FILTER_UNKNOWN_SENDERS_DESCRIPTION", tableName: table)
            }
            
            Section {
                Toggle("PREVIEW_TRANSCODING".localize(table: msgTable), isOn: $lowQualityImageMode)
            } footer: {
                Text("PREVIEW_TRANSCODING_DESCRIPTION", tableName: msgTable)
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
