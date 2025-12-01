//
//  BiometricPasscodeView.swift
//  Preferences
//
//  Settings > [[Face ID/Touch ID] & Passcode/Passcode]
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
    @State private var showingPearlSetupPopover = false
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
    @State private var workoutHealthData = false
    @State private var allowEraseAfterFailedAttempts = false
    @State private var showingEraseConfirmation = false
    @State private var titleVisible = false
    @State private var showingHelpSheet = false
    @State private var showingPrivacySheet = false
    let path = "/System/Library/PrivateFrameworks/PasscodeAndBiometricsSettings.framework"
    let pref = "/System/Library/PrivateFrameworks/Preferences.framework"
    let pearl = "Pearl"
    let passcode = "Passcode Lock"
    let pay = "/System/Library/PreferenceBundles/PaymentContactlessSettingsUIPlugin.bundle"
    let payment = "Payment_Prefs"
    let facePrivacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.faceid.bundle"
    let touchPrivacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.touchid.bundle"
    var title: String {
        return UIDevice.PearlIDCapability
        ? "PASSCODE_PLACARD_TITLE_FACE_ID".localized(path: path, table: passcode)
        : "PASSCODE_PLACARD_TITLE_TOUCH_ID".localized(path: path, table: passcode)
    }
    var footer: String {
        return UIDevice.PearlIDCapability
        ? "PEARL_FOOTER".localized(path: path, table: passcode, "BUTTON_TITLE".localized(path: facePrivacy, table: "FaceID"))
        : "USE_TOUCHID_FOR_GROUP_FOOTER_PREFIX".localized(path: path, table: passcode, "BUTTON_TITLE".localized(path: touchPrivacy, table: "TouchID"))
    }
    var footerLink: String {
        return UIDevice.PearlIDCapability
        ? "BUTTON_TITLE".localized(path: facePrivacy, table: "FaceID")
        : "BUTTON_TITLE".localized(path: touchPrivacy, table: "TouchID")
    }
    
    var body: some View {
        CustomList(title: titleVisible ? title : "") {
            Placard(
                title: title,
                icon: UIDevice.PearlIDCapability ? "com.apple.graphic-icon.face-id" : "com.apple.graphic-icon.touch-id",
                description: "\(UIDevice.PearlIDCapability ? "PASSCODE_PLACARD_SUBTITLE_FACE_ID".localized(path: path, table: passcode).replacing("helpkit://open", with: "pref://helpkit") : "PASSCODE_PLACARD_SUBTITLE_TOUCH_ID".localized(path: path, table: passcode).replacing("helpkit://open", with: "pref://helpkit"))",
                isVisible: $titleVisible
            )
            
            Section {
                Toggle("TOUCHID_UNLOCK".localized(path: path, table: passcode), isOn: $allowFingerprintForUnlock)
                if UIDevice.iPad {
                    Toggle("Wallet & Apple Pay".localized(path: pay), isOn: $allowFingerprintForContactlessPayment)
                }
                Toggle("TOUCHID_PURCHASES".localized(path: path, table: passcode), isOn: $allowFingerprintForStore)
                if UIDevice.iPhone {
                    Toggle("TOUCHID_STOCKHOLM".localized(path: pref, table: payment), isOn: $allowFingerprintForContactlessPayment)
                }
                Toggle("SAFARI_AUTOFILL".localized(path: path, table: passcode), isOn: $forceAuthenticationBeforeAutoFill)
            } header: {
                Text(UIDevice.PearlIDCapability ? "PEARL_HEADER".localized(path: path, table: passcode) : "USE_TOUCHID_FOR".localized(path: path, table: passcode))
            } footer: {
                PSFooterHyperlinkView(
                    footerText: footer,
                    linkText: footerLink,
                    onLinkTap: {
                        showingPrivacySheet = true
                    }
                )
            }
            
            if UIDevice.PearlIDCapability {
                Section {
                    Button("SET_UP_FACE_ID".localized(path: path, table: passcode)) {
                        showingPearlSetupPopover = true
                    }
                }
                
                Section {
                    Toggle("PEARL_UNLOCK_ATTENTION_TITLE".localized(path: path, table: passcode), isOn: $requireAttentionForUnlock)
                } header: {
                    Text("ATTENTION_HEADER".localized(path: path, table: passcode))
                } footer: {
                    Text("PEARL_ATTENTION_FOOTER".localized(path: path, table: passcode))
                }
                
                Section {
                    Toggle("PEARL_ATTENTION_TITLE".localized(path: path, table: passcode), isOn: $attentionAwareFeatures)
                } footer: {
                    Text("PEARL_ATTENTION_FEATURES_FOOTER".localized(path: path, table: passcode))
                }
                
                if UIDevice.iPhone {
                    Section {
                        SettingsLink(
                            "DTO_STATUS_LABEL_DESCRIPTION".localized(path: path, table: passcode),
                            status: "DTO_STATUS_LABEL_DESCRIPTION_STATE_OFF".localized(path: path, table: passcode),
                            destination: EmptyView()
                        )
                        .disabled(true)
                    } footer: {
                        Text(UIDevice.PearlIDCapability
                             ? "DTO_GROUP_DISABLED_REASON_FOOTER_DESCRIPTION_FACE_ID".localized(path: path, table: passcode)
                             : "DTO_GROUP_DISABLED_REASON_FOOTER_DESCRIPTION_TOUCH_ID".localized(path: path, table: passcode))
                    }
                }
            } else {
                Section("FINGERPRINTS".localized(path: path, table: passcode)) {
                    Button("ADD_FINGERPRINT".localized(path: path, table: passcode)) {}
                }
            }
            
            Section {
                Button("PASSCODE_ON".localized(path: path, table: passcode)) {}
                Button("CHANGE_PASSCODE".localized(path: path, table: passcode)) {}
                    .disabled(true)
            }
            
            Section {
                SettingsLink(
                    "PASSCODE_REQ".localized(path: path, table: passcode),
                    status: "ALWAYS".localized(path: path, table: passcode),
                    destination: EmptyView()
                )
                .disabled(true)
            }
            
            Section {
                Toggle("VOICE_DIAL".localized(path: path, table: passcode), isOn: $voiceDial)
                    .disabled(true)
            } footer: {
                Text("VOICE_DIAL_TEXT".localized(path: path, table: passcode))
            }
            
            Section {
                Toggle("TODAY_VIEW".localized(path: path, table: passcode), isOn: $allowLockScreenTodayView)
                Toggle("NOTIFICATIONS_VIEW".localized(path: path, table: passcode), isOn: $allowLockScreenNotificationsView)
                Toggle("CONTROL_CENTER".localized(path: path, table: passcode), isOn: $allowLockScreenControlCenter)
                Toggle("COMPLICATIONS".localized(path: path, table: passcode), isOn: $allowLockScreenWidgets)
                Toggle("LIVE_ACTIVITIES".localized(path: path, table: passcode), isOn: $allowLockScreenLiveActivities)
                if siriEnabled {
                    Toggle("SIRI".localized(path: path, table: passcode), isOn: $allowAssistantWhileLocked)
                }
                if UIDevice.iPhone {
                    Toggle("REPLY_WITH_MESSAGE".localized(path: path, table: passcode), isOn: $allowReplyWhileLocked)
                }
                Toggle("HOME_CONTROL".localized(path: path, table: passcode), isOn: $allowHomeControlWhileLocked)
                if UIDevice.iPhone {
                    Toggle("WALLET".localized(path: path, table: passcode), isOn: $allowPassbookWhileLocked)
                }
                Toggle("RETURN_MISSED_CALLS".localized(path: path, table: passcode), isOn: $allowReturnCallsWhileLocked)
                Toggle("WORKOUT_HEALTH_DATA".localized(path: path, table: passcode), isOn: $workoutHealthData)
            } header: {
                Text("ALLOW_ACCESS_WHEN_LOCKED".localized(path: path, table: passcode))
            } footer: {
                if UIDevice.iPhone {
                    Text("WALLET_FOOTER_TEXT".localized(path: path, table: passcode))
                }
            }
            .disabled(true)
            
            Section {
                Toggle("WIPE_DEVICE".localized(path: path, table: passcode), isOn: $allowEraseAfterFailedAttempts)
                    .disabled(true)
                    .alert(
                        "WIPE_DEVICE_ALERT_TITLE".localized(path: path, table: passcode, "10"),
                        isPresented: $showingEraseConfirmation
                    ) {
                        Button("WIPE_DEVICE_ALERT_OK".localized(path: path, table: passcode), role: .destructive) {}
                        Button("WIPE_DEVICE_ALERT_CANCEL".localized(path: path, table: passcode), role: .cancel) {
                            allowEraseAfterFailedAttempts = false
                        }
                    }
                    .onChange(of: allowEraseAfterFailedAttempts) {
                        showingEraseConfirmation = allowEraseAfterFailedAttempts
                    }
            } footer: {
                Text("WIPE_DEVICE_TEXT".localized(path: path, table: passcode, "10"))
            }
        }
        .onOpenURL { url in
            if url.absoluteString.hasPrefix("pref://helpkit") {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(
                topicID: UIDevice.iPhone
                ? UIDevice.PearlIDCapability ? "iph6d162927a" : "iph672384a0b"
                : UIDevice.PearlIDCapability ? "ipad66441e44" : "ipadcb11e17d"
            )
            .ignoresSafeArea(edges: .bottom)
            .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingPrivacySheet) {
            OnBoardingKitView(bundleID: UIDevice.PearlIDCapability
                              ? "com.apple.onboarding.faceid"
                              : "com.apple.onboarding.touchid"
            )
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showingPearlSetupPopover) {
            NavigationStack {
                // BiometricKitUI is not available in preview/simulator
                CustomViewController("/System/Library/PrivateFrameworks/BiometricKitUI.framework/BiometricKitUI", controller: "BKUIPearlEnrollController")
                    .ignoresSafeArea()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Back", systemImage: "chevron.left", role: .close) {
                                showingPearlSetupPopover.toggle()
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BiometricPasscodeView()
    }
}
