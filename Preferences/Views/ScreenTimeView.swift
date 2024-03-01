//
//  ScreenTimeView.swift
//  Preferences
//
//  Settings > Screen Time
//

import SwiftUI

struct ScreenTimeView: View {
    // Variables
    @State private var showingAppWebsiteActivitySheet = false
    @State private var showingScreenDistanceSheet = false
    @State private var showingCommunicationSafetySheet = false
    
    var body: some View {
        CustomList(title: "Screen Time") {
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
            
            Section(content: {
                Button(action: {
                    showingAppWebsiteActivitySheet.toggle()
                }, label: {
                    SettingsLink(color: Color.cyan, icon: "chart.bar.xaxis", larger: false, id: "App & Website Activity", subtitle: "Reports, Downtime & App Limits", content: {})
                        .foregroundStyle(Color["Label"])
                })
                .sheet(isPresented: $showingAppWebsiteActivitySheet, content: {
                    AppWebsiteActivitySheetView()
                })
                Button(action: {
                    showingScreenDistanceSheet.toggle()
                }, label: {
                    SettingsLink(color: Color.white, iconColor: Color.blue, icon: "screen-distance.symbol_Normal", id: "Screen Distance", subtitle: "Reduce eye strain", content: {})
                        .foregroundStyle(Color["Label"])
                })
                .sheet(isPresented: $showingScreenDistanceSheet, content: {
                    ScreenDistanceSheetView()
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
                Button("Use with Other Devices or Family", action: {}) // TODO: Fullscreen sheet
            }, footer: {
                Text("Sign in to iCloud to report your screen time on any iPad or iPhone, or set up Family Sharing to use Screen Time with your family‘s devices.")
            })
        }
    }
}

#Preview {
    NavigationStack {
        ScreenTimeView()
    }
}
