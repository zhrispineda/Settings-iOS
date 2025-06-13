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
    let coreTable = "CoreFollowUp"
    let table = "FollowUp"
    
    var body: some View {
        CustomList(title: "MULTI_FOLLOW_LIST_TITLE".localize(table: coreTable)) {
            Section {
                VStack(alignment: .leading, spacing: 5) {
                    Text("FOLLOWUP_TITLE", tableName: table)
                        .fontWeight(.semibold)
                    Text(UIDevice.PearlIDCapability ? "FOLLOWUP_DETAIL_FACEID" : "FOLLOWUP_DETAIL_TOUCHID", tableName: table)
                }
                Button("FOLLOWUP_ACTION_LABEL_ALL".localize(table: table)) {
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
    }
}

#Preview {
    NavigationStack {
        FollowUpView()
    }
}
