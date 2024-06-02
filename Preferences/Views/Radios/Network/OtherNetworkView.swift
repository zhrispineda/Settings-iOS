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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Enter network information")
                            .font(.subheadline)
                            .offset(y: -5)
                        Text("**Other Network**")
                            .offset(y: 15)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .padding(.top, 50)
                    })
                    .foregroundStyle(Color["Default"])
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("**Join**")
                            .padding(.top, 50)
                    })
                    .foregroundStyle(Color["Default"])
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
