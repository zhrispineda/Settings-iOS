//
//  ScheduledSummaryView.swift
//  Preferences
//
//  Settings > Notifications > Scheduled Summary
//

import SwiftUI

struct ScheduledSummaryView: View {
    // Variables
    @State private var scheduledSummary = false
    let table = "NotificationsSettings"
    let obTable = "UserNotificationsUIKit"
    
    var body: some View {
        CustomList(title: "SCHEDULED_DELIVERY".localize(table: "NotificationsSettings")) {
            Toggle("SCHEDULED_DELIVERY".localize(table: "NotificationsSettings"), isOn: $scheduledSummary)
        }
        .popover(isPresented: $scheduledSummary) {
            // MARK: Header Image
            ZStack {
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(height: 350)
                Image(.digestOnboardingIntroductionForeground)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
            
            // MARK: Title and Description
            Group {
                Text("NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_TITLE", tableName: obTable)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.vertical, 10)
                Text("NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_DESCRIPTION", tableName: obTable)
                    .font(.subheadline)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 50)
            
            // MARK: 1st Explainer Title and Body
            ExplainerView(symbol: "deskclock", color: Color.red, title: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_1_TITLE", message: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_1_BODY", table: obTable)
            
            // MARK: 2nd Explainer Title and Body
            ExplainerView(symbol: "exclamationmark.bubble", color: Color.blue, title: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_2_TITLE", message: "NOTIFICATION_DIGEST_ONBOARDING_INTRODUCTION_EXPLAINER_2_BODY", table: obTable)
            
            Spacer()
            
            // MARK: Continue Button
            Button {} label: {
                Text("Continue", tableName: table)
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
                Text("Set Up Later", tableName: table)
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
    var table: String
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .foregroundStyle(color)
                .fontWeight(.semibold)
                .font(.title)
            VStack(alignment: .leading, spacing: 0) {
                Text(title.localize(table: table))
                    .fontWeight(.semibold)
                Text(message.localize(table: table))
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
