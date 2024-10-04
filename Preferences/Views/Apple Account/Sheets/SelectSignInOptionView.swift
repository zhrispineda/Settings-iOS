//
//  SelectSignInOptionView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct SelectSignInOptionView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    let table = "AppleIDSetup"
    
    var body: some View {
        List {
            VStack(spacing: 15) {
                Image("appleAccount")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                Text("LOGIN_FORM_TITLE", tableName: table)
                    .font(.title)
                    .bold()
                Text("SIGN_IN_OPTIONS_DESCRIPTION", tableName: table)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Section {
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image("ProximitySymbol-iPhone-iPad")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.blue)
                                .frame(width: 64)
                            VStack(alignment: .leading) {
                                Text("SIGN_IN_OPTION_ANOTHER_DEVICE_TITLE", tableName: table)
                                    .bold()
                                Text("SIGN_IN_OPTION_ANOTHER_DEVICE_SUBTITLE", tableName: table)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(5)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                                .foregroundStyle(.tertiary)
                        }
                        .foregroundStyle(Color["Label"])
                    }
                }
            }
            
            Section {
                VStack {
                    NavigationLink {
                        AppleAccountLoginView()
                    } label: {
                        HStack {
                            Image(systemName: "ellipsis.rectangle")
                                .foregroundStyle(.blue)
                                .font(.system(size: 40))
                                .frame(width: 70)
                            VStack(alignment: .leading) {
                                Text("DISCOVERING_VIEW_BUTTON_SIGN_IN_MANUAL", tableName: table)
                                    .bold()
                                Text("SIGN_IN_OPTION_ENTER_PASSWORD_SUBTITLE", tableName: table)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(5)
                        }
                    }
                }
            }
        }
        .contentMargins(.horizontal, UIDevice.iPad ? 50 : 15, for: .scrollContent)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.gray, Color(UIColor.systemFill))
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    showingAlert.toggle()
                } label: {
                    Text("ACCOUNT_SETUP_CREATE_ACCOUNT_REBRAND", tableName: table)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 60)
                .alert("Could Not Create Apple Account", isPresented: $showingAlert) {
                    Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                    Button("OK".localize(table: table)) {
                        dismiss()
                    }
                } message: {
                    Text("This \(UIDevice.isSimulator ? "iPhoneSimulator" : UIDevice.current.model) has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this \(UIDevice.isSimulator ? "iPhoneSimulator" : UIDevice.current.model).")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectSignInOptionView()
    }
}
