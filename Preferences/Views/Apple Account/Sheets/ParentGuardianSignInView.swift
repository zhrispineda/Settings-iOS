//
//  ParentGuardianSignInView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually > Sign in a child in my Family
//

import SwiftUI

struct ParentGuardianSignInView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingOptionsAlert = false
    @State private var username = ""
    let setupTable = "AppleIDSetup"
    let table = "AppleID"
    let UITable = "AppleAccountUI"
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section {
                    VStack(alignment: .leading, spacing: 15) {
                        Image(systemName: "figure.and.child.holdinghands")
                            .foregroundStyle(.blue)
                            .font(.system(size: 64))
                            .frame(maxWidth: .infinity)
                        Text("PARENT_SIGN_IN_TITLE".localize(table: setupTable))
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("PARENT_SIGN_IN_REASON_REBRAND".localize(table: setupTable, "12"))
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        TextField("LOGIN_FORM_TEXTFIELD_NAME".localize(table: setupTable), text: $username)
                            .usernameTextStyle()
                    }
                    .padding(.horizontal, 10)
                }
                .listRowBackground(Color.clear)
                
                Section {
                    VStack {
                        if geo.size.height > 650 && UIDevice.iPhone {
                            Spacer(minLength: geo.size.height * (geo.size.height > 750 ? 0.2 : 0.12))
                        }
                        // Privacy Button
                        OBPrivacyLinkView(bundleIdentifiers: ["com.apple.onboarding.appleid"])
                            .frame(minHeight: 140)

                        if signingIn || showingOptionsAlert {
                            Button {
                                signingIn.toggle()
                                showingAlert.toggle()
                            } label: {
                                ContinueButton(username: $username, loading: true)
                            }
                            .frame(height: 50)
                        } else {
                            OBBoldTrayButton("SIGN_IN_BUTTON_CONTINUE".localize(table: UITable)) {
                                signingIn.toggle()
                                showingAlert.toggle()
                            }
                            .disabled(username.count < 1)
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
            .scrollContentBackground(.hidden)
            .alert("VERIFICATION_FAILED_TITLE".localize(table: UITable), isPresented: $showingAlert) {
                Button("SETUP_VIEW_BUTTON_OK".localize(table: setupTable)) {
                    signingIn.toggle()
                }
            } message: {
                Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localize(table: UITable))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ParentGuardianSignInView()
    }
}
