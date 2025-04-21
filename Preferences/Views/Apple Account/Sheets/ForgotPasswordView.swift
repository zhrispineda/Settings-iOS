//
//  ForgotPasswordView.swift
//  Preferences
//
//  Settings > Sign In > Sign in Manually > Forgot password or don‘t have an Apple Account?
//

import SwiftUI

struct ForgotPasswordView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var username = String()
    @State private var showingFailedAlert = false
    @State var guardianMode = false
    let table = "AppleAccountUI"
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    VStack {
                        Text("SIGN_IN_HELP_ALERT_TITLE_FORGOT_PASSWORD", tableName: table)
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
                            .usernameTextStyle()
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
                .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
                .scrollContentBackground(.hidden)
                .padding(.top, -15)
                
                VStack {
                    Spacer()
                    ZStack {
                        Button {
                            showingFailedAlert.toggle()
                        } label: {
                            ContinueButton(username: $username)
                        }
                        .frame(height: 50)
                        .disabled(username.count < 1)
                        .alert("Cannot Reset Password", isPresented: $showingFailedAlert) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text("This Apple Account is not valid or not supported.")
                        }
                    }
                }
                .padding(.bottom, 50)
                .padding(.horizontal, 25)
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
