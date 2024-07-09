//
//  BiometricPasscodeView.swift
//  Preferences
//
//  Settings > [Face ID/Touch ID] & Passcode
//

import SwiftUI

struct BiometricPasscodeView: View {
    // Variables
    @State private var allowFingerprintForUnlock = true
    @State private var allowFingerprintForStore = true
    @State private var allowFingerprintForContactlessPayment = true
    @State private var forceAuthenticationBeforeAutoFill = true
    
    @State private var allowMaskUnlock = false
    @State private var requireAttentionForUnlock = true
    @State private var attentionAwareFeatures = true
    
    @State private var allowLockScreenTodayView = true
    @State private var allowLockScreenNotificationsView = true
    @State private var allowLockScreenControlCenter = true
    @State private var allowLockScreenWidgets = true
    @State private var allowLockScreenLiveActivities = true
    @State private var allowAssistantWhileLocked = true
    @State private var allowReplyWhileLocked = true
    @State private var allowHomeControlWhileLocked = true
    @State private var allowPassbookWhileLocked = true
    @State private var allowReturnCallsWhileLocked = true
    @State private var allowUSBRestrictedMode = true
    
    @State private var allowEraseAfterFailedAttempts = false
    @State private var showingEraseConfirmation = false
    
    var body: some View {
        CustomList(title: "\(Device().hasFaceAuth ? "Face" : "Touch") ID & Passcode") {
            SectionHelp(title: "\(Device().hasFaceAuth ? "Face" : "Touch") ID & Passcode", color: Device().hasFaceAuth ? .green : .white, icon: Device().hasFaceAuth ? "faceid" : "touchid", description: "\(Device().hasFaceAuth ? "Manage apps using Face ID and other \(Device().model) access settings, set up alternate appearances, and change your passcode." : "Turn on Touch ID and set a passcode to unlock your \(Device().model), authorize purchases, and access sensitive data.") [Learn more...](\(Device().hasFaceAuth ? "https://support.apple.com/guide/iphone/set-up-face-id-iph6d162927a/ios" : "https://support.apple.com/guide/iphone/set-up-touch-id-iph672384a0b/ios"))")
            
            Section {
                Toggle("\(Device().model) Unlock", isOn: $allowFingerprintForUnlock)
                Toggle("iTunes & App Store", isOn: $allowFingerprintForStore)
                Toggle("Contactless & Payments", isOn: $allowFingerprintForContactlessPayment)
                Toggle("Password AutoFill", isOn: $forceAuthenticationBeforeAutoFill)
            } header: {
                Text("Use \(Device().hasFaceAuth ? "Face" : "Touch") ID for:")
            } footer: {
                Text(Device().hasFaceAuth ? "\(Device().model) can recognize the unique, three-dimensional features of your face to allow secure access to apps and payments. [About Face ID & Privacy...](#)" : "Touch ID lets you use your fingerprint to unlock your device and make purchases with Apple Pay, App Store, and Apple Books. [About Touch ID & Privacy...](#)")
            }
            
            if Device().hasFaceAuth {
                Section {
                    Button("Set Up an Alternate Appearance") {}
                } footer: {
                    Text("In addition to continuously learning how you look, Face ID can recognize an alternate appearance.")
                }
                
                if Device().isPhone {
                    Section {
                        Toggle("Face ID with a Mask", isOn: $allowMaskUnlock)
                    } footer: {
                        Text("Face ID is most accurate when it‘s set up for full-face recognition only. To use Face ID while wearing a mask, iPhone can recognize the unique features around the eye area to authenticate. You must be looking at your iPhone to use Face ID while wearing a mask.")
                    }
                }
                
                Section {
                    Button("Reset Face ID") {}
                        .tint(.red)
                }
                
                Section {
                    Toggle("Require Attention for Face ID", isOn: $requireAttentionForUnlock)
                } header: {
                    Text("Attention")
                } footer: {
                    Text("TrueDepth camera provides an additional level of security by verifying that you‘re looking at \(Device().model) before authenticating. Attention detection may not work with some sunglasses.\(Device().isPhone ? " Face ID will always require attention when you‘re wearing a mask." : "")")
                }
                
                Section {
                    Toggle("Attention Aware Features", isOn: $attentionAwareFeatures)
                } footer: {
                    Text("\(Device().model) will check for attention before dimming the display, expanding a notification when locked, or lowering the volume of some alerts.")
                }
                
                if Device().isPhone {
                    CustomNavigationLink(title: "Stolen Device Protection", status: "Off", destination: EmptyView())
                }
            } else {
                Section {
                    NavigationLink("Finger 1") {}
                    Button("Add a Fingerprint...") {}
                }
            }
            
            Section {
                Button("Turn Passcode Off") {}
                Button("Change Passcode") {}
            } footer: {
                Text("Changing your passcode on this \(Device().model) will not disconnect it from other devices or reset \(Device().isPhone ? "iPhone Mirroring, Wi-Fi sync," : "Wi-Fi sync") and watch pairing.")
            }
            
            Section {
                CustomNavigationLink(title: "Require Passcode", status: "Immediately", destination: EmptyView())
            }
            
            Section {
                Toggle("Today View and Search", isOn: $allowLockScreenTodayView)
                Toggle("Notification Center", isOn: $allowLockScreenNotificationsView)
                Toggle("Control Center", isOn: $allowLockScreenControlCenter)
                Toggle("Lock Screen Widgets", isOn: $allowLockScreenWidgets)
                Toggle("Live Activities", isOn: $allowLockScreenLiveActivities)
                Toggle("Siri", isOn: $allowAssistantWhileLocked)
                if Device().isPhone {
                    Toggle("Reply with Message", isOn: $allowReplyWhileLocked)
                }
                Toggle("Home Control", isOn: $allowHomeControlWhileLocked)
                if Device().isPhone {
                    Toggle("Wallet", isOn: $allowPassbookWhileLocked)
                }
                Toggle("Return Missed Calls", isOn: $allowReturnCallsWhileLocked)
                Toggle("Accessories", isOn: $allowUSBRestrictedMode.animation())
            } header: {
                Text("Allow Access when Locked:")
            } footer: {
                Text(allowUSBRestrictedMode ? "Turn off to prevent accessories from connecting when your \(Device().model) has been locked for more than an hour." : "Unlock \(Device().model) to allow accessories to connect when it has been more than an hour since your \(Device().model) was locked.")
            }
            
            Section {
                Toggle("Erase Data", isOn: $allowEraseAfterFailedAttempts)
                    .confirmationDialog(
                        "All data on this \(Device().model) will be erased after 10 failed passcode attempts.",
                        isPresented: $showingEraseConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Enable", role: .destructive) {}
                        Button("Cancel", role: .cancel) {
                            allowEraseAfterFailedAttempts = false
                        }
                    }
                    .onChange(of: allowEraseAfterFailedAttempts) {
                        showingEraseConfirmation = allowEraseAfterFailedAttempts
                    }
            } footer: {
                Text("Erase all data on this \(Device().model) after 10 failed passcode attempts.\n\nData protection is enabled.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        BiometricPasscodeView()
    }
}
