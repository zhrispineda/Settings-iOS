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
    
    let table = "Pearl"
    let lockTable = "Passcode Lock"
    let payTable = "Payment_Prefs"
    let oldTable = "TouchID"
    let dtoTable = "PasscodeLock-DimpleKey"
    
    var body: some View {
        CustomList {
            Placard(title: UIDevice.PearlIDCapability ? "PEARL_ID_AND_PASSCODE".localize(table: table) : "TOUCHID_PASSCODE".localize(table: oldTable), icon: UIDevice.PearlIDCapability ? "com.apple.graphic-icon.face-id" : "com.apple.graphic-icon.touch-id", description: "\(UIDevice.PearlIDCapability ? "PASSCODE_PLACARD_SUBTITLE_FACE_ID".localize(table: lockTable) : "PASSCODE_PLACARD_SUBTITLE_TOUCH_ID".localize(table: lockTable)) [\("PASSCODE_RECOVERY_LEARN_MORE_TEXT".localize(table: lockTable))](pref://helpkit)", frameY: $frameY, opacity: $opacity)
            
            Section {
                Toggle("TOUCHID_UNLOCK".localize(table: oldTable), isOn: $allowFingerprintForUnlock)
                Toggle("TOUCHID_PURCHASES".localize(table: oldTable), isOn: $allowFingerprintForStore)
                Toggle("TOUCHID_STOCKHOLM".localize(table: payTable), isOn: $allowFingerprintForContactlessPayment)
                Toggle("SAFARI_AUTOFILL".localize(table: oldTable), isOn: $forceAuthenticationBeforeAutoFill)
            } header: {
                Text(UIDevice.PearlIDCapability ? "PEARL_HEADER".localize(table: table) : "USE_TOUCHID_FOR".localize(table: oldTable))
            } footer: {
                Text(.init(UIDevice.PearlIDCapability ? "PEARL_FOOTER".localize(table: table, "[\("PEARL_FOOTER_LINK".localize(table: table))](pref://privacy)") : "Touch ID lets you use your fingerprint to unlock your device and make purchases with Apple Pay, App Store, and Apple Books. [About Touch ID & Privacy…](pref://privacy)"))
            }
            
            if UIDevice.PearlIDCapability {
                Section {
                    Button("SET_UP_FACE_ID".localize(table: table)) {}
                }
                
                Section {
                    Toggle("PEARL_UNLOCK_ATTENTION_TITLE".localize(table: table), isOn: $requireAttentionForUnlock)
                } header: {
                    Text("ATTENTION_HEADER", tableName: table)
                } footer: {
                    Text("PEARL_ATTENTION_FOOTER".localize(table: table) + "\(UIDevice.iPhone ? " Face ID will always require attention when you‘re wearing a mask." : "")")
                }
                
                Section {
                    Toggle("PEARL_ATTENTION_TITLE".localize(table: table), isOn: $attentionAwareFeatures)
                } footer: {
                    Text("PEARL_ATTENTION_FEATURES_FOOTER", tableName: table)
                }
                
                if UIDevice.iPhone {
                    Section {
                        SettingsLink("DTO_STATUS_LABEL_DESCRIPTION".localize(table: dtoTable), status: "DTO_STATUS_LABEL_DESCRIPTION_STATE_OFF".localize(table: dtoTable), destination: EmptyView())
                            .disabled(true)
                    } footer: {
                        Text(UIDevice.PearlIDCapability ? "DTO_GROUP_DISABLED_REASON_FOOTER_DESCRIPTION_FACE_ID" : "DTO_GROUP_DISABLED_REASON_FOOTER_DESCRIPTION_TOUCH_ID", tableName: dtoTable)
                    }
                }
            } else {
                Section("FINGERPRINTS".localize(table: oldTable)) {
                    //NavigationLink("IDENTITY_NAME_FORMAT".localize(table: oldTable, "1")) {}
                    Button("ADD_FINGERPRINT".localize(table: oldTable)) {}
                }
            }
            
            Section {
                Button("PASSCODE_ON".localize(table: lockTable)) {}
                Button("CHANGE_PASSCODE".localize(table: lockTable)) {}
                    .disabled(true)
            }
            
            Section {
                SettingsLink("PASSCODE_REQ".localize(table: lockTable), status: "ALWAYS".localize(table: lockTable), destination: EmptyView())
                    .disabled(true)
            }
            
            Section {
                Toggle("VOICE_DIAL".localize(table: lockTable), isOn: $voiceDial)
                    .disabled(true)
            } footer: {
                Text("VOICE_DIAL_TEXT", tableName: lockTable)
            }
            
            Section {
                Toggle("TODAY_VIEW".localize(table: lockTable), isOn: $allowLockScreenTodayView)
                Toggle("NOTIFICATIONS_VIEW".localize(table: lockTable), isOn: $allowLockScreenNotificationsView)
                Toggle("CONTROL_CENTER".localize(table: lockTable), isOn: $allowLockScreenControlCenter)
                Toggle("COMPLICATIONS".localize(table: lockTable), isOn: $allowLockScreenWidgets)
                Toggle("LIVE_ACTIVITIES".localize(table: lockTable), isOn: $allowLockScreenLiveActivities)
                if siriEnabled {
                    Toggle("Siri", isOn: $allowAssistantWhileLocked)
                }
                if UIDevice.iPhone {
                    Toggle("REPLY_WITH_MESSAGE".localize(table: lockTable), isOn: $allowReplyWhileLocked)
                }
                Toggle("HOME_CONTROL".localize(table: lockTable), isOn: $allowHomeControlWhileLocked)
                if UIDevice.iPhone {
                    Toggle("WALLET".localize(table: lockTable), isOn: $allowPassbookWhileLocked)
                }
                Toggle("RETURN_MISSED_CALLS".localize(table: lockTable), isOn: $allowReturnCallsWhileLocked)
                Toggle("ACCESSORIES".localize(table: lockTable), isOn: $allowUSBRestrictedMode.animation())
            } header: {
                Text("ALLOW_ACCESS_WHEN_LOCKED", tableName: lockTable)
            } footer: {
                Text(allowUSBRestrictedMode ? "ACCESSORIES_ON" : "ACCESSORIES_OFF", tableName: lockTable)
            }
            .disabled(true)
            
            Section {
                Toggle("WIPE_DEVICE".localize(table: lockTable), isOn: $allowEraseAfterFailedAttempts)
                    .disabled(true)
                    .confirmationDialog(
                        "WIPE_DEVICE_ALERT_TITLE".localize(table: lockTable),
                        isPresented: $showingEraseConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("WIPE_DEVICE_ALERT_OK".localize(table: lockTable), role: .destructive) {}
                        Button("CANCEL".localize(table: lockTable), role: .cancel) {
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
