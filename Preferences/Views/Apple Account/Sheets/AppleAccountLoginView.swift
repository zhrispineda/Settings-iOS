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
                    VStack(spacing: 15) {
                        Image("appleAccount") // Apple Account Logo
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                        Text("LOGIN_FORM_TITLE", tableName: setupTable) // Apple Account Title
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("SIGN_IN_SUBTITLE", tableName: UITable) // Apple Account Subtitle
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                }
                .multilineTextAlignment(.center)
                .listRowBackground(Color.clear)
                
                Section {
                    VStack(alignment: .center) {
                        // MARK: Email or Phone Number Text Field
                        TextField("LOGIN_FORM_TEXTFIELD_NAME".localize(table: setupTable), text: $username)
                            .usernameTextStyle()
                        
                        Spacer()
                        
                        // MARK: Forgot password? Button
                        Button {
                            showingForgotPasswordSheet.toggle()
                        } label: {
                            Text("SIGN_IN_HELP_BUTTON_FORGOT".localize(table: UITable))
                                .foregroundStyle(.accent)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .disabled(showingOptionsAlert)
                    }
                    
                    // MARK: Sign in a child in my Family Button
                    ZStack {
                        NavigationLink("", destination: ParentGuardianSignInView())
                            .opacity(0)
                        Text("SIGN_IN_FOR_CHILD_BUTTON_TITLE", tableName: UITable)
                            .foregroundStyle(.accent)
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Section {
                    VStack {
                        if geo.size.height > 650 && UIDevice.iPhone {
                            Spacer(minLength: geo.size.height * (geo.size.height > 750 ? 0.25 : 0.12))
                        }
                        // MARK: Privacy Button
                        OBPrivacyLinkView(bundleIdentifiers: ["com.apple.onboarding.appleid"])
                            .frame(minHeight: 100)
                        
                        // MARK: Continue Button
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
                            Button("AUTHENTICATE_VIEW_BUTTON_TITLE".localize(table: setupTable)) {
                                signingIn.toggle()
                            }
                        } message: {
                            Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND", tableName: UITable)
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .padding(.top, -45)
            .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
            .scrollContentBackground(.hidden)
            .navigationBarBackButtonHidden()
            .toolbar {
                if isMainSheet {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.gray, Color(UIColor.systemFill))
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
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
