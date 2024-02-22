//
//  SafetyCheckView.swift
//  Preferences
//
//  Settings > Privacy & Security > Safety Check
//

import SwiftUI

struct SafetyCheckView: View {
    // Variables
    @State private var showingAlert = false
    
    var body: some View {
        CustomList(title: "Safety Check") {
            Section {
                VStack(spacing: 10) {
                    Image(systemName: "person.badge.shield.checkmark.fill")
                        .foregroundStyle(.blue)
                        .font(.largeTitle)
                        .symbolRenderingMode(.hierarchical)
                    Text("Safety Check")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("If circumstances or trust levels change, Safety Check allows you to disconnect from people, apps, and devices you no longer want to be connected to.")
                        .font(.subheadline)
                    Text("[Learn More...](https://support.apple.com/guide/personal-safety/how-safety-check-works-ips2aad835e1/web)")
                        .font(.subheadline)
                        .padding(.vertical, 5)
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            
            Section {
                Button(action: {
                    showingAlert.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "person.2.gobackward")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.blue)
                            .font(.title)
                            .padding(.leading, -5)
                            .padding(.trailing, 5)
                        VStack(alignment: .leading) {
                            Text("Emergency Reset")
                                .bold()
                            Text("Immediately reset access for all people and apps, and review your account security.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .foregroundStyle(Color(UIColor.label))
                })
            }
            
            Section {
                Button(action: {
                    showingAlert.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "person.2.badge.gearshape.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.blue)
                            .font(.title2)
                            .padding(.leading, -5)
                            .padding(.trailing, 5)
                        VStack(alignment: .leading) {
                            Text("Manage Sharing & Access")
                                .bold()
                            Text("Customize which people and apps can access your information, and review your account security.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .font(.footnote)
                                .bold()
                        }
                    }
                    .foregroundStyle(Color(UIColor.label))
                })
            }
        }
        .alert("iCloud Account with Two-Factor Authentication Required", isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text("To use Safety Check, you must be signed in to your iCloud account and have two-factor authentication turned on. You can manage this in Settings. ")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Quick Exit", action: {})
            }
        }
    }
}

#Preview {
    NavigationStack {
        SafetyCheckView()
    }
}
