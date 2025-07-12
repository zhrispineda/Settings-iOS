//
//  OtherNetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi > Other…
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
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
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
                        Text("kWFLocOtherNetworkNameTitle".localized(path: path, table: table))
                        TextField("kWFLocOtherNetworkNamePlaceholder".localized(path: path, table: table), text: $networkName)
                            .focused($networkFocused)
                            .padding(.leading, 10)
                            .onAppear {
                                networkFocused = true
                            }
                    }
                }
                
                // Security + Password/Username
                Section {
                    SettingsLink("kWFLocOtherNetworkSecurityTitle".localized(path: path, table: table), status: security.localized(path: path, table: table), destination: SecurityView(security: $security))
                    if security.contains("Enterprise") {
                        HStack {
                            Text("kWFLocOtherNetworkUsernameTitle".localized(path: path, table: table))
                            TextField("", text: $username)
                                .padding(.leading, 10)
                        }
                    }
                    if security != "kWFLocSecurityNoneTitle" {
                        HStack {
                            Text("kWFLocOtherNetworkPasswordTitle".localized(path: path, table: table))
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
                    Button(role: .cancel) {
                        dismiss()
                    }
                    .labelStyle(.iconOnly)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    // Join
                    Button(role: .confirm) {
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
