//
//  SummarizeNotificationsView.swift
//  Preferences
//
//  Settings > Notifications > Summarize Notifications
//

import SwiftUI

struct SummarizeNotificationsView: View {
    @State private var summarizeNotifications = false
    let path = "/System/Library/PrivateFrameworks/UserNotificationsKit.framework"
    let notif = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SUMMARIZE_NOTIFICATIONS".localized(path: notif, table: table)) {
            Section {
                Toggle("SUMMARIZE_NOTIFICATIONS".localized(path: notif, table: table), isOn: $summarizeNotifications)
            } footer: {
                Text("SUMMARIZATION_EXPLANATION_LONG".localized(path: notif, table: table))
            }
        }
        .popover(isPresented: $summarizeNotifications) {
            NavigationStack {
                // MARK: Title and Detail Text
                Group {
                    Text("SUMMARIZATION_ONBOARDING_INTRO_TITLE_TEXT".localized(path: path))
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.vertical, 10)
                    Text("SUMMARIZATION_ONBOARDING_INTRO_DETAIL_TEXT".localized(path: path))
                        .font(.subheadline)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                
                Spacer()
                
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 200)
                    .frame(width: .infinity)
                
                Spacer()
                
                // MARK: Choose Notifications to Summarize Button
                Button {} label: {
                    Text("SUMMARIZATION_ONBOARDING_INTRO_CONFIRM_TEXT_V2".localized(path: path))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, maxHeight: 15)
                }
                .buttonStyle(.glassProminent)
                .controlSize(.large)
                
                // MARK: Not Now Button
                Button {
                    summarizeNotifications.toggle()
                } label: {
                    Text("SUMMARIZATION_ONBOARDING_INTRO_CANCEL_TEXT".localized(path: path))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, maxHeight: 15)
                }
                .buttonStyle(.glassProminent)
                .controlSize(.large)
                .tint(.black)
                .toolbar {
                    // Back Button
                    ToolbarItem(placement: .topBarLeading) {
                        Button("SUMMARIZATION_ONBOARDING_BACK_TEXT".localized(path: path)) {
                            summarizeNotifications.toggle()
                        }
                    }
                }
            }
        }
        .onDisappear {
            summarizeNotifications = false
        }
    }
}

#Preview {
    NavigationStack {
        SummarizeNotificationsView()
    }
}
