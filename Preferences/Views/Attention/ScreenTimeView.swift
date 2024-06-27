//
//  ScreenTimeView.swift
//  Preferences
//
//  Settings > Screen Time
//

import SwiftUI

struct ScreenTimeView: View {
    // Variables
    @State private var appWebsiteActivityEnabled = false
    @State private var showingDisableScreenTimeDialog = false
    @State private var showingAppWebsiteActivitySheet = false
    @State private var showingScreenDistanceSheet = false
    @State private var showingCommunicationSafetySheet = false
    @State private var showingAppleAccountSheet = false
    
    var body: some View {
        CustomList(title: "Screen Time") {
            if appWebsiteActivityEnabled {
                Section {
                    VStack {
                        Text("As you use your \(Device().model), screen time will be reported here.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, idealHeight: 150)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 0)
                    NavigationLink("See All App & Website Activity", destination: AppWebsiteActivityView())
                } header: {
                    Text("\n\n\(UIDevice.current.name)")
                } footer: {
                    HStack(spacing: 5) {
                        Text("Updated today at \(Date.now, format: .dateTime.hour().minute())")
                        //ProgressView()
                    }
                }
            } else {
                Section {
                    SectionHelp(title: "Screen Time", color: Color.indigo, icon: "hourglass", description: "Understand how much time you spend on your devices. Set limits on how long and when apps can be used. Restrict apps, websites, and more.")
                }
            }
            
            Section {
                if appWebsiteActivityEnabled {
                    SettingsLink(icon: "Downtime80x80", id: "Downtime", subtitle: "Schedule time away from the screen") {
                        DowntimeView()
                    }
                    SettingsLink(icon: "App Limits80x80", id: "App Limits", subtitle: "Set time limits for apps") {
                        AppLimitsView()
                    }
                    SettingsLink(icon: "AlwaysAllow29x29", id: "Always Allowed", subtitle: "Choose apps to allow at all times") {
                        AlwaysAllowedView()
                    }
                } else {
                    Button {
                        showingAppWebsiteActivitySheet.toggle()
                    } label: {
                        SettingsLink(color: Color.cyan, icon: "chart.bar.xaxis", larger: false, id: "App & Website Activity", subtitle: "Reports, Downtime & App Limits") {}
                            .foregroundStyle(Color["Label"])
                    }
                    .sheet(isPresented: $showingAppWebsiteActivitySheet) {
                        AppWebsiteActivitySheetView(appWebsiteActivityEnabled: $appWebsiteActivityEnabled)
                            .frame(width: 400, height: 730)
                    }
                }
                SettingsLink(color: Color.white, iconColor: Color.blue, icon: "chevron.3.up.perspective", id: "Screen Distance", subtitle: "Reduce eye strain") {
                    ScreenDistanceView()
                        .onAppear {
                            showingScreenDistanceSheet.toggle()
                        }
                }
                .sheet(isPresented: $showingScreenDistanceSheet) {
                    ScreenDistanceSheetView()
                        .frame(width: 400, height: 730)
                }
            } header: {
                Text("Limit Usage")
            }
            
            Section {
                SettingsLink(color: Color.blue, icon: "bubble.left.and.exclamationmark.bubble.right.fill", larger: false, id: "Communication Safety", subtitle: "Protect from sensitive content") {
                    CommunicationSafetyView()
                        .onAppear {
                            showingCommunicationSafetySheet.toggle()
                        }
                }
                .sheet(isPresented: $showingCommunicationSafetySheet) {
                    SensitivePhotosVideosProtectionSheetView()
                        .frame(width: 400, height: 730)
                }
            } header: {
                Text("Communication")
            }
            
            Section {
                SettingsLink(color: Color.red, icon: "nosign", larger: false, id: "Content & Privacy Restrictions", subtitle: "Block inappropriate content") { ContentPrivacyRestrictionsView() }
            } header: {
                Text("Restrictions")
            }
            
            Section {
                Button("Lock Screen Time Settings", action: {}) // TODO: Fullscreen sheet
            } footer: {
                Text("Use a passcode to secure Screen Time settings.")
            }
            
            Section {
                Button("Use with Other Devices or Family") {
                    showingAppleAccountSheet.toggle()
                }
                .sheet(isPresented: $showingAppleAccountSheet) {
                    NavigationStack {
                        AppleAccountLoginView(isMainSheet: true)
                    }
                }
            } footer: {
                Text("Sign in to iCloud to report your screen time on any iPad or iPhone, or set up Family Sharing to use Screen Time with your family‘s devices.")
            }
            
            if appWebsiteActivityEnabled {
                Section {
                    Button("Turn Off App & Website Activity") {
                        showingDisableScreenTimeDialog.toggle()
                    }
                    .foregroundStyle(.red)
                    .confirmationDialog("Screen time will no longer be reported, and all limits and downtime settings will be turned off.", isPresented: $showingDisableScreenTimeDialog, titleVisibility: .visible) {
                        Button("Turn Off App & Website Activity", role: .destructive) {
                            withAnimation {
                                appWebsiteActivityEnabled.toggle()
                            }
                        }
                    }
                } footer: {
                    Text("Turning off App & Website Activity disables real-time reporting, Downtime, App Limits, and Always Allowed.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenTimeView()
    }
}
