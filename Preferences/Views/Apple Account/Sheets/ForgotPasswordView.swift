//
//  ForgotPasswordView.swift
//  Preferences
//
//  Settings > Sign In > Sign in Manually > Forgot password or don‘t have an Apple Account?
//

import SwiftUI

struct ForgotPasswordView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var username = String()
    @State private var showingFailedAlert = false
    @State private var showingEmailSentAlert = false
    @State var showingUnlockOptions = false
    @State var guardianMode = false
    let table = "AppleAccountUI"
    
    var body: some View {
        NavigationStack {
            if showingUnlockOptions {
                List {
                    VStack {
                        Text("**Unlock Options**")
                            .font(.largeTitle)
                            .padding(.bottom, 5)
                        Text("Choose how you would like\nto unlock your account.")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    Section {
                        Button {
                            showingEmailSentAlert.toggle()
                        } label: {
                            HStack {
                                Text("Unlock By Email")
                                    .foregroundStyle(Color["Label"])
                                Spacer()
                                if showingEmailSentAlert {
                                    ProgressView()
                                } else {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .alert("Unlock Email Sent",
                               isPresented: $showingEmailSentAlert
                        ) {
                            Button {
                                showingEmailSentAlert.toggle()
                                dismiss()
                            } label: {
                                Text("OK".localize(table: table))
                            }
                        } message: {
                            Text("Follow the directions in the email to unlock your account.")
                        }
                    }
                }
                .navigationBarBackButtonHidden()
            } else {
                ZStack {
                    List {
                        VStack {
                            Text("SIGN_IN_HELP_ALERT_TITLE_FORGOT_PASSWORD".localize(table: table))
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .padding(.top, -20)
                                .padding(.bottom, 5)
                            Text("Enter your email address or phone number that you use with your account to continue.")
                                .padding(.horizontal, -5)
                                .padding(.bottom, -10)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                        Section {
                            TextField("SIGN_IN_USERNAME_PLACEHOLDER".localize(table: table), text: $username)
                                .padding(.leading, guardianMode ? 15 : 20)
                                .frame(height: 42)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(10)
                                .listRowBackground(Color.clear)
                                .onAppear {
                                    if !username.isEmpty {
                                        dismiss()
                                    }
                                }
                        } footer: {
                            if guardianMode {
                                Text("Your privacy is important. If you‘re resetting your password on someone else‘s device, your personal information will not be saved on their device.")
                                    .padding(.top, -10)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.horizontal, guardianMode ? -20 : -20)
                        .offset(y: -10)
                    }
                    
                    VStack {
                        Spacer()
                        ZStack {
                            Button {
                                showingFailedAlert.toggle()
                                //ForgotPasswordView(showingUnlockOptions: true)
                            } label: {
                                Text("SIGN_IN_BUTTON_CONTINUE".localize(table: table))
                                    .fontWeight(.medium)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(username.count < 1 ? Color(UIColor.systemGray5) : Color.blue)
                                    .foregroundStyle(username.count < 1 ? Color(UIColor.systemGray) : Color.white)
                                    .cornerRadius(15)
                                    .padding(.horizontal, 40)
                                    .disabled(username.count < 1)
                                    .frame(height: 50)
                            }
                            .alert("Cannot Reset Password", isPresented: $showingFailedAlert) {} message: {
                                Text("This Apple Account is not valid or not supported.")
                            }
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("SIGN_IN_ACTION_CANCEL".localize(table: table))
                        .foregroundStyle(.accent)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
