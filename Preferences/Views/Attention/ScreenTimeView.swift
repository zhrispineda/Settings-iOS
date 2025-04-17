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
                    SLink("AppAndWebsiteActivityEDUDowntimeTitle".localize(table: table), icon: "Downtime80x80", subtitle: "DeviceDowntimeDetailText".localize(table: table)) {
                        DowntimeView()
                    }
                    SLink("AppAndWebsiteActivityEDUAppLimitsTitle".localize(table: table), icon: "App Limits80x80", subtitle: "AppLimitsDetailText".localize(table: table)) {
                        AppLimitsView()
                    }
                    SLink("AlwaysAllowedSpecifierName".localize(table: table), icon: "AlwaysAllow29x29", subtitle: "AlwaysAllowDetailText".localize(table: table)) {
                        AlwaysAllowedView()
                    }
                } else {
                    Button {
                        showingAppWebsiteActivitySheet.toggle()
                    } label: {
                        SLink("AppAndWebsiteActivitySpecifierName".localize(table: table), color: Color.cyan, icon: "chart.bar.xaxis", lightOnly: true, subtitle: "AppAndWebsiteActivitySpecifierSubtitleText".localize(table: table)) {}
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingAppWebsiteActivitySheet) {
                        AppWebsiteActivitySheetView(appWebsiteActivityEnabled: $appWebsiteActivityEnabled)
                            .frame(width: 400, height: 730)
                    }
                }
                SLink("ScreenDistanceSpecifierName".localize(table: table), color: Color.white, iconColor: Color.blue, icon: "chevron.3.up.perspective", lightOnly: true, subtitle: "ScreenDistanceSpecifierSubtitleText".localize(table: table)) {
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
                SLink("CommunicationLimitsSpecifierName".localize(table: table), color: Color.green, icon: "person.crop.circle", lightOnly: true, subtitle: "AADC_CommunicationLimitsDetailText".localize(table: table)) {
                    EmptyView()
                }
                SLink("CommunicationSafetyTitle".localize(table: table), color: Color.blue, icon: "bubble.left.and.exclamationmark.bubble.right.fill", lightOnly: true, subtitle: "CommunicationSafetyOffSubtitle".localize(table: table)) {
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
                SLink("ContentPrivacySpecifierName".localize(table: table), color: Color.red, icon: "nosign", lightOnly: true, subtitle: "ContentPrivacyDetailText".localize(table: table)) {
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
