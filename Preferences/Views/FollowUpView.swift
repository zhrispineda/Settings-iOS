//
//  FollowUpView.swift
//  Preferences
//
//  Settings > Finish Setting Up Your [DEVICE]
//

import SwiftUI

struct FollowUpView: View {
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    @Environment(\.dismiss) var dismiss
    @Environment(StateManager.self) private var stateManager
    let coreFollowUp = "/System/Library/PrivateFrameworks/CoreFollowUp.framework"
    let setupAssistant = "/System/Library/PrivateFrameworks/SetupAssistant.framework"
    let table = "FollowUp"
    
    var body: some View {
        // MULTI_FOLLOW_LIST_TITLE (en, iphone): More for Your iPhone
        CustomList(title: "MULTI_FOLLOW_LIST_TITLE".localized(path: coreFollowUp)) {
            Section {
                VStack(alignment: .leading, spacing: 5) {
                    // FOLLOWUP_TITLE (en, iphone): Finish Setting Up Your iPhone
                    Text("FOLLOWUP_TITLE".localized(path: setupAssistant, table: table))
                        .fontWeight(.semibold)
                    if UIDevice.PearlIDCapability {
                        // FOLLOWUP_DETAIL_FACEID (en, iphone): Get the most out of your iPhone with features like Apple Account, Siri, Face ID, and Apple Pay.
                        Text("FOLLOWUP_DETAIL_FACEID".localized(path: setupAssistant, table: table))
                    } else {
                        // FOLLOWUP_DETAIL_TOUCHID (en, iphone): Get the most out of your iPhone with features like Apple Account, Siri, Touch ID, and Apple Pay.
                        Text("FOLLOWUP_DETAIL_TOUCHID".localized(path: setupAssistant, table: table))
                    }
                }
                
                // FOLLOWUP_ACTION_LABEL_ALL (en, iphone): Finish Setting Up
                Button("FOLLOWUP_ACTION_LABEL_ALL".localized(path: setupAssistant, table: table)) {
                    SettingsLogger.log("Updating FollowUpDismissed to true")
                    withAnimation {
                        followUpDismissed = true
                    }
                    SettingsLogger.log("Attempting to dismiss FollowUpView")
                    if UIDevice.iPad {
                        stateManager.selection = stateManager.mainSettings.first
                    } else if UIDevice.iPhone {
                        dismiss()
                    }
                }
            }
        }
        .animation(.default, value: followUpDismissed)
    }
}

#Preview {
    NavigationStack {
        FollowUpView()
            .environment(StateManager())
    }
}
