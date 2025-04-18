//
//  SelectSignInOptionView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct SelectSignInOptionView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    let table = "AppleIDSetup"
    
    var body: some View {
        List {
            // Animated Apple logo, title, and description
            VStack(spacing: 10) {
                CustomView(path: "/System/Library/PrivateFrameworks/AppleIDSetupUI.framework/AppleIDSetupUI", controller: "AppleIDSetupUI.AISAppleIDMicaView")
                    .frame(height: 100)
                Text("LOGIN_FORM_TITLE", tableName: table)
                    .font(.largeTitle)
                    .bold()
                Text("SIGN_IN_OPTIONS_DESCRIPTION", tableName: table)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .listRowBackground(Color.clear)
            
            // Use Another Apple Device Button
            Section {
                Group {
                    if UIDevice.IsSimulator || UIDevice.checkDevice() == nil {
                        Button {
                            dismiss()
                        } label: {
                            SignInMethodButton(image: "ProximitySymbol-iPhone-iPad", title: "SIGN_IN_OPTION_ANOTHER_DEVICE_TITLE", subtitle: "SIGN_IN_OPTION_ANOTHER_DEVICE_SUBTITLE", table: table, chevron: true)
                        }
                    } else {
                        NavigationLink {
                            ProximityViewController()
                                .ignoresSafeArea()
                        } label: {
                            SignInMethodButton(image: "ProximitySymbol-iPhone-iPad", title: "SIGN_IN_OPTION_ANOTHER_DEVICE_TITLE", subtitle: "SIGN_IN_OPTION_ANOTHER_DEVICE_SUBTITLE", table: table)
                        }
                    }
                }
                .foregroundStyle(.primary)
                .listRowBackground(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.secondarySystemGroupedBackground))
            }
            
            // Sign in Manually button
            Section {
                NavigationLink {
                    AppleAccountLoginView()
                } label: {
                    SignInMethodButton(image: "ellipsis.rectangle", title: "DISCOVERING_VIEW_BUTTON_SIGN_IN_MANUAL", subtitle: "SIGN_IN_OPTION_ENTER_PASSWORD_SUBTITLE", table: table)
                }
                .listRowBackground(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.secondarySystemGroupedBackground))
            }
        }
        .padding(.top, -25)
        .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
        .scrollContentBackground(.hidden)
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
                .padding(.bottom, UIDevice.iPad || UIDevice.HomeButtonCapability ? 5 : 60)
                .alert("Could Not Create Apple Account", isPresented: $showingAlert) {
                    Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                    Button("OK".localize(table: table)) {
                        dismiss()
                    }
                } message: {
                    Text("This \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model) has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model).")
                }
            }
        }
    }
}

struct SignInMethodButton: View {
    let image: String
    let title: String
    let subtitle: String
    let table: String
    var chevron = false
    
    var body: some View {
        HStack {
            // Check if icon is an SF Symbol or an image asset
            if UIImage(systemName: image) != nil {
                Image(systemName: image)
                    .foregroundStyle(.blue)
                    .font(.system(size: 40))
                    .frame(width: 65)
            } else {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blue)
                    .frame(width: 64)
            }
            
            VStack(alignment: .leading) {
                Text(title.localize(table: table))
                    .bold()
                Text(subtitle.localize(table: table))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(5)
            
            if chevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

#Preview("Sign In Options View") {
    NavigationStack {
        SelectSignInOptionView()
    }
}

#Preview("ContentView") {
    ContentView(stateManager: StateManager())
}
