//
//  ParentGuardianSignInView.swift
//  Preferences
//

import SwiftUI

/// View for Settings > Sign in > Sign in Manually > Sign in a child in my Family
struct ParentGuardianSignInView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingOptionsAlert = false
    @State private var username = ""
    let setupTable = "/System/Library/PrivateFrameworks/AppleIDSetup.framework"
    let UITable = "/System/Library/PrivateFrameworks/AppleAccountUI.framework"
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section {
                    VStack(alignment: .leading, spacing: 15) {
                        Image(systemName: "figure.and.child.holdinghands")
                            .foregroundStyle(.blue)
                            .font(.system(size: 64))
                            .frame(maxWidth: .infinity)
                        Text("PARENT_SIGN_IN_TITLE".localized(path: setupTable))
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("PARENT_SIGN_IN_REASON_REBRAND".localized(path: setupTable, "12"))
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        TextField("LOGIN_FORM_TEXTFIELD_NAME".localized(path: setupTable), text: $username)
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

                        OBBoldTrayButton("SIGN_IN_BUTTON_CONTINUE".localized(path: UITable), isLoading: $signingIn) {
                            signingIn.toggle()
                            showingAlert.toggle()
                        }
                        .frame(height: 50)
                        .disabled(username.count < 1)
                    }
                }
                .listRowBackground(Color.clear)
            }
            .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
            .scrollContentBackground(.hidden)
            .alert("VERIFICATION_FAILED_TITLE".localized(path: UITable), isPresented: $showingAlert) {
                Button("SETUP_VIEW_BUTTON_OK".localized(path: setupTable)) {
                    signingIn.toggle()
                }
            } message: {
                Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localized(path: UITable))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ParentGuardianSignInView()
    }
}
