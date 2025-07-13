//
//  ForgotPasswordView.swift
//  Preferences
//
//  Settings > Sign In > Sign in Manually > Forgot password or don‘t have an Apple Account?
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""
    @State private var showingFailedAlert = false
    @State var guardianMode = false
    let path = "/System/Library/PrivateFrameworks/AppleAccountUI.framework"
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    VStack(alignment: .leading, spacing: 0) {
                        if let asset = UIImage.asset(path: path, name: "AppleAccount_Icon_Blue") {
                            Image(uiImage: asset)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 90)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 30)
                        }
                        Text("SIGN_IN_HELP_ALERT_TITLE_FORGOT_PASSWORD".localized(path: path))
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Enter your email address or phone number that you use with your account to continue.")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 20)
                        TextField("SIGN_IN_USERNAME_PLACEHOLDER".localized(path: path), text: $username)
                            .usernameTextStyle()
                            .onAppear {
                                if !username.isEmpty {
                                    dismiss()
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    Section {} footer: {
                        if guardianMode {
                            Text("Your privacy is important. If you‘re resetting your password on someone else‘s device, your personal information will not be saved on their device.")
                                .padding(.top, -10)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal, guardianMode ? -20 : -20)
                    .offset(y: -10)
                }
                .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
                .scrollContentBackground(.hidden)
                .padding(.top, -15)
                
                VStack {
                    Spacer()
                    OBBoldTrayButton("SIGN_IN_BUTTON_CONTINUE".localized(path: path)) {
                        showingFailedAlert.toggle()
                    }
                    .frame(height: 50)
                    .disabled(username.count < 1)
                }
                .padding(.bottom, 50)
                .padding(.horizontal, 25)
            }
        }
        .alert("Cannot Reset Password", isPresented: $showingFailedAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This Apple Account is not valid or not supported.")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .close) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
