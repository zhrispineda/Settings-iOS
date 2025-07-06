//
//  BiometricPasscodeView.swift
//  Preferences
//
//  Settings > [Face ID/Touch ID] & Passcode
//

import SwiftUI

struct BiometricPasscodeView: View {
    @AppStorage("SiriEnabled") private var siriEnabled = false
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
    @State private var showingHelpSheet = false
    @State private var showingPrivacySheet = false
    let path = "/System/Library/PrivateFrameworks/PasscodeAndBiometricsSettings.framework/"
    let table = "Pearl"
    let lockTable = "Passcode Lock"
    let payTable = "Payment_Prefs"
    let oldTable = "TouchID"
    
    var body: some View {
        CustomList {
            Placard(title: UIDevice.PearlIDCapability ? "PASSCODE_PLACARD_TITLE_FACE_ID".localized(path: path, table: lockTable) : "PASSCODE_PLACARD_TITLE_TOUCH_ID".localized(path: path, table: lockTable), icon: UIDevice.PearlIDCapability ? "com.apple.graphic-icon.face-id" : "com.apple.graphic-icon.touch-id", description: "\(UIDevice.PearlIDCapability ? "PASSCODE_PLACARD_SUBTITLE_FACE_ID".localize(table: lockTable) : "PASSCODE_PLACARD_SUBTITLE_TOUCH_ID".localize(table: lockTable)) [\("PASSCODE_RECOVERY_LEARN_MORE_TEXT".localize(table: lockTable))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
            
            Section {
                Toggle("TOUCHID_UNLOCK".localize(table: oldTable), isOn: $allowFingerprintForUnlock)
                Toggle("TOUCHID_PURCHASES".localize(table: oldTable), isOn: $allowFingerprintForStore)
                Toggle("TOUCHID_STOCKHOLM".localize(table: payTable), isOn: $allowFingerprintForContactlessPayment)
                Toggle("SAFARI_AUTOFILL".localize(table: oldTable), isOn: $forceAuthenticationBeforeAutoFill)
            } header: {
                Text(UIDevice.PearlIDCapability ? "PEARL_HEADER".localized(path: path, table: lockTable) : "USE_TOUCHID_FOR".localize(table: oldTable))
            } footer: {
                Text(.init(UIDevice.PearlIDCapability ? "PEARL_FOOTER".localize(table: table, "[\("PEARL_FOOTER_LINK".localize(table: table))](pref://privacy)") : "Touch ID lets you use your fingerprint to unlock your device and make purchases with Apple Pay, App Store, and Apple Books. [About Touch ID & Privacy…](pref://privacy)"))
            }
            
            if UIDevice.PearlIDCapability {
                Section {
                    Button("SET_UP_FACE_ID".localized(path: path, table: lockTable)) {}
                }
                
                Section {
                    Toggle("PEARL_UNLOCK_ATTENTION_TITLE".localized(path: path, table: lockTable), isOn: $requireAttentionForUnlock)
                } header: {
                    Text("ATTENTION_HEADER".localized(path: path, table: lockTable))
                } footer: {
                    Text("PEARL_ATTENTION_FOOTER".localize(table: table) + "\(UIDevice.iPhone ? " Face ID will always require attention when you‘re wearing a mask." : "")")
                }
                
                Section {
                    Toggle("PEARL_ATTENTION_TITLE".localized(path: path, table: lockTable), isOn: $attentionAwareFeatures)
                } footer: {
                    Text("PEARL_ATTENTION_FEATURES_FOOTER", tableName: table)
                }
                
                if UIDevice.iPhone {
                    Section {
                        SettingsLink("DTO_STATUS_LABEL_DESCRIPTION".localized(path: path, table: lockTable), status: "DTO_STATUS_LABEL_DESCRIPTION_STATE_OFF".localized(path: path, table: lockTable), destination: EmptyView())
                            .disabled(true)
                    } footer: {
                        Text(UIDevice.PearlIDCapability ? "DTO_GROUP_DISABLED_REASON_FOOTER_DESCRIPTION_FACE_ID".localized(path: path, table: lockTable) : "DTO_GROUP_DISABLED_REASON_FOOTER_DESCRIPTION_TOUCH_ID".localized(path: path, table: lockTable))
                    }
                }
            } else {
                Section("FINGERPRINTS".localized(path: path, table: oldTable)) {
                    Button("ADD_FINGERPRINT".localized(path: path, table: oldTable)) {}
                }
            }
            
            Section {
                Button("PASSCODE_ON".localized(path: path, table: lockTable)) {}
                Button("CHANGE_PASSCODE".localized(path: path, table: lockTable)) {}
                    .disabled(true)
            }
            
            Section {
                SettingsLink("PASSCODE_REQ".localize(table: lockTable), status: "ALWAYS".localize(table: lockTable), destination: EmptyView())
                    .disabled(true)
            }
            
            Section {
                Toggle("VOICE_DIAL".localized(path: path, table: lockTable), isOn: $voiceDial)
                    .disabled(true)
            } footer: {
                Text("VOICE_DIAL_TEXT".localized(path: path, table: lockTable))
            }
            
            Section {
                Toggle("TODAY_VIEW".localized(path: path, table: lockTable), isOn: $allowLockScreenTodayView)
                Toggle("NOTIFICATIONS_VIEW".localized(path: path, table: lockTable), isOn: $allowLockScreenNotificationsView)
                Toggle("CONTROL_CENTER".localized(path: path, table: lockTable), isOn: $allowLockScreenControlCenter)
                Toggle("COMPLICATIONS".localized(path: path, table: lockTable), isOn: $allowLockScreenWidgets)
                Toggle("LIVE_ACTIVITIES".localized(path: path, table: lockTable), isOn: $allowLockScreenLiveActivities)
                if siriEnabled {
                    Toggle("SIRI".localized(path: path, table: lockTable), isOn: $allowAssistantWhileLocked)
                }
                if UIDevice.iPhone {
                    Toggle("REPLY_WITH_MESSAGE".localized(path: path, table: lockTable), isOn: $allowReplyWhileLocked)
                }
                Toggle("HOME_CONTROL".localized(path: path, table: lockTable), isOn: $allowHomeControlWhileLocked)
                if UIDevice.iPhone {
                    Toggle("WALLET".localized(path: path, table: lockTable), isOn: $allowPassbookWhileLocked)
                }
                Toggle("RETURN_MISSED_CALLS".localized(path: path, table: lockTable), isOn: $allowReturnCallsWhileLocked)
                Toggle("ACCESSORIES".localized(path: path, table: lockTable), isOn: $allowUSBRestrictedMode.animation())
            } header: {
                Text("ALLOW_ACCESS_WHEN_LOCKED".localized(path: path, table: lockTable))
            } footer: {
                Text(allowUSBRestrictedMode ? "ACCESSORIES_ON" : "ACCESSORIES_OFF", tableName: lockTable)
            }
            .disabled(true)
            
            Section {
                Toggle("WIPE_DEVICE".localized(path: path, table: lockTable), isOn: $allowEraseAfterFailedAttempts)
                    .disabled(true)
                    .confirmationDialog(
                        "WIPE_DEVICE_ALERT_TITLE".localize(table: lockTable),
                        isPresented: $showingEraseConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("WIPE_DEVICE_ALERT_OK".localized(path: path, table: lockTable), role: .destructive) {}
                        Button("WIPE_DEVICE_ALERT_CANCEL".localized(path: path, table: lockTable), role: .cancel) {
                            allowEraseAfterFailedAttempts = false
                        }
                    }
                    .onChange(of: allowEraseAfterFailedAttempts) {
                        showingEraseConfirmation = allowEraseAfterFailedAttempts
                    }
            } footer: {
                Text("WIPE_DEVICE_TEXT".localize(table: lockTable, "10"))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(UIDevice.PearlIDCapability ? "PEARL_ID_AND_PASSCODE".localize(table: table) : "TOUCHID_PASSCODE".localize(table: oldTable))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            } else if url.absoluteString == "pref://privacy" {
                showingPrivacySheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? UIDevice.PearlIDCapability ? "iph6d162927a" : "iph672384a0b" : UIDevice.PearlIDCapability ? "ipad66441e44" : "ipadcb11e17d")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OnBoardingKitView(bundleID: UIDevice.PearlIDCapability ? "com.apple.onboarding.faceid" : "com.apple.onboarding.touchid")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        BiometricPasscodeView()
    }
}
