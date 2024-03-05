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
                
                Section {
                    VStack {
                        Button(action: {}, label: {
                            Text("Use Another Apple Device")
                        })
                    }
                }
                
                Section {
                    VStack {
                        Button(action: {}, label: {
                            Text("Sign in Manually")
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
                    Button(action: {}, label: {
                        Text("**Don‘t have an Apple ID?**")
                    })
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "x.circle.fill")
                        .imageScale(.large)
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
