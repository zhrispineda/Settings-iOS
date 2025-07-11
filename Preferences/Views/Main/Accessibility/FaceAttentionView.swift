//
//  FaceAttentionView.swift
//  Preferences
//
//  Settings > Accessibility > Face ID & Attention
//

import SwiftUI

struct FaceAttentionView: View {
    @State private var requireAttentionEnabled = true
    @State private var attentionAwareFeaturesEnabled = true
    @State private var hapticAuthentication = false
    let path = "/System/Library/PreferenceBundles/AccessibilitySettings.bundle"
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "FACE_ID".localized(path: path, table: table)) {
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("Pearl_Unlock_Attention_Title".localized(path: path, table: table), isOn: $requireAttentionEnabled)
                } footer: {
                    if UIDevice.iPhone {
                        Text("Pearl_Unlock_Attention_Footer_IPHONE".localized(path: path, table: table))
                    } else if UIDevice.iPad {
                        Text("Pearl_Unlock_Attention_Footer_IPAD".localized(path: path, table: table))
                    }
                }
            }
            
            Section {
                Toggle("Pearl_Attention_Title".localized(path: path, table: table), isOn: $attentionAwareFeaturesEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("Pearl_Attention_Footer_IPHONE".localized(path: path, table: table))
                } else if UIDevice.iPad {
                    Text("Pearl_Attention_Footer_IPAD".localized(path: path, table: table))
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    Toggle("Pearl_Success_Haptic".localized(path: path, table: table), isOn: $hapticAuthentication)
                } header: {
                    Text("Pearl_Success_Haptic_Group".localized(path: path, table: table))
                } footer: {
                    Text("Pearl_Success_Haptic_Footer_IPHONE".localized(path: path, table: table))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FaceAttentionView()
    }
}
