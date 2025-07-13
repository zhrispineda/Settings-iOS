//
//  AppleAccountLoginView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually
//

import SwiftUI

struct AppleAccountLoginView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State var isMainSheet = false
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingForgotPasswordSheet = false
    @State private var username = ""
    let setupTable = "/System/Library/PrivateFrameworks/AppleIDSetup.framework"
    let UITable = "/System/Library/PrivateFrameworks/AppleAccountUI.framework"
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        // Apple Account Logo
                        if let asset = UIImage.asset(path: UITable, name: "AppleAccount_Icon_Blue") {
                            Image(uiImage: asset)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 130)
                                .frame(maxWidth: .infinity)
                        }
                        Text("LOGIN_FORM_TITLE".localized(path: setupTable)) // Apple Account Title
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("SIGN_IN_SUBTITLE".localized(path: UITable)) // Apple Account Subtitle
                            .font(.title2)
                            .foregroundStyle(.secondary)

                        // MARK: Email or Phone Number Text Field
                        TextField("LOGIN_FORM_TEXTFIELD_NAME".localized(path: setupTable), text: $username)
                            .usernameTextStyle()
                            .padding(.vertical)

                        // MARK: Forgot password? Button
                        Button("SIGN_IN_HELP_BUTTON_FORGOT_SOLARIUM".localized(path: UITable), systemImage: "info.circle.fill") {
                            showingForgotPasswordSheet.toggle()
                        }
                        .labelIconToTitleSpacing(10)
                    }
                    .multilineTextAlignment(.leading)
                }
                .listRowBackground(Color.clear)

                Section {
                    VStack {
                        // MARK: Privacy Link
                        OBPrivacyLinkView(bundleIdentifiers: ["com.apple.onboarding.appleid"])
                            .frame(minHeight: 120)

                        // MARK: Continue Button
                        Button {
                            signingIn.toggle()
                            showingAlert.toggle()
                        } label: {
                            if signingIn {
                                ContinueButton(username: $username, loading: true)
                            } else {
                                OBBoldTrayButton("SIGN_IN_BUTTON_CONTINUE".localized(path: UITable)) {
                                    signingIn.toggle()
                                    showingAlert.toggle()
                                }
                                .frame(height: 50)
                            }
                        }
                        .disabled(username.count < 1)
                        .alert("VERIFICATION_FAILED_TITLE".localized(path: UITable), isPresented: $showingAlert) {
                            Button("AUTHENTICATE_VIEW_BUTTON_TITLE".localized(path: setupTable)) {
                                signingIn.toggle()
                            }
                        } message: {
                            Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localized(path: UITable))
                        }

                        // MARK: Sign in a child in my Family Button
                        if !isMainSheet {
                            NavigationLink(destination: ParentGuardianSignInView()) {
                                Text("SIGN_IN_FOR_CHILD_BUTTON_TITLE_SOLARIUM".localized(path: UITable))
                                    .padding(.top)
                                    .foregroundStyle(.primary)
                            }
                            .navigationLinkIndicatorVisibility(.hidden)
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .padding(.top, -80)
            .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
            .scrollContentBackground(.hidden)
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
}

#Preview {
    NavigationStack {
        AppleAccountLoginView()
    }
}

#Preview("ContentView") {
    ContentView(stateManager: StateManager())
}
