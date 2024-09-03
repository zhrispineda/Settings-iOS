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
    
    var body: some View {
        CustomList(title: "Messages", topPadding: true) {
            PermissionsView(appName: "Messages", cellular: false, focus: true, location: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("iMessage", isOn: $messagesEnabled)
            } footer: {
                Text("iMessage uses wireless data to send messages between Apple devices. [About iMessage and FaceTime & Privacy...](#)")
            }
            
            Section {
                NavigationLink("iMessage Apps") {}
            }
            
            Section {
                CustomNavigationLink(title: "Share Name and Photo", status: "Off", destination: EmptyView())
            } footer: {
                Text("To personalize your messages, choose your name and photo, and who can see what you share.")
            }
            
            Section {
                CustomNavigationLink(title: "Shared with You", status: "On", destination: EmptyView())
            } footer: {
                Text("Allow content shared with you in Messages to automatically appear in selected apps.")
            }
            
            Section {
                Toggle("Show Contact Photos", isOn: $showContactPhoto)
            } footer: {
                Text("Show photos of your contacts in Messages.")
            }
            
            Section("Text Messaging") {
                Toggle("MMS Messaging", isOn: $mmsMessaging)
                Toggle("Show Subject Field", isOn: $showSubjectField)
                Toggle("Character Count", isOn: $characterCountEnabled)
                NavigationLink("Blocked Contacts") {}
            }
            
            Section("Message History") {
                CustomNavigationLink(title: "Keep Messages", status: "Forever", destination: EmptyView())
            }
            
            Section {
                Toggle("Notify Me", isOn: $notifyMe)
            } header: {
                Text("Mentions")
            } footer: {
                Text("When this is on, you will be notified when your name is mentioned even if conversations are muted.")
            }
            
            Section {
                Toggle("Filter Unknown Senders", isOn: $filterUnknownSenders)
            } header: {
                Text("Message Filtering")
            } footer: {
                Text("Sort messages from people who are not in your contacts into a separate list.")
            }
            
            Section {
                Toggle("Low Quality Image Mode", isOn: $lowQualityImageMode)
            } footer: {
                Text("When this is on, images sent will be lower quality.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        MessagesView()
    }
}
