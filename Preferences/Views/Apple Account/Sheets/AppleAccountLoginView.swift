//
//  AppleAccountLoginView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually
//

import SwiftUI

struct AppleAccountLoginView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State var isMainSheet = false
    @State private var signingIn = false
    @State private var showingAlert = false
    @State private var showingOptionsAlert = false
    @State private var showingErrorAlert = false
    @State private var showingForgotPasswordSheet = false
    @State private var username = String()
    let setupTable = "AppleIDSetup"
    let table = "AppleID"
    let uiTable = "AppleAccountUI"
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 15) {
                    Image("appleAccount")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Text("LOGIN_FORM_TITLE".localize(table: setupTable))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("SIGN_IN_SUBTITLE".localize(table: uiTable))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
            }
            .listRowBackground(Color.clear)
            .padding(.top, -10)
            
            Section {
                VStack(alignment: .center) {
                    TextField("LOGIN_FORM_TEXTFIELD_NAME".localize(table: setupTable), text: $username)
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
                        Text("SIGN_IN_HELP_BUTTON_FORGOT".localize(table: uiTable))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.accent)
                    }
                    .buttonStyle(.plain)
                    .disabled(showingOptionsAlert)
                    Spacer()
                    if !isMainSheet {
                        ZStack {
                            NavigationLink(destination: ParentGuardianSignInView()) {}
                            .opacity(0)
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                            Text("SIGN_IN_FOR_CHILD_BUTTON_TITLE".localize(table: uiTable))
                                .foregroundStyle(.accent)
                        }
                    }
                }
                .alert("SIGN_IN_HELP_ALERT_TITLE_FORGOT_OR_CREATE".localize(table: uiTable), isPresented: $showingOptionsAlert) {
                    Button("IFORGOT_BUTTON_REBRAND".localize(table: table), role: .none) {
                        showingForgotPasswordSheet.toggle()
                    }
                    Button("SIGN_IN_HELP_ALERT_BUTTON_CREATE".localize(table: uiTable), role: .none) {
                        showingErrorAlert.toggle()
                    }
                    Button("SIGN_IN_HELP_ALERT_BUTTON_CANCEL".localize(table: uiTable), role: .cancel) {}
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
                            Text(.init("CREATE_ICLOUD_MAIL_ACCOUNT_EXPLANATION_FOOTER_REBRAND".localize(table: table) + "\n[\("CREATE_ICLOUD_MAIL_ACCOUNT_FOOTER_LEARN_MORE_BUTTON".localize(table: table))](\("CREATE_ICLOUD_MAIL_ACCOUNT_FOOTER_LEARN_MORE_KB_LINK".localize(table: table)))\n"))
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
                        Button("AUTHENTICATE_VIEW_BUTTON_TITLE".localize(table: setupTable)) {
                            signingIn.toggle()
                        }
                    } message: {
                        Text("BAD_NETWORK_ALERT_MESSAGE_REBRAND".localize(table: uiTable))
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
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
    }
}

#Preview {
    NavigationStack {
        AppleAccountLoginView()
    }
}
