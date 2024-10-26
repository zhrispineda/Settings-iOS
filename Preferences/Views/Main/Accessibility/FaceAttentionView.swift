//
//  FaceAttentionView.swift
//  Preferences
//
//  Settings > Accessibility > Face ID & Attention
//

import SwiftUI

struct FaceAttentionView: View {
    // Variables
    @State private var requireAttentionEnabled = true
    @State private var attentionAwareFeaturesEnabled = true
    @State private var hapticAuthentication = false
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "FACE_ID".localize(table: table)) {
            if !UIDevice.IsSimulator {
                Section {
                    Toggle("Pearl_Unlock_Attention_Title".localize(table: table), isOn: $requireAttentionEnabled)
                } footer: {
                    if UIDevice.iPhone {
                        Text("Pearl_Unlock_Attention_Footer_IPHONE", tableName: table)
                    } else if UIDevice.iPad {
                        Text("Pearl_Unlock_Attention_Footer_IPAD", tableName: table)
                    }
                }
            }
            
            Section {
                Toggle("Pearl_Attention_Title".localize(table: table), isOn: $attentionAwareFeaturesEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("Pearl_Attention_Footer_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("Pearl_Attention_Footer_IPAD", tableName: table)
                }
            }
            
            if !UIDevice.IsSimulator && UIDevice.iPhone {
                Section {
                    Toggle("Pearl_Success_Haptic".localize(table: table), isOn: $hapticAuthentication)
                } header: {
                    Text("Pearl_Success_Haptic_Group", tableName: table)
                } footer: {
                    Text("Pearl_Success_Haptic_Footer_IPHONE", tableName: table)
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
