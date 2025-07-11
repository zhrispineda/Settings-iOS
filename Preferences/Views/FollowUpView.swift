//
//  FollowUpView.swift
//  Preferences
//
//  Settings > Finish Setting Up Your [DEVICE]
//

import SwiftUI

struct FollowUpView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(StateManager.self) private var stateManager
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    let core = "/System/Library/PrivateFrameworks/CoreFollowUp.framework"
    let path = "/System/Library/PrivateFrameworks/SetupAssistant.framework"
    let table = "FollowUp"
    
    var body: some View {
        CustomList(title: "MULTI_FOLLOW_LIST_TITLE".localized(path: core)) {
            Section {
                VStack(alignment: .leading, spacing: 5) {
                    Text("FOLLOWUP_TITLE".localized(path: path, table: table))
                        .fontWeight(.semibold)
                    Text(UIDevice.PearlIDCapability ? "FOLLOWUP_DETAIL_FACEID".localized(path: path, table: table) : "FOLLOWUP_DETAIL_TOUCHID".localized(path: path, table: table))
                }
                Button(UIDevice.PearlIDCapability ? "FOLLOWUP_ACTION_LABEL.faceID".localized(path: path, table: table) : "FOLLOWUP_ACTION_LABEL.touchID".localized(path: path, table: table)) {
                    if UIDevice.iPad {
                        stateManager.selection = .general
                        stateManager.destination = AnyView(GeneralView())
                    } else if UIDevice.iPhone {
                        dismiss()
                    }
                    withAnimation {
                        followUpDismissed = true
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
