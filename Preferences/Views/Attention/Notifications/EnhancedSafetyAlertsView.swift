//
//  EnhancedSafetyAlertsView.swift
//  Preferences
//

import SwiftUI

struct EnhancedSafetyAlertsView: View {
    @AppStorage("LocalAwarenessToggle") private var localAwareness = true
    @AppStorage("ImminentThreatAlertsToggle") private var imminentThreatAlerts = true
    @AppStorage("ImproveAlertDeliveryToggle") private var improveAlertDelivery = true
    @Environment(\.openURL) private var openURL
    private let eaPath = "/System/Library/PreferenceBundles/EmergencyAlertExtension.bundle"
    private let notifPath = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    private let saPath = "/System/Library/PrivateFrameworks/SafetyAlerts.framework"
    private let eaTable = "Localizable~IGNEOUS"
    private let notifTable = "NotificationsSettings"
    private let saTable = "safetyAlertsSettings"
    
    var body: some View {
        CustomList(title: "Enhanced Safety Alerts") {
            Section {
                Toggle("ENHANCED_DELIVERY_SWITCH_NAME".localized(path: eaPath, table: eaTable), isOn: $localAwareness)
                Toggle("SAFETY_ALERTS_OTHER_ALERTS".localized(path: saPath, table: saTable), isOn: $imminentThreatAlerts)
            } footer: {
                PSFooterHyperlinkView(
                    footerText: "SAFETY_ALERTS_OTHER_ALERTS_DESCRIPTION".localized(path: saPath, table: saTable)
                    + "SAFETY_ALERTS_LEARN_MORE".localized(path: notifPath, table: notifTable),
                    linkText: "SAFETY_ALERTS_LEARN_MORE".localized(path: notifPath, table: notifTable),
                    onLinkTap: {
                        openURL(URL(string: "https://support.apple.com/102516")!)
                    }
                )
            }
            
            Section {
                Toggle("SAFETY_ALERTS_IMPROVED_ALERT_DELIVERY".localized(path: saPath, table: saTable), isOn: $improveAlertDelivery)
            } footer: {
                Text("SAFETY_ALERTS_IMPROVED_ALERT_DELIVERY_DESCRIPTION".localized(path: saPath, table: saTable))
            }
            
            Section {} footer: {
                PSFooterHyperlinkView(
                    footerText: "SAFETY_ALERTS_ABOUT_PRIVACY".localized(path: notifPath, table: notifTable),
                    linkText: "SAFETY_ALERTS_ABOUT_PRIVACY".localized(path: notifPath, table: notifTable),
                    onLinkTap: {
                        let language = Bundle.main.preferredLocalizations.first ?? ""
                        openURL(URL(string: "https://www.apple.com/legal/privacy/data/\(language)/safety-features/")!)
                    }
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        EnhancedSafetyAlertsView()
    }
}
