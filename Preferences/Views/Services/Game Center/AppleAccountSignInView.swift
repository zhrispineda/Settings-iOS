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
    let table = "AppleAccountUI"
    let idTable = "AppleID"
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 15) {
                    Text("APPLE_ID_REBRAND", tableName: table)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("SIGN_IN_SUBTITLE_GAMECENTER", tableName: table)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
            }
            .listRowBackground(Color.clear)
            
            Section {
                VStack(alignment: .center) {
                    TextField("SIGN_IN_USERNAME_PLACEHOLDER".localize(table: table), text: $username)
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
                        Text("APPLEID_EXPLANATION", tableName: table)
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
            
            Spacer()
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
                            Text(.init("CREATE_ICLOUD_MAIL_ACCOUNT_EXPLANATION_FOOTER".localize(table: idTable) + " [\("CREATE_ICLOUD_MAIL_ACCOUNT_FOOTER_LEARN_MORE_BUTTON".localize(table: idTable))](#)"))
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
                            Text("SIGN_IN_BUTTON_CONTINUE", tableName: table)
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
                    .alert("VERIFICATION_FAILED_TITLE".localize(table: table), isPresented: $showingAlert) {
                        Button("SIGN_IN_ERROR_BUTTON".localize(table: table)) {
                            signingIn.toggle()
                        }
                    } message: {
                        Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND", tableName: table)
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
