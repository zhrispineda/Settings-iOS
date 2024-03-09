//
//  ForgotPasswordView.swift
//  Preferences
//
//  Settings > Sign In > Sign in Manually > Forgot password or don‘t have an Apple ID?
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
                        Button(action: {
                            showingEmailSentAlert.toggle()
                        }, label: {
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
                        })
                        .alert("Unlock Email Sent",
                               isPresented: $showingEmailSentAlert
                        ) {
                            Button {
                                showingEmailSentAlert.toggle()
                                dismiss()
                            } label: {
                                Text("OK")
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
                            Text("**Forgot Password?**")
                                .font(.largeTitle)
                                .padding(.bottom, 5)
                            Text("Enter your email address or phone number that you use with your account to continue.")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                        Section(content: {
                            TextField("Email or Phone Number", text: $username)
                                .padding(.leading, guardianMode ? 15 : 25)
                                .frame(height: 42)
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(10)
                                .listRowBackground(Color.clear)
                                .onAppear(perform: {
                                    if !username.isEmpty {
                                        dismiss()
                                    }
                                })
                        }, footer: {
                            if guardianMode {
                                Text("Your privacy is important. If you‘re resetting your password on someone else‘s device, your personal information will not be saved on their device.")
                                    .padding(.top, -10)
                                    .padding(.horizontal)
                            }
                        })
                        .padding(.horizontal, guardianMode ? -20 : 0)
                    }
                    VStack {
                        Spacer()
                        ZStack {
                            NavigationLink(destination: {
                                ForgotPasswordView(showingUnlockOptions: true)
                            }, label: {
                                Text("Continue")
                                    .fontWeight(.medium)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(username.count < 1 ? Color(UIColor.systemGray5) : Color.blue)
                                    .foregroundStyle(username.count < 1 ? Color(UIColor.systemGray) : Color.white)
                                    .cornerRadius(15)
                                    .padding(.horizontal, 40)
                                    .disabled(username.count < 1)
                                    .frame(height: 50)
                            })
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundStyle(.accent)
                })
                .buttonStyle(.plain)
            })
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
