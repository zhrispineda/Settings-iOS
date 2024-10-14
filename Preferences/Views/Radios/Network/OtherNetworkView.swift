//
//  OtherNetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi > Other...
//

import SwiftUI

struct OtherNetworkView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var networkName = String()
    @State private var password = String()
    @FocusState private var isFocused: Bool
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("kWFLocOtherNetworkNameTitle", tableName: table)
                        TextField("kWFLocOtherNetworkNamePlaceholder".localize(table: table), text: $networkName)
                            .focused($isFocused)
                            .padding(.leading, 10)
                    }
                }
                
                Section {
                    CustomNavigationLink(title: "kWFLocOtherNetworkSecurityTitle".localize(table: table), status: "kWFLocSecurityWPA2WPA3Title".localize(table: table), destination: EmptyView())
                    HStack {
                        Text("kWFLocOtherNetworkPasswordTitle", tableName: table)
                        SecureField("", text: $password)
                            .padding(.leading, 10)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("kWFLocOtherNetworksTitle", tableName: table)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("kWFLocAdhocJoinCancelButton", tableName: table)
                            .padding(.top, 10)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("kWFLocOtherNetworksJoinButton", tableName: table)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                    }
                    .disabled(true)
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
