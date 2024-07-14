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
    
    var body: some View {
        ZStack {
            List {
                VStack(alignment: .center, spacing: 15) {
                    Image("appleAccount")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                    Text("Apple Account")
                        .font(.title)
                        .bold()
                    Text("Choose the method to sign in yourself or a child in your family on this device.")
                }
                .multilineTextAlignment(.center)
                .listRowBackground(Color.clear)
                .padding(.horizontal, 5)
                .padding(.top, -10)
                
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
                                    .frame(width: 70)
                                VStack(alignment: .leading) {
                                    Text("**Use Another Apple Device**")
                                    Text("Bring another Apple device nearby to sign in quickly and easily. Available for iOS 17 and later.")
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
                                    Text("**Sign in Manually**")
                                    Text("Enter an email address or phone number and password then verify your identity.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(5)
                            }
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                ZStack {
                    Color(UIColor.secondarySystemGroupedBackground)
                        .frame(maxWidth: .infinity)
                        .frame(height: UIDevice.HomeButtonCapability ? 50 : 100)
                        .opacity(Device().isPhone ? 1 : 0)
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("Don‘t have an Apple Account?")
                            .bold()
                    }
                    .alert("Could Not Create Apple Account", isPresented: $showingAlert) {
                        Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                        Button("OK") {
                            dismiss()
                        }
                    } message: {
                        Text("The iPhoneSimulator has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this iPhoneSimulator.")
                    }
                }
            }
        }
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
        }
    }
}

#Preview {
    NavigationStack {
        SelectSignInOptionView()
    }
}
