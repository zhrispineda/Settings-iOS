//
//  SelectSignInOptionView.swift
//  Preferences
//
//  Settings > Sign in to your [Device]
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
                    Image("AppleAccount_Icon_Blue90x90")
                        .foregroundStyle(.blue)
                        .font(.system(size: 48))
                    Text("Apple ID")
                        .font(.title)
                        .bold()
                    Text("Choose the method to sign in yourself or a child in your family on this device.")
                }
                .multilineTextAlignment(.center)
                .listRowBackground(Color.clear)
                .padding(.horizontal, 5)
                
                Section {
                    VStack {
                        Button(action: {
                            dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "iphone.gen3")
                                    .foregroundStyle(.blue)
                                    .font(.system(size: 42))
                                    .padding(.horizontal, 5)
                                VStack(alignment: .leading) {
                                    Text("**Use Another Apple Device**")
                                    Text("Bring another Apple device nearby to sign in quickly and easily. Available for iOS 17 and later.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 5)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .imageScale(.small)
                                    .foregroundStyle(.tertiary)
                            }
                            .foregroundStyle(Color["Label"])
                        })
                    }
                }
                
                Section {
                    VStack {
                        NavigationLink(destination: {
                            AppleAccountLoginView()
                        }, label: {
                            HStack {
                                Image(systemName: "ellipsis.rectangle")
                                    .foregroundStyle(.blue)
                                    .font(.system(size: 40))
                                    .padding(.horizontal, 5)
                                VStack(alignment: .leading) {
                                    Text("**Sign in Manually**")
                                    Text("Enter an email address or phone number and password then verify your identity.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 5)
                            }
                        })
                    }
                }
            }
            VStack {
                Spacer()
                ZStack {
                    Color(UIColor.secondarySystemGroupedBackground)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .opacity(DeviceInfo().isPhone ? 1 : 0)
                    Button(action: {
                        showingAlert.toggle()
                    }, label: {
                        Text("**Don‘t have an Apple ID?**")
                    })
                    .alert("Could Not Create Apple ID", isPresented: $showingAlert, actions: {
                        Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                        Button("OK", action: {
                            dismiss()
                        })
                    }, message: {
                        Text("The iPhoneSimulator has been used to create too many new Apple IDs. Contact Apple Support to request another Apple ID to use with this iPhoneSimulator.")
                    })
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.gray, Color(UIColor.systemFill))
                })
            })
        }
    }
}

#Preview {
    NavigationStack {
        SelectSignInOptionView()
    }
}