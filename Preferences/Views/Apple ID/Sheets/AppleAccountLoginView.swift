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
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center, spacing: 15) {
                    Image("AppleAccount_Icon_Blue90x90")
                        .foregroundStyle(.blue)
                        .font(.largeTitle)
                    Text("Apple ID")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Sign in with an email or phone number to use iCloud, the App Store, Messages, or other Apple services.")
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 15)
            }
            .listRowBackground(Color.clear)
            
            Section {
                VStack(alignment: .center) {
                    TextField("Email or Phone Number", text: $username)
                        .padding(.vertical)
                        .padding(.leading, 5)
                        .frame(height: 48)
                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                    Spacer()
                    Button(action: {}, label: {
                        Text("Forgot password or don‘t have an Apple ID?")
                            .multilineTextAlignment(.center)
                    })
                    Spacer()
                    Button(action: {}, label: {
                        Text("Sign in a child in my Family")
                            .multilineTextAlignment(.center)
                    })
                }
            }
            .listRowBackground(Color.clear)
            
            Section {
                VStack {
                    Button(action: {}, label: {
                        Image("GDPR_Blue")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 23)
                        Text("Your Apple ID information is used to enable Apple services when you sign in, including iCloud Backup, which automatically backs up the data on your device in case you need to replace or restore it. Your device serial number may be used to check eligibility for service offers.\n[See how your data is managed..](_)\n")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    })
                    
                    Button(action: {
                        // Empty
                    }, label: {
                        Text("Continue")
                            .fontWeight(.medium)
                            .font(.headline)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(username.count < 1 ? Color(UIColor.systemGray5) : Color.blue)
                            .foregroundStyle(username.count < 1 ? Color(UIColor.systemGray) : Color.white)
                            .cornerRadius(15)
                    })
                    .frame(height: 50)
                    .disabled(username.count < 1)
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                })
            })
        }
    }
}

#Preview {
    NavigationStack {
        AppleAccountLoginView()
    }
}
