//
//  BiometricPasscodeView.swift
//  Preferences
//
//  Settings > [Face ID/Touch ID] & Passcode
//

import SwiftUI

struct BiometricPasscodeView: View {
    var body: some View {
        CustomList(title: "\(Device().hasFaceAuth ? "Face" : "Touch") ID & Passcode") {
            SectionHelp(title: "\(Device().hasFaceAuth ? "Face" : "Touch") ID & Passcode", color: Device().hasFaceAuth ? .green : .white, icon: Device().hasFaceAuth ? "faceid" : "touchid", description: "\(Device().hasFaceAuth ? "Face ID uses facial recognition to unlock devices, while Passcode is a numeric code for manual device unlocking." : "Turn on Touch ID and set a passcode to unlock your \(Device().model), authorize purchases, and access sensitive data.") [Learn more...](\(Device().hasFaceAuth ? "https://support.apple.com/guide/iphone/set-up-face-id-iph6d162927a/ios" : "https://support.apple.com/guide/iphone/set-up-touch-id-iph672384a0b/ios"))")
        }
    }
}

#Preview {
    NavigationStack {
        BiometricPasscodeView()
    }
}
