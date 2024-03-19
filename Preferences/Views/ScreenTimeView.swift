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
                Section(content: {
                    VStack {
                        Text("As you use your \(DeviceInfo().model), screen time will be reported here.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, idealHeight: 150)
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 0)
                    NavigationLink("See All App & Website Activity", destination: AppWebsiteActivityView())
                }, header: {
                    Text("\n\n\(UIDevice.current.name)")
                }, footer: {
                    HStack(spacing: 5) {
                        Text("Updated today at \(Date.now, format: .dateTime.hour().minute())")
                        //ProgressView()
                    }
                })
            } else {
                Section {
                    VStack(spacing: 10) {
                        ZStack {
                            Color.indigo
                                .frame(width: 56, height: 56)
                                .clipShape(RoundedRectangle(cornerRadius: 13.0))
                            Image(systemName: "hourglass")
                                .font(.system(size: 36))
                                .foregroundStyle(.white)
                        }
                        Text("**Screen Time**")
                            .font(.title2)
                        Text("Understand how much time you spend on your devices. Set limits on how long and when apps can be used. Restrict apps, websites, and more.")
                            .font(.subheadline)
                            .padding(.bottom, -10)
                            .padding(.horizontal, -5)
                    }
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                }
            }
            
            Section(content: { // TODO: Optimize sheets for iPad
                if appWebsiteActivityEnabled {
                    SettingsLink(icon: "Downtime80x80", id: "Downtime", subtitle: "Schedule time away from the screen", content: {
                        DowntimeView()
                    })
                    SettingsLink(icon: "App Limits80x80", id: "App Limits", subtitle: "Set time limits for apps", content: {
                        AppLimitsView()
                    })
                    SettingsLink(icon: "AlwaysAllow29x29", id: "Always Allowed", subtitle: "Choose apps to allow at all times", content: {
                        AlwaysAllowedView()
                    })
                } else {
                    Button(action: {
                        showingAppWebsiteActivitySheet.toggle()
                    }, label: {
                        SettingsLink(color: Color.cyan, icon: "chart.bar.xaxis", larger: false, id: "App & Website Activity", subtitle: "Reports, Downtime & App Limits", content: {})
                            .foregroundStyle(Color["Label"])
                    })
                    .sheet(isPresented: $showingAppWebsiteActivitySheet, content: {
                        AppWebsiteActivitySheetView(appWebsiteActivityEnabled: $appWebsiteActivityEnabled)
                            .frame(width: 400, height: 730)
                    })
                }
                SettingsLink(color: Color.white, iconColor: Color.blue, icon: "screen-distance.symbol_Normal", id: "Screen Distance", subtitle: "Reduce eye strain", content: {
                    ScreenDistanceView()
                        .onAppear(perform: {
                            showingScreenDistanceSheet.toggle()
                        })
                })
                .sheet(isPresented: $showingScreenDistanceSheet, content: {
                    ScreenDistanceSheetView()
                        .frame(width: 400, height: 730)
                })
            }, header: {
                Text("Limit Usage")
            })
            
            Section(content: {
                SettingsLink(color: Color.blue, icon: "bubble.left.and.exclamationmark.bubble.right.fill", larger: false, id: "Communication Safety", subtitle: "Protect from sensitive content", content: {
                    CommunicationSafetyView()
                        .onAppear(perform: {
                            showingCommunicationSafetySheet.toggle()
                        })
                })
                .sheet(isPresented: $showingCommunicationSafetySheet, content: {
                    SensitivePhotosVideosProtectionSheetView()
                        .frame(width: 400, height: 730)
                })
            }, header: {
                Text("Communication")
            })
            
            Section(content: {
                SettingsLink(color: Color.red, icon: "nosign", larger: false, id: "Content & Privacy Restrictions", subtitle: "Block inappropriate content", content: { ContentPrivacyRestrictionsView() })
            }, header: {
                Text("Restrictions")
            })
            
            Section(content: {
                Button("Lock Screen Time Settings", action: {}) // TODO: Fullscreen sheet
            }, footer: {
                Text("Use a passcode to secure Screen Time settings.")
            })
            
            Section(content: {
                Button("Use with Other Devices or Family", action: {
                    showingAppleAccountSheet.toggle()
                })
                .sheet(isPresented: $showingAppleAccountSheet) {
                    NavigationStack {
                        AppleAccountLoginView(isMainSheet: true)
                    }
                }
            }, footer: {
                Text("Sign in to iCloud to report your screen time on any iPad or iPhone, or set up Family Sharing to use Screen Time with your family‘s devices.")
            })
            
            if appWebsiteActivityEnabled {
                Section(content: {
                    Button("Turn Off App & Website Activity", action: {
                        showingDisableScreenTimeDialog.toggle()
                    })
                    .foregroundStyle(.red)
                    .confirmationDialog("Screen time will no longer be reported, and all limits and downtime settings will be turned off.", isPresented: $showingDisableScreenTimeDialog, titleVisibility: .visible, actions: {
                        Button("Turn Off App & Website Activity", role: .destructive) {
                            withAnimation {
                                appWebsiteActivityEnabled.toggle()
                            }
                        }
                    })
                }, footer: {
                    Text("Turning off App & Website Activity disables real-time reporting, Downtime, App Limits, and Always Allowed.")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenTimeView()
    }
}
