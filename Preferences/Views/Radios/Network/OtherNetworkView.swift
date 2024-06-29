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
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("Name")
                        TextField("Network Name", text: $networkName)
                            .focused($isFocused)
                            .padding(.leading, 10)
                    }
                }
                
                Section {
                    CustomNavigationLink(title: "Security", status: "WPA2/WPA3", destination: EmptyView())
                    HStack {
                        Text("Password")
                        SecureField("", text: $password)
                            .padding(.leading, 10)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("**Other Network**")
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .padding(.top, 10)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("**Join**")
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
