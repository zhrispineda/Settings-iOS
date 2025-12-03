//
//  ScreenTimeView.swift
//  Preferences
//
//  Settings > Screen Time
//

import SwiftUI

struct ScreenTimeView: View {
    @State private var titleVisible = false
    @State private var appWebsiteActivityEnabled = false
    @State private var showingDisableScreenTimeDialog = false
    @State private var showingAppWebsiteActivitySheet = false
    @State private var showingScreenDistanceSheet = false
    @State private var showingCommunicationSafetySheet = false
    @State private var showingAppleAccountSheet = false
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        CustomList(title: titleVisible ? "AboutScreenTimeTitle".localized(path: path) : "", topPadding: appWebsiteActivityEnabled) {
            if appWebsiteActivityEnabled {
                Section {
                    VStack {
                        Text(UIDevice.iPhone
                             ? "NoDataDetailTextLabel_IPHONE".localized(path: path)
                             : "NoDataDetailTextLabel_IPAD".localized(path: path)
                        )
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
                    Placard(
                        title: "ScreenTimeGroupSpecifierName".localized(path: path),
                        icon: "com.apple.graphic-icon.screen-time",
                        description: "AboutScreenTimeDetailText".localized(path: path),
                        isVisible: $titleVisible
                    )
                }
            }
            
            Section {
                if appWebsiteActivityEnabled {
                    SLink(
                        "AppAndWebsiteActivitySpecifierName".localized(path: path),
                        icon: "com.apple.graphic-icon.analytics-and-improvements",
                        subtitle: "AppAndWebsiteActivitySpecifierSubtitleText".localized(path: path)
                    ) {
                        DowntimeView()
                    }
//                    SLink(
//                        "AppAndWebsiteActivityEDUAppLimitsTitle".localized(path: path),
//                        path: path,
//                        icon: "AppLimits",
//                        subtitle: "AppLimitsDetailText".localized(path: path)
//                    ) {
//                        AppLimitsView()
//                    }
//                    SLink("AlwaysAllowedSpecifierName".localized(path: path),
//                          path: path,
//                          icon: "AlwaysAllow",
//                          subtitle: "AlwaysAllowDetailText".localized(path: path)
//                    ) {
//                        AlwaysAllowedView()
//                    }
                } else {
                    Button {
                        showingAppWebsiteActivitySheet.toggle()
                    } label: {
                        SLink(
                            "AppAndWebsiteActivitySpecifierName".localized(path: path),
                            icon: "com.apple.graphic-icon.analytics-and-improvements",
                            subtitle: "AppAndWebsiteActivitySpecifierSubtitleText".localized(path: path)
                        ) {}
                    }
                    .tint(.primary)
                    .sheet(isPresented: $showingAppWebsiteActivitySheet) {
                        AppWebsiteActivitySheetView(appWebsiteActivityEnabled: $appWebsiteActivityEnabled)
                            .frame(width: 400, height: 730)
                    }
                }
                SLink(
                    "ScreenDistanceSpecifierName".localized(path: path),
                    icon: "com.apple.screen-time.screen-distance",
                    subtitle: "ScreenDistanceSpecifierSubtitleText".localized(path: path)
                ) {
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
                SLink(
                    "CommunicationSafetyTitle".localized(path: path),
                    icon: "com.apple.graphic-icon.communication-safety",
                    subtitle: "CommunicationSafetyOffSubtitle".localized(path: path),
                    destination: ControllerBridgeView(
                        "\(path)/ScreenTimeSettingsUI",
                        controller: "STCommunicationSafetyListController",
                        title: "CommunicationSafetyTitle".localized(path: path)
                    )
                )
            } header: {
                Text("CommunicationGroupSpecifierName".localized(path: path))
            }
            
            Section {
                SLink(
                    "ContentPrivacySpecifierName".localized(path: path),
                    icon: "com.apple.graphic-icon.content-and-privacy-restrictions",
                    subtitle: "ContentPrivacyDetailText".localized(path: path),
                    destination: ContentPrivacyRestrictionsView()
                )
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
