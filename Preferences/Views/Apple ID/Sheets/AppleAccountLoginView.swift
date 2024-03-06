//
//  AppleAccountLoginView.swift
//  Preferences
//
//  Settings > Sign in > Sign in Manually
//

import SwiftUI

struct AppleAccountLoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert: Bool = false
    @State var showSignIn: Bool = Bool()
    @State var firstName: String = String()
    @State var lastName: String = String()
    
    var body: some View {
        List { // TODO: Clean up
            Section {
                VStack(spacing: 15) {
                    Image("AppleAccount_Icon_Blue90x90")
                        .foregroundStyle(.blue)
                        .font(.largeTitle)
                    Text("Apple ID")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Sign in with an email or phone number to use iCloud, the App Store, Messages, or other Apple services.")
                        .multilineTextAlignment(.center)
                }
                .padding(30)
                .listRowBackground(Color(UIColor.systemBackground))
                .listRowSeparator(.hidden)
            }
            
            VStack {
                TextField("Email or Phone Number", text: $username)
                    .padding()
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                Spacer()
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Don't have an Apple ID?")
                        .foregroundStyle(.blue)
                })
                .alert("Could Not Create Apple ID",
                       isPresented: $showAlert
                ) {
                    Button {
                        if let url = URL(string: "https://support.apple.com/en-us/101661") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Learn More")
                    }
                    Button("OK") {}
                } message: {
                    Text("This iPhone has been used to create too many new Apple IDs. Contact Apple Support to request another Apple ID to use with this iPhone.")
                }
                Spacer()
                Button(action: {}, label: {
                    Text("Forgot Password?")
                        .foregroundStyle(.blue)
                })
            }
            
            VStack {
                Button(action: {}, label: {
                    Image("GDPR_Blue")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 23)
                    Text("Your Apple ID information is used to enable Apple services when you sign in, including iCloud Backup, which automatically backs up the data on your device in case you need to replace or restore it. Your device serial number may be used to check eligibility for service offers. [See how your data is managed..](_)")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                })
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            Button(action: {
                showSignIn.toggle()
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(username.count < 1 ? Color(UIColor.systemGray5) : Color.blue)
                    .foregroundStyle(username.count < 1 ? Color(UIColor.systemGray) : Color.white)
                    .cornerRadius(15)
            })
            .frame(height: 50)
            .listRowBackground(Color.clear)
            .disabled(username.count < 1)
            .listRowSeparator(.hidden)
        }
    }
}

#Preview {
    AppleAccountLoginView()
}
