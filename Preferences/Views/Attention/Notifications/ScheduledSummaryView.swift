//
//  ScheduledSummaryView.swift
//  Preferences
//
//  Settings > Notifications > Scheduled Summary
//

import SwiftUI

struct ScheduledSummaryView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var scheduledSummary = false
    let path = "/System/Library/PrivateFrameworks/UserNotificationsUIKit.framework"
    let notif = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SCHEDULED_DELIVERY".localized(path: notif, table: table)) {
            Toggle("SCHEDULED_DELIVERY".localized(path: notif, table: table), isOn: $scheduledSummary)
        }
        .popover(isPresented: $scheduledSummary) {
            // MARK: Header Image
            ZStack {
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 350)
                if let asset = UIImage.asset(path: path, name: "DigestOnboardingIntroduction-Background") {
                    Image(uiImage: asset)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 175)
                        .offset(y: 41)
                        .opacity(0.5)
                }
                if let asset = UIImage.asset(path: path, name: colorScheme == .dark ? "DigestOnboardingIntroduction-Dark-Foreground" : "DigestOnboardingIntroduction-Light-Foreground") {
                    Image(uiImage: asset)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .offset(y: 45)
                }
            }
            
            // MARK: Title and Description
            Group {
                Text("NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_TITLE".localized(path: path))
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.vertical, 10)
                Text("NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_DESCRIPTION".localized(path: path))
                    .font(.subheadline)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 50)
            
            // MARK: 1st Explainer Title and Body
            ExplainerView(symbol: "deskclock", color: Color.red, title: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_1_TITLE".localized(path: path), message: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_1_BODY".localized(path: path))
            
            // MARK: 2nd Explainer Title and Body
            ExplainerView(symbol: "exclamationmark.bubble", color: Color.blue, title: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_2_TITLE".localized(path: path), message: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_2_BODY".localized(path: path))
            
            Spacer()
            
            // MARK: Continue Button
            Button {} label: {
                Text("Continue".localized(path: notif, table: table))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: 300, maxHeight: 15)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            // MARK: Set Up Later Button
            Button {
                scheduledSummary.toggle()
            } label: {
                Text("Set Up Later".localized(path: notif, table: table))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: 300, maxHeight: 15)
            }
            .controlSize(.large)
            .padding(.top)
        }
        .onDisappear {
            scheduledSummary = false
        }
    }
}

struct ExplainerView: View {
    var symbol: String
    var color: Color
    var title: String
    var message: String
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .foregroundStyle(color)
                .fontWeight(.semibold)
                .font(.title)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .fontWeight(.semibold)
                Text(message)
                    .foregroundStyle(.secondary)
            }
            .font(.footnote)
            .frame(maxWidth: 300, alignment: .leading)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    NavigationStack {
        ScheduledSummaryView()
    }
}
