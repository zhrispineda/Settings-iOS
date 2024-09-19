//
//  AppleAccountLoginView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually
//

import SwiftUI

struct AppleAccountLoginView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State var isMainSheet = false
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
                    Image("appleAccount")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Text("Apple Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Sign in with an email or phone number to use iCloud, the App Store, Messages, or other Apple services.")
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
            }
            .listRowBackground(Color.clear)
            .padding(.top, -10)
            
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
                    Spacer()
                    if !isMainSheet {
                        ZStack {
                            NavigationLink(destination: ParentGuardianSignInView()) {}
                            .opacity(0)
                            Text("Sign in a child in my Family")
                                .foregroundStyle(.accent)
                        }
                    }
                }
                .alert("Forgot password or don‘t have an Apple Account?", isPresented: $showingOptionsAlert) {
                    Button("Forgot Password or Apple Account", role: .none) {
                        showingForgotPasswordSheet.toggle()
                    }
                    Button("Create Apple Account", role: .none) {
                        showingErrorAlert.toggle()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .alert("Could Not Create Apple Account", isPresented: $showingErrorAlert) {
                    Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                    Button("OK") {
                        dismiss()
                    }
                } message: {
                    Text("This \(UIDevice.isSimulator ? "iPhoneSimulator" : UIDevice.current.model) has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this \(UIDevice.isSimulator ? "iPhoneSimulator" : UIDevice.current.model).")
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
                            Text("Your Apple Account information is used to enable Apple services when you sign in, including iCloud Backup, which automatically backs up the data on your device in case you need to replace or restore it. Your device serial number may be used to check eligibility for service offers.\n[See how your data is managed...](_)\n")
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
        .navigationBarBackButtonHidden()
        .toolbar {
            if isMainSheet {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.gray, Color(UIColor.systemFill))
                    }
                }
            } else {
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
}

#Preview {
    NavigationStack {
        AppleAccountLoginView()
    }
}
