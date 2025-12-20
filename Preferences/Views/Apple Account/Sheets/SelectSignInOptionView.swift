//
//  SelectSignInOptionView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct SelectSignInOptionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    let path = "/System/Library/PrivateFrameworks/AppleIDSetup.framework"
    
    var body: some View {
        List {
            // Animated Apple logo, title, and description
            VStack(alignment: .leading, spacing: 10) {
                CustomView("AppleIDSetupUI", controller: "AppleIDSetupUI.AISAppleIDMicaView")
                    .frame(height: 100)
                Text("LOGIN_FORM_TITLE".localized(path: path))
                    .font(.title)
                    .bold()
                Text("SIGN_IN_OPTIONS_DESCRIPTION".localized(path: path))
                    .font(.title2)
                    .foregroundStyle(.secondary)
                Button("ACCOUNT_SETUP_CREATE_ACCOUNT_REBRAND".localized(path: path), systemImage: "info.circle.fill") {
                    showingAlert.toggle()
                }
                .labelIconToTitleSpacing(10)
            }
            .listRowBackground(Color.clear)
            
            // Use Another Apple Device Button
            Section {
                Group {
                    if UIDevice.IsSimulator || UIDevice.checkDevice() == nil {
                        Button {
                            dismiss()
                        } label: {
                            NavigationLink {} label: {
                                SignInMethodButton(image: "ProximitySymbol-iPhone-iPad-2", title: "SIGN_IN_OPTION_ANOTHER_DEVICE_TITLE".localized(path: path), subtitle: "SIGN_IN_OPTION_ANOTHER_DEVICE_SUBTITLE_SOLARIUM".localized(path: path))
                            }
                        }
                    } else {
                        NavigationLink {
                            AKProximityAuthViewController()
                                .ignoresSafeArea()
                        } label: {
                            SignInMethodButton(image: "ProximitySymbol-iPhone-iPad-2", title: "SIGN_IN_OPTION_ANOTHER_DEVICE_TITLE".localized(path: path), subtitle: "SIGN_IN_OPTION_ANOTHER_DEVICE_SUBTITLE_SOLARIUM".localized(path: path))
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
                    SignInMethodButton(image: "ellipsis.rectangle", title: "DISCOVERING_VIEW_BUTTON_SIGN_IN_MANUAL".localized(path: path), subtitle: "SIGN_IN_OPTION_ENTER_PASSWORD_SUBTITLE".localized(path: path))
                }
                .listRowBackground(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.secondarySystemGroupedBackground))
            }
        }
        .padding(.top, -25)
        .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
        .scrollContentBackground(.hidden)
        .contentMargins(.horizontal, UIDevice.iPad ? 50 : 30, for: .scrollContent)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .close) {
                    dismiss()
                }
            }
        }
        .alert("Could Not Create Apple Account", isPresented: $showingAlert) {
            Link("Learn More", destination: URL(string: "https://support.apple.com/101661")!)
            Button("OK".localized(path: path)) {
                dismiss()
            }
        } message: {
            Text("This \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model) has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model).")
        }
    }
}

/// Buttons for options when choosing an Apple Account sign in method.
struct SignInMethodButton: View {
    let image: String
    let title: String
    let subtitle: String
    var chevron = false
    let path = "/System/Library/PrivateFrameworks/AppleIDSetupUI.framework"
    
    var body: some View {
        HStack {
            // Check if icon is an SF Symbol or an image asset
            if UIImage(systemName: image) != nil {
                Image(systemName: image)
                    .foregroundStyle(.blue)
                    .font(.system(size: 40))
                    .frame(width: 65)
            } else {
                Image(
                    image,
                    bundle: Bundle(path: UIDevice.RuntimePath + path)
                )
                .renderingMode(.template)
                .foregroundStyle(.blue)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(5)
            
            if chevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundStyle(.tertiary)
                    .fontWeight(.semibold)
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
    ContentView()
        .environment(PrimarySettingsListModel())
}
