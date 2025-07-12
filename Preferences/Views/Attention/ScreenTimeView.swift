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
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        CustomList(title: "AboutScreenTimeTitle".localized(path: path), topPadding: appWebsiteActivityEnabled) {
            if appWebsiteActivityEnabled {
                Section {
                    VStack {
                        Text(UIDevice.iPhone ? "NoDataDetailTextLabel_IPHONE".localized(path: path) : "NoDataDetailTextLabel_IPAD".localized(path: path))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, idealHeight: 150)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 0)
                    NavigationLink("SeeAllAppAndWebsiteActivityControlTitle".localized(path: path), destination: AppWebsiteActivityView())
                } header: {
                    Text(UIDevice.current.model)
                } footer: {
                    HStack(spacing: 5) {
                        Text("Updated today at \(Date.now, format: .dateTime.hour().minute())")
                    }
                }
            } else {
                Section {
                    Placard(title: "ScreenTimeGroupSpecifierName".localized(path: path), color: Color.indigo, icon: "hourglass", description: "AboutScreenTimeDetailText".localized(path: path), lightOnly: true, frameY: .constant(0.0), opacity: .constant(1.0))
                }
            }
            
            Section {
                if appWebsiteActivityEnabled {
                    SLink("AppAndWebsiteActivityEDUDowntimeTitle".localized(path: path), icon: "Downtime80x80", subtitle: "DeviceDowntimeDetailText".localized(path: path)) {
                        DowntimeView()
                    }
                    SLink("AppAndWebsiteActivityEDUAppLimitsTitle".localized(path: path), icon: "App Limits80x80", subtitle: "AppLimitsDetailText".localized(path: path)) {
                        AppLimitsView()
                    }
                    SLink("AlwaysAllowedSpecifierName".localized(path: path), icon: "AlwaysAllow29x29", subtitle: "AlwaysAllowDetailText".localized(path: path)) {
                        AlwaysAllowedView()
                    }
                } else {
                    Button {
                        showingAppWebsiteActivitySheet.toggle()
                    } label: {
                        SLink("AppAndWebsiteActivitySpecifierName".localized(path: path), color: Color.cyan, icon: "chart.bar.xaxis", lightOnly: true, subtitle: "AppAndWebsiteActivitySpecifierSubtitleText".localized(path: path)) {}
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingAppWebsiteActivitySheet) {
                        AppWebsiteActivitySheetView(appWebsiteActivityEnabled: $appWebsiteActivityEnabled)
                            .frame(width: 400, height: 730)
                    }
                }
                SLink("ScreenDistanceSpecifierName".localized(path: path), color: Color.white, iconColor: Color.blue, icon: "chevron.3.up.perspective", lightOnly: true, subtitle: "ScreenDistanceSpecifierSubtitleText".localized(path: path)) {
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
                Text("LimitUsageGroupSpecifierName".localized(path: path))
            }
            
            Section {
                SLink("CommunicationLimitsSpecifierName".localized(path: path), color: Color.green, icon: "person.crop.circle", lightOnly: true, subtitle: "AADC_CommunicationLimitsDetailText".localized(path: path)) {
                    EmptyView()
                }
                SLink("CommunicationSafetyTitle".localized(path: path), color: Color.blue, icon: "bubble.left.and.exclamationmark.bubble.right.fill", lightOnly: true, subtitle: "CommunicationSafetyOffSubtitle".localized(path: path)) {
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
                Text("CommunicationGroupSpecifierName".localized(path: path))
            }
            
            Section {
                SLink("ContentPrivacySpecifierName".localized(path: path), color: Color.red, icon: "nosign", lightOnly: true, subtitle: "ContentPrivacyDetailText".localized(path: path)) {
                    ContentPrivacyRestrictionsView()
                }
            } header: {
                Text("RestrictionsGroupSpecifierName".localized(path: path))
            }
            
            Section {
                Button("LockScreenTimeSettingsButtonName".localized(path: path)) {}
            } footer: {
                Text("EnableScreenTimePasscodeFooterText".localized(path: path))
            }
            
            Section {
                Button("SignInToiCloudButtonName".localized(path: path)) {
                    showingAppleAccountSheet.toggle()
                }
                .sheet(isPresented: $showingAppleAccountSheet) {
                    NavigationStack {
                        AppleAccountLoginView(isMainSheet: true)
                    }
                }
            } footer: {
                Text("SignInToiCloudFooterText".localized(path: path))
            }
            
            if appWebsiteActivityEnabled {
                Section {
                    Button("DisableAppAndWebsiteActivityButtonName".localized(path: path)) {
                        showingDisableScreenTimeDialog.toggle()
                    }
                    .foregroundStyle(.red)
                    .confirmationDialog("DisableAppAndWebsiteActivityConfirmPrompt".localized(path: path), isPresented: $showingDisableScreenTimeDialog, titleVisibility: .visible) {
                        Button("DisableAppAndWebsiteActivityButtonName".localized(path: path), role: .destructive) {
                            withAnimation {
                                appWebsiteActivityEnabled.toggle()
                            }
                        }
                    }
                } footer: {
                    Text("DisableAppAndWebsiteActivityFooterText".localized(path: path))
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
