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
    @State private var animatingSymbol = true
    @State private var networkName = ""
    @State private var security = "kWFLocSecurityWPA2WPA3Title"
    @State private var username = ""
    @State private var password = ""
    @State var status = "kWFLocOtherNetworksPrompt"
    @State private var frameY = 100.0
    let table = "WiFiKitUILocalizableStrings"

    var body: some View {
        NavigationStack {
            List {
                // Wi-Fi symbol
                Image(systemName: "wifi")
                    .font(.system(size: 64))
                    .foregroundStyle(.blue.gradient)
                    .symbolEffect(.drawOn, isActive: animatingSymbol)
                    .onAppear {
                        Task {
                            try await Task.sleep(for: .seconds(0.5))
                            animatingSymbol = false
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)

                // Join Wi-Fi Network
                Section {
                    Text("Join Wi-Fi Network")
                        .padding(.horizontal, -15)
                        .font(.title3)
                        .fontWeight(.bold)
                        .opacity(frameY >= 100.0 ? 1.0 : 0.0)
                        .overlay {
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .scrollView).minY) {
                                        withAnimation {
                                            frameY = geo.frame(in: .scrollView).minY
                                        }
                                    }
                            }
                        }
                }
                .listRowBackground(Color.clear)

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
            .contentMargins(30, for: .scrollContent)
            .navigationTitle(frameY < 100.0 ? "Join Wi-Fi Network" : "")
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
