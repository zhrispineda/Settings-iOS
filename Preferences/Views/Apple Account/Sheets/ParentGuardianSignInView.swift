//
//  ParentGuardianSignInView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually > Sign in a child in my Family
//

import SwiftUI

struct ParentGuardianSignInView: View {
    // Variables
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingOptionsAlert = false
    @State private var username = String()
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 15) {
                    Image(systemName: "figure.and.child.holdinghands")
                        .foregroundStyle(.blue)
                        .font(.system(size: 64))
                    Text("Parent or Guardian Apple Account Sign In")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Sign in with your Apple Account to set up this device for a child 12 or younger.")
                }
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            
            Section {
                VStack(alignment: .center) {
                    TextField("Email or Phone Number", text: $username)
                        .padding(.vertical)
                        .padding(.leading, 5)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                    Spacer()
                }
                Spacer()
                    .frame(minHeight: 30)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            Section {
                VStack {
                    Button {
                        // Empty
                    } label: {
                        VStack {
                            Image(_internalSystemName: "privacy.handshake")
                                .resizable()
                                .foregroundStyle(.blue)
                                .scaledToFit()
                                .frame(height: 23)
                            Text("Your Apple Account information is used to enable Apple services when you sign in, including iCloud Backup, which automatically backs up the data on your device in case you need to replace or restore it. Your device serial number may be used to check eligibility for service offers.\n[See how your data is managed..](_)\n")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        signingIn.toggle()
                        showingAlert.toggle()
                    } label: {
                        if signingIn || showingOptionsAlert {
                            ProgressView()
                                .fontWeight(.medium)
                                .font(.headline)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(UIColor.systemGray5))
                                .foregroundStyle(Color(UIColor.systemGray))
                                .cornerRadius(15)
                        } else {
                            Text("Continue")
                                .fontWeight(.medium)
                                .font(.headline)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(username.count < 1 ? Color(UIColor.systemGray5) : Color.blue)
                                .foregroundStyle(username.count < 1 ? Color(UIColor.systemGray) : Color.white)
                                .cornerRadius(15)
                        }
                    }
                    .frame(height: 50)
                    .disabled(username.count < 1)
                    .alert("Verification Failed", isPresented: $showingAlert) {
                        Button("OK") {
                            signingIn.toggle()
                        }
                    } message: {
                        Text("There was an error connecting to the Apple Account server.")
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    NavigationStack {
        ParentGuardianSignInView()
    }
}
