//
//  BiometricPasscodeView.swift
//  Preferences
//
//  Settings > [Face ID/Touch ID] & Passcode
//

import SwiftUI

struct BiometricPasscodeView: View {
    // Variables
    @State private var allowFingerprintForUnlock = false
    @State private var allowFingerprintForStore = false
    @State private var allowFingerprintForContactlessPayment = false
    @State private var forceAuthenticationBeforeAutoFill = false
    
    @State private var allowMaskUnlock = false
    @State private var requireAttentionForUnlock = true
    @State private var attentionAwareFeatures = true
    @State private var voiceDial = true
    
    @State private var allowLockScreenTodayView = true
    @State private var allowLockScreenNotificationsView = true
    @State private var allowLockScreenControlCenter = true
    @State private var allowLockScreenWidgets = true
    @State private var allowLockScreenLiveActivities = true
    @State private var allowAssistantWhileLocked = true
    @State private var allowReplyWhileLocked = true
    @State private var allowHomeControlWhileLocked = true
    @State private var allowPassbookWhileLocked = false
    @State private var allowReturnCallsWhileLocked = true
    @State private var allowUSBRestrictedMode = false
    
    @State private var allowEraseAfterFailedAttempts = false
    @State private var showingEraseConfirmation = false
    
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    
    var body: some View {
        CustomList {
            Placard(title: "\(UIDevice.PearlIDCapability ? "Face" : "Touch") ID & Passcode", color: UIDevice.PearlIDCapability ? .green : .white, icon: UIDevice.PearlIDCapability ? "faceid" : "touchid", description: "\(UIDevice.PearlIDCapability ? "Manage apps using Face ID and other \(UIDevice.current.model) access settings, set up alternate appearances, and change your passcode." : "Turn on Touch ID and set a passcode to unlock your \(UIDevice.current.model), authorize purchases, and access sensitive data.") [Learn more...](\(UIDevice.PearlIDCapability ? "https://support.apple.com/guide/iphone/set-up-face-id-iph6d162927a/ios" : "https://support.apple.com/guide/iphone/set-up-touch-id-iph672384a0b/ios"))")
                .overlay { // For calculating opacity of the principal toolbar item
                    GeometryReader { geo in
                        Color.clear
                            .onChange(of: geo.frame(in: .scrollView).minY) {
                                frameY = geo.frame(in: .scrollView).minY
                                opacity = frameY / -30
                            }
                    }
                }
            
            Section {
                Toggle("\(UIDevice.current.model) Unlock", isOn: $allowFingerprintForUnlock)
                Toggle("iTunes & App Store", isOn: $allowFingerprintForStore)
                Toggle("Contactless & Payments", isOn: $allowFingerprintForContactlessPayment)
                Toggle("Password AutoFill", isOn: $forceAuthenticationBeforeAutoFill)
            } header: {
                Text("Use \(UIDevice.PearlIDCapability ? "Face" : "Touch") ID for:")
            } footer: {
                Text(UIDevice.PearlIDCapability ? "\(UIDevice.current.model) can recognize the unique, three-dimensional features of your face to allow secure access to apps and payments. [About Face ID & Privacy...](#)" : "Touch ID lets you use your fingerprint to unlock your device and make purchases with Apple Pay, App Store, and Apple Books. [About Touch ID & Privacy...](#)")
            }
            
            if UIDevice.PearlIDCapability {
                Section {
                    Button("Set Up Face ID") {}
                } footer: {
//                    Text("In addition to continuously learning how you look, Face ID can recognize an alternate appearance.")
                }
                
//                if UIDevice.iPhone {
//                    Section {
//                        Toggle("Face ID with a Mask", isOn: $allowMaskUnlock)
//                    } footer: {
//                        Text("Face ID is most accurate when it‘s set up for full-face recognition only. To use Face ID while wearing a mask, iPhone can recognize the unique features around the eye area to authenticate. You must be looking at your iPhone to use Face ID while wearing a mask.")
//                    }
//                }
//                
//                Section {
//                    Button("Reset Face ID") {}
//                        .tint(.red)
//                }
                
                Section {
                    Toggle("Require Attention for Face ID", isOn: $requireAttentionForUnlock)
                } header: {
                    Text("Attention")
                } footer: {
                    Text("TrueDepth camera provides an additional level of security by verifying that you‘re looking at \(UIDevice.current.model) before authenticating. Attention detection may not work with some sunglasses.\(UIDevice.iPhone ? " Face ID will always require attention when you‘re wearing a mask." : "")")
                }
                
                Section {
                    Toggle("Attention Aware Features", isOn: $attentionAwareFeatures)
                } footer: {
                    Text("\(UIDevice.current.model) will check for attention before dimming the display, expanding a notification when locked, or lowering the volume of some alerts.")
                }
                
                if UIDevice.iPhone {
                    Section {
                        CustomNavigationLink(title: "Stolen Device Protection", status: "Off", destination: EmptyView())
                            .disabled(true)
                    } footer: {
                        Text("Stolen Device Protection is only available when Face ID is set up.")
                    }
                }
            } else {
                Section {
                    NavigationLink("Finger 1") {}
                    Button("Add a Fingerprint...") {}
                }
            }
            
            Section {
                Button("Turn Passcode On") {}
                Button("Change Passcode") {}
                    .disabled(true)
            } footer: {
//                Text("Changing your passcode on this \(UIDevice.current.model) will not disconnect it from other devices or reset \(UIDevice.iPhone ? "iPhone Mirroring, Wi-Fi sync," : "Wi-Fi sync") and watch pairing.")
            }
            
            Section {
                CustomNavigationLink(title: "Require Passcode", status: "Immediately", destination: EmptyView())
                    .disabled(true)
            }
            
            Section {
                Toggle("Voice Dial", isOn: $voiceDial)
                    .disabled(true)
            } footer: {
                Text("Music Voice Control is always enabled.")
            }
            
            Section {
                Toggle("Today View and Search", isOn: $allowLockScreenTodayView)
                Toggle("Notification Center", isOn: $allowLockScreenNotificationsView)
                Toggle("Control Center", isOn: $allowLockScreenControlCenter)
                Toggle("Lock Screen Widgets", isOn: $allowLockScreenWidgets)
                Toggle("Live Activities", isOn: $allowLockScreenLiveActivities)
                Toggle("Siri", isOn: $allowAssistantWhileLocked)
                if UIDevice.iPhone {
                    Toggle("Reply with Message", isOn: $allowReplyWhileLocked)
                }
                Toggle("Home Control", isOn: $allowHomeControlWhileLocked)
                if UIDevice.iPhone {
                    Toggle("Wallet", isOn: $allowPassbookWhileLocked)
                }
                Toggle("Return Missed Calls", isOn: $allowReturnCallsWhileLocked)
                Toggle("Accessories", isOn: $allowUSBRestrictedMode.animation())
            } header: {
                Text("Allow Access when Locked:")
            } footer: {
                Text(allowUSBRestrictedMode ? "Turn off to prevent accessories from connecting when your \(UIDevice.current.model) has been locked for more than an hour." : "Unlock \(UIDevice.current.model) to allow accessories to connect when it has been more than an hour since your \(UIDevice.current.model) was locked.")
            }
            .disabled(true)
            
            Section {
                Toggle("Erase Data", isOn: $allowEraseAfterFailedAttempts)
                    .disabled(true)
                    .confirmationDialog(
                        "All data on this \(UIDevice.current.model) will be erased after 10 failed passcode attempts.",
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
                Text("Erase all data on this \(UIDevice.current.model) after 10 failed passcode attempts.")//\n\nData protection is enabled.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(UIDevice.PearlIDCapability ? "Face" : "Touch") ID & Passcode")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        BiometricPasscodeView()
    }
}
