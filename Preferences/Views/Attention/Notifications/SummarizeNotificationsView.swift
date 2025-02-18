//
//  SummarizeNotificationsView.swift
//  Preferences
//
//  Settings > Notifications > Summarize Notifications
//

import SwiftUI

struct SummarizeNotificationsView: View {
    // Variables
    @State private var summarizeNotifications = false
    let table = "NotificationsSettings"
    let obTable = "UserNotificationsKit"
    
    var body: some View {
        CustomList(title: "SUMMARIZE_NOTIFICATIONS".localize(table: table)) {
            Section {
                Toggle("SUMMARIZE_NOTIFICATIONS".localize(table: table), isOn: $summarizeNotifications)
            } footer: {
                Text("SUMMARIZATION_EXPLANATION_LONG", tableName: table)
            }
        }
        .popover(isPresented: $summarizeNotifications) {
            NavigationStack {
                // MARK: Title and Detail Text
                Group {
                    Text("SUMMARIZATION_ONBOARDING_INTRO_TITLE_TEXT", tableName: obTable)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.vertical, 10)
                    Text("SUMMARIZATION_ONBOARDING_INTRO_DETAIL_TEXT", tableName: obTable)
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
                    Text("SUMMARIZATION_ONBOARDING_INTRO_CONFIRM_TEXT_V2", tableName: obTable)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, maxHeight: 15)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                // MARK: Not Now Button
                Button {
                    summarizeNotifications.toggle()
                } label: {
                    Text("SUMMARIZATION_ONBOARDING_INTRO_CANCEL_TEXT", tableName: obTable)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300, maxHeight: 15)
                }
                .controlSize(.large)
                .padding(.top)
                .toolbar {
                    // Back Button
                    ToolbarItem(placement: .topBarLeading) {
                        Button("SUMMARIZATION_ONBOARDING_BACK_TEXT".localize(table: obTable)) {
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
