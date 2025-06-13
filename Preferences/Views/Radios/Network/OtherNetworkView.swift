//
//  OtherNetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi > Other...
//

import SwiftUI

struct OtherNetworkView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var networkFocused: Bool
    @State private var animate = true
    @State private var networkName = ""
    @State private var security = "kWFLocSecurityWPA2WPA3Title"
    @State private var username = ""
    @State private var password = ""
    @State var status = "kWFLocOtherNetworksPrompt"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        NavigationStack {
            List {
                // Name
                Section {
                    HStack {
                        Text("kWFLocOtherNetworkNameTitle", tableName: table)
                        TextField("kWFLocOtherNetworkNamePlaceholder".localize(table: table), text: $networkName)
                            .focused($networkFocused)
                            .padding(.leading, 10)
                            .onAppear {
                                networkFocused = true
                            }
                    }
                }
                
                // Security + Password/Username
                Section {
                    SettingsLink("kWFLocOtherNetworkSecurityTitle".localize(table: table), status: security.localize(table: table), destination: SecurityView(security: $security))
                    if security.contains("Enterprise") {
                        HStack {
                            Text("kWFLocOtherNetworkUsernameTitle", tableName: table)
                            TextField("", text: $username)
                                .padding(.leading, 10)
                        }
                    }
                    if security != "kWFLocSecurityNoneTitle" {
                        HStack {
                            Text("kWFLocOtherNetworkPasswordTitle", tableName: table)
                            SecureField("", text: $password)
                                .padding(.leading, 10)
                        }
                    }
                }
            }
            .navigationTitle("kWFLocOtherNetworksTitle".localize(table: table))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    // Cancel
                    Button("kWFLocAdhocJoinCancelButton".localize(table: table), systemImage: "xmark") {
                        dismiss()
                    }
                    .labelStyle(.iconOnly)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    // Join
                    Button("kWFLocOtherNetworksJoinButton".localize(table: table), systemImage: "checkmark") {
                        dismiss()
                    }
                    .disabled(security != "kWFLocSecurityNoneTitle" && (networkName.count < 1 || (password.count < 8 && username.isEmpty) || username.count < 1 && password.count < 1))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        OtherNetworkView()
    }
}

