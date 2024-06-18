//
//  AppleAccountSignInView.swift
//  Preferences
//
//  Settings > Game Center > [Toggle]
//

import SwiftUI

struct AppleAccountSignInView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingOptionsAlert = false
    @State private var showingErrorAlert = false
    @State private var showingForgotPasswordSheet = false
    @State private var username = String()
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 15) {
                    Text("Apple Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Sign in with an email or phone number to use Game Center.")
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
            }
            .listRowBackground(Color.clear)
            
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
                    Button {
                        showingForgotPasswordSheet.toggle()
                    } label: {
                        Text("Forgot password?")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.accent)
                    }
                    .buttonStyle(.plain)
                    .disabled(showingOptionsAlert)
                }
                .sheet(isPresented: $showingForgotPasswordSheet) {
                    NavigationStack {
                        ForgotPasswordView()
                    }
                }
            }
            .listRowBackground(Color.clear)
            
            Section {
                VStack {
                    Button {} label: {
                        VStack {
                            Image(_internalSystemName: "privacy.handshake")
                                .resizable()
                                .foregroundStyle(.blue)
                                .scaledToFit()
                                .frame(height: 23)
                            Text("Your Apple ID information is used to enable Apple services when you sign in, including iCloud Backup, which automatically backs up the data on your device in case you need to replace or restore it. Your device serial number may be used to check eligibility for service offers.\n[See how your data is managed..](_)")
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
                        Text("There was an error connecting to the Apple ID server.")
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

#Preview {
    AppleAccountSignInView()
}
