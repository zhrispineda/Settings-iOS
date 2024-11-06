//
//  TVAppView.swift
//  Preferences
//
//  Settings > Developer > TV App
//

import SwiftUI

struct TVAppView: View {
    // Variables
    let table = "VideoSubscriberAccount"
    let devTable = "DTSettings"
    
    var body: some View {
        CustomList(title: "TV_APP".localize(table: devTable)) {
            Section {} footer: {
                Text("TV_APP_DEVELOPER_NO_ACCOUNTS_PLACEHOLDER", tableName: table)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVAppView()
    }
}
