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
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Section {
                    VStack {
                        if geo.size.height > 650 && UIDevice.iPhone {
                            Spacer(minLength: geo.size.height * (geo.size.height > 750 ? 0.2 : 0.12))
                        }
                        // Privacy Button
                        OBPrivacyLinkView(bundleIdentifiers: ["com.apple.onboarding.appleid"])
                            .frame(minHeight: 100)
                        
                        Button {
                            signingIn.toggle()
                            showingAlert.toggle()
                        } label: {
                            if signingIn || showingOptionsAlert {
                                ContinueButton(username: $username, loading: true)
                            } else {
                                ContinueButton(username: $username)
                            }
                        }
                        .frame(height: 50)
                        .disabled(username.count < 1)
                        .alert("VERIFICATION_FAILED_TITLE".localize(table: UITable), isPresented: $showingAlert) {
                            Button("SETUP_VIEW_BUTTON_OK".localize(table: setupTable)) {
                                signingIn.toggle()
                            }
                        } message: {
                            Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localize(table: UITable))
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        ParentGuardianSignInView()
    }
}
