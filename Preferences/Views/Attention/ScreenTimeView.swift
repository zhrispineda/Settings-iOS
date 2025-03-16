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
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        CustomList(title: "AboutScreenTimeTitle".localize(table: table), topPadding: appWebsiteActivityEnabled) {
            if appWebsiteActivityEnabled {
                Section {
                    VStack {
                        Text(UIDevice.iPhone ? "NoDataDetailTextLabel_IPHONE" : "NoDataDetailTextLabel_IPAD", tableName: table)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, idealHeight: 150)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 0)
                    NavigationLink("SeeAllAppAndWebsiteActivityControlTitle".localize(table: table), destination: AppWebsiteActivityView())
                } header: {
                    Text(UIDevice.current.model)
                } footer: {
                    HStack(spacing: 5) {
                        Text("Updated today at \(Date.now, format: .dateTime.hour().minute())")
                        //ProgressView()
                    }
                }
            } else {
                Section {
                    Placard(title: "ScreenTimeGroupSpecifierName".localize(table: table), color: Color.indigo, icon: "hourglass", description: "AboutScreenTimeDetailText".localize(table: table), lightOnly: true, frameY: .constant(0.0), opacity: .constant(1.0))
                }
            }
            
            Section {
                if appWebsiteActivityEnabled {
                    SettingsLink(icon: "Downtime80x80", id: "AppAndWebsiteActivityEDUDowntimeTitle".localize(table: table), subtitle: "DeviceDowntimeDetailText".localize(table: table)) {
                        DowntimeView()
                    }
                    SettingsLink(icon: "App Limits80x80", id: "AppAndWebsiteActivityEDUAppLimitsTitle".localize(table: table), subtitle: "AppLimitsDetailText".localize(table: table)) {
                        AppLimitsView()
                    }
                    SettingsLink(icon: "AlwaysAllow29x29", id: "AlwaysAllowedSpecifierName".localize(table: table), subtitle: "AlwaysAllowDetailText".localize(table: table)) {
                        AlwaysAllowedView()
                    }
                } else {
                    Button {
                        showingAppWebsiteActivitySheet.toggle()
                    } label: {
                        SettingsLink(color: Color.cyan, icon: "chart.bar.xaxis", lightOnly: true, id: "AppAndWebsiteActivitySpecifierName".localize(table: table), subtitle: "AppAndWebsiteActivitySpecifierSubtitleText".localize(table: table)) {}
                            .foregroundStyle(Color["Label"])
                    }
                    .sheet(isPresented: $showingAppWebsiteActivitySheet) {
                        AppWebsiteActivitySheetView(appWebsiteActivityEnabled: $appWebsiteActivityEnabled)
                            .frame(width: 400, height: 730)
                    }
                }
                SettingsLink(color: Color.white, iconColor: Color.blue, icon: "chevron.3.up.perspective", lightOnly: true, id: "ScreenDistanceSpecifierName".localize(table: table), subtitle: "ScreenDistanceSpecifierSubtitleText".localize(table: table)) {
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
                Text("LimitUsageGroupSpecifierName", tableName: table)
            }
            
            Section {
                //CommunicationLimitsSpecifierName
                SettingsLink(color: Color.green, icon: "person.crop.circle", lightOnly: true, id: "CommunicationLimitsSpecifierName".localize(table: table), subtitle: "AADC_CommunicationLimitsDetailText".localize(table: table)) {
                    EmptyView()
                }
                SettingsLink(color: Color.blue, icon: "bubble.left.and.exclamationmark.bubble.right.fill", lightOnly: true, id: "CommunicationSafetyTitle".localize(table: table), subtitle: "CommunicationSafetyOffSubtitle".localize(table: table)) {
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
                Text("CommunicationGroupSpecifierName", tableName: table)
            }
            
            Section {
                SettingsLink(color: Color.red, icon: "nosign", lightOnly: true, id: "ContentPrivacySpecifierName".localize(table: table), subtitle: "ContentPrivacyDetailText".localize(table: table)) {
                    ContentPrivacyRestrictionsView()
                }
            } header: {
                Text("RestrictionsGroupSpecifierName", tableName: table)
            }
            
            Section {
                Button("LockScreenTimeSettingsButtonName".localize(table: table)) {}
            } footer: {
                Text("EnableScreenTimePasscodeFooterText", tableName: table)
            }
            
            Section {
                Button("SignInToiCloudButtonName".localize(table: table)) {
                    showingAppleAccountSheet.toggle()
                }
                .sheet(isPresented: $showingAppleAccountSheet) {
                    NavigationStack {
                        AppleAccountLoginView(isMainSheet: true)
                    }
                }
            } footer: {
                Text("SignInToiCloudFooterText", tableName: table)
            }
            
            if appWebsiteActivityEnabled {
                Section {
                    Button("DisableAppAndWebsiteActivityButtonName".localize(table: table)) {
                        showingDisableScreenTimeDialog.toggle()
                    }
                    .foregroundStyle(.red)
                    .confirmationDialog("DisableAppAndWebsiteActivityConfirmPrompt".localize(table: table), isPresented: $showingDisableScreenTimeDialog, titleVisibility: .visible) {
                        Button("DisableAppAndWebsiteActivityButtonName".localize(table: table), role: .destructive) {
                            withAnimation {
                                appWebsiteActivityEnabled.toggle()
                            }
                        }
                    }
                } footer: {
                    Text("DisableAppAndWebsiteActivityFooterText", tableName: table)
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
