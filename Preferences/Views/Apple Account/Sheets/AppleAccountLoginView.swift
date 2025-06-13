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
    @State private var showingOptionsAlert = false
    @State private var showingErrorAlert = false
    @State private var showingForgotPasswordSheet = false
    @State private var username = ""
    let setupTable = "AppleIDSetup"
    let table = "AppleID"
    let UITable = "AppleAccountUI"
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Image("appleAccount") // Apple Account Logo
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 130)
                            .frame(maxWidth: .infinity)
                        Text("LOGIN_FORM_TITLE", tableName: setupTable) // Apple Account Title
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("SIGN_IN_SUBTITLE", tableName: UITable) // Apple Account Subtitle
                            .font(.title2)
                            .foregroundStyle(.secondary)

                        // MARK: Email or Phone Number Text Field
                        TextField("LOGIN_FORM_TEXTFIELD_NAME".localize(table: setupTable), text: $username)
                            .usernameTextStyle()
                            .padding(.vertical)

                        // MARK: Forgot password? Button
                        Button(LocalizedStringResource.AppleAccountUI.accountAccessSummaryForgotPasswordTitle, systemImage: "info.circle.fill") {
                            showingForgotPasswordSheet.toggle()
                        }
                        .disabled(showingOptionsAlert)
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
                            if signingIn || showingOptionsAlert {
                                ContinueButton(username: $username, loading: true)
                            } else {
                                OBBoldTrayButton("SIGN_IN_BUTTON_CONTINUE".localize(table: UITable)) {
                                    signingIn.toggle()
                                    showingAlert.toggle()
                                }
                            }
                        }
                        .disabled(username.count < 1)
                        .alert("VERIFICATION_FAILED_TITLE".localize(table: UITable), isPresented: $showingAlert) {
                            Button("AUTHENTICATE_VIEW_BUTTON_TITLE".localize(table: setupTable)) {
                                signingIn.toggle()
                            }
                        } message: {
                            Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND", tableName: UITable)
                        }

                        // MARK: Sign in a child in my Family Button
                        if !isMainSheet {
                            NavigationLink(destination: ParentGuardianSignInView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundStyle(Color(UIColor.secondarySystemBackground))
                                        .frame(height: 50)
                                    Text(LocalizedStringResource.AppleAccountUI.signInForChildButtonTitle)
                                }
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
                        Button("Close", systemImage:  "xmark") {
                            dismiss()
                        }
                    }
                }
            }
            .alert("SIGN_IN_HELP_ALERT_TITLE_FORGOT_OR_CREATE".localize(table: UITable), isPresented: $showingOptionsAlert) {
                Button("IFORGOT_BUTTON_REBRAND".localize(table: table), role: .none) {
                    showingForgotPasswordSheet.toggle()
                }
                Button("SIGN_IN_HELP_ALERT_BUTTON_CREATE".localize(table: UITable), role: .none) {
                    showingErrorAlert.toggle()
                }
                Button("SIGN_IN_HELP_ALERT_BUTTON_CANCEL".localize(table: UITable), role: .cancel) {}
            }
            .alert("Could Not Create Apple Account", isPresented: $showingErrorAlert) {
                Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                Button("AUTHENTICATE_VIEW_BUTTON_TITLE".localize(table: setupTable)) {
                    dismiss()
                }
            } message: {
                Text("This \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model) has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model).")
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
