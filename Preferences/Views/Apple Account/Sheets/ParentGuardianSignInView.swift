//
//  ParentGuardianSignInView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually > Sign in a child in my Family
//

import SwiftUI

struct ParentGuardianSignInView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingSheet = false
    @State private var showingOptionsAlert = false
    @State private var username = String()
    let setupTable = "AppleIDSetup"
    let table = "AppleID"
    let uiTable = "AppleAccountUI"
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 15) {
                    Image(systemName: "figure.and.child.holdinghands")
                        .foregroundStyle(.blue)
                        .font(.system(size: 64))
                    Text("PARENT_SIGN_IN_TITLE".localize(table: setupTable))
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("PARENT_SIGN_IN_REASON_REBRAND".localize(table: setupTable, "12"))
                }
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
            
            Section {
                VStack(alignment: .center) {
                    TextField("LOGIN_FORM_TEXTFIELD_NAME".localize(table: setupTable), text: $username)
                        .usernameTextStyle()
                    Spacer()
                }
                Spacer()
                    .frame(minHeight: 90)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            Section {
                VStack {
                    Button {
                        showingSheet = true
                    } label: {
                        VStack {
                            Image(_internalSystemName: "privacy.handshake")
                                .resizable()
                                .foregroundStyle(.blue)
                                .scaledToFit()
                                .frame(height: 23)
                            Text(.init("CREATE_ICLOUD_MAIL_ACCOUNT_EXPLANATION_FOOTER_REBRAND".localize(table: table) + "\n[\("CREATE_ICLOUD_MAIL_ACCOUNT_FOOTER_LEARN_MORE_BUTTON".localize(table: table))](\("CREATE_ICLOUD_MAIL_ACCOUNT_FOOTER_LEARN_MORE_KB_LINK".localize(table: table)))\n"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                                .font(.caption2)
                                .foregroundStyle(.gray)
                                .sheet(isPresented: $showingSheet) {
                                    OnBoardingView(table: "OBAppleID")
                                }
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
                            Text("LOGIN_FORM_BUTTON_CONTINUE".localize(table: setupTable))
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
                    .alert("VERIFICATION_FAILED_TITLE".localize(table: uiTable), isPresented: $showingAlert) {
                        Button("SETUP_VIEW_BUTTON_OK".localize(table: setupTable)) {
                            signingIn.toggle()
                        }
                    } message: {
                        Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localize(table: uiTable))
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    NavigationStack {
        ParentGuardianSignInView()
    }
}
