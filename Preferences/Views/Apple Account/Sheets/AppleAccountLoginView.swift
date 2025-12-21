//
//  AppleAccountLoginView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually
//

import SwiftUI

struct AppleAccountLoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isMainSheet = false
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingForgotPasswordSheet = false
    @State private var username = ""
    private let setupPath = "/System/Library/PrivateFrameworks/AppleIDSetup.framework"
    private let accountPath = "/System/Library/PrivateFrameworks/AppleAccountUI.framework"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(
                    "AppleAccount_Icon_Blue",
                    bundle: Bundle(path: UIDevice.RuntimePath + accountPath)
                )
                .frame(height: 20)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 60)
                Text("LOGIN_FORM_TITLE".localized(path: setupPath))
                    .font(.title2)
                    .fontWeight(.bold)
                Text("SIGN_IN_SUBTITLE".localized(path: accountPath))
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                // Email or Phone Number
                TextField("LOGIN_FORM_TEXTFIELD_NAME".localized(path: setupPath), text: $username)
                    .usernameTextStyle()
                    .padding(.vertical)

                // Forgot password?
                Button("SIGN_IN_HELP_BUTTON_FORGOT_SOLARIUM".localized(path: accountPath), systemImage: "info.circle.fill") {
                    showingForgotPasswordSheet.toggle()
                }
                .foregroundStyle(.blue)
                .imageScale(.small)
                .buttonStyle(.plain)
                .labelIconToTitleSpacing(10)
                .padding(.bottom, 20)
                
                // Privacy
                OBPrivacyLinkView(bundleIdentifiers: ["com.apple.onboarding.appleid"])
                    .frame(minHeight: 130)
                
                // Continue
                Button {
                    signingIn.toggle()
                    showingAlert.toggle()
                } label: {
                    OBBoldTrayButton("SIGN_IN_BUTTON_CONTINUE".localized(path: accountPath), isLoading: $signingIn) {
                        signingIn.toggle()
                        showingAlert.toggle()
                    }
                    .frame(height: 50)
                }
                .disabled(username.count < 1)
                .alert("VERIFICATION_FAILED_TITLE".localized(path: accountPath), isPresented: $showingAlert) {
                    Button("AUTHENTICATE_VIEW_BUTTON_TITLE".localized(path: setupPath)) {
                        signingIn.toggle()
                    }
                } message: {
                    Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localized(path: accountPath))
                }

                // Sign in a child in my Family
                if !isMainSheet {
                    NavigationLink(destination: ParentGuardianSignInView()) {
                        Text("SIGN_IN_FOR_CHILD_BUTTON_TITLE_SOLARIUM".localized(path: accountPath))
                    }
                    .foregroundStyle(.primary)
                    .navigationLinkIndicatorVisibility(.hidden)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 25)
                }
                
                Spacer(minLength: 40)
            }
            .containerRelativeFrame(.vertical)
        }
        .contentMargins(35, for: .scrollContent)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar {
            ToolbarItem(placement: isMainSheet ? .topBarTrailing : .topBarLeading) {
                if isMainSheet {
                    Button(role: .close) {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingForgotPasswordSheet) {
            NavigationStack {
                ForgotPasswordView()
            }
        }
    }
}

#Preview {
    AppleAccountLoginView()
}

#Preview("Sheet View") {
    Text("Example")
        .sheet(isPresented: .constant(true)) {
            NavigationStack {
                AppleAccountLoginView()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Back", systemImage: "chevron.left") {}
                        }
                    }
            }
        }
}

#Preview("ContentView") {
    ContentView()
        .environment(PrimarySettingsListModel())
}
