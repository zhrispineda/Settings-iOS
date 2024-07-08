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
                SectionHelp(title: "Safety Check", color: .white, iconColor: .blue, icon: "person.badge.shield.checkmark.fill", description: "Reset or manage access to your information across apps, devices, and people you‘re currently sharing with. [Learn More...](https://support.apple.com/guide/personal-safety/how-safety-check-works-ips2aad835e1/web)")
            }
            
            Section {
                Button {
                    showingAlert.toggle()
                } label: {
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
                    .foregroundStyle(Color["Label"])
                }
            }
            
            Section {
                Button {
                    showingAlert.toggle()
                } label: {
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
                    .foregroundStyle(Color["Label"])
                }
            }
        }
        .alert("iCloud Account with Two-Factor Authentication Required", isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text("To use Safety Check, you must be signed in to your iCloud account and have two-factor authentication turned on. You can manage this in Settings. ")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Quick Exit") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        SafetyCheckView()
    }
}
