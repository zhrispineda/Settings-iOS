//
//  BetaUpdatesView.swift
//  Preferences
//
//  Settings > General > Software Update > Beta Updates
//

import SwiftUI

struct BetaUpdatesView: View {
    // Variables
    @State private var selected = "\(UIDevice().systemName) 18 Developer Beta"
    @State private var showingAlert = false
    let options = ["OFF", "\(UIDevice().systemName) 18 Public Beta", "\(UIDevice().systemName) 18 Developer Beta"]
    let table = "Software Update"
    
    var body: some View {
        CustomList(title: "GET_BETA_UPDATES".localize(table: table)) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text(.init("BETA_UPDATES_FOOTER_IPHONE".localize(table: table, "[Learn more...](https://beta.apple.com)")))
            }
            
            Section {
                Button("BETA_UPDATES_APPLE_ACCOUNT_PREFIX".localize(table: table, "j.appleseed@icloud.com")) {
                    showingAlert.toggle()
                }
                .alert("BETA_UPDATES_APPLE_ACCOUNT_AUTHENTICATION_TITLE".localize(table: table), isPresented: $showingAlert) {
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("BETA_UPDATES_APPLE_ACCOUNT_MISMATCH_PROMPT", tableName: table)
                    }
                    Button("CANCEL".localize(table: table), role: .cancel) {
                        showingAlert.toggle()
                    }
                } message: {
                    Text("BETA_UPDATES_APPLE_ACCOUNT_AUTHENTICATION_ALERT_MESSAGE".localize(table: table, "j.appleseed@icloud.com"))
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        BetaUpdatesView()
    }
}
