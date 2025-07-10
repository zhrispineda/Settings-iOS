//
//  EnglishIndiaView.swift
//  Preferences
//
//  Settings > Siri > Language > English (India)
//

import SwiftUI

struct EnglishIndiaView: View {
    @State private var selected = "MULTILINGUAL_DETAIL_OPTION_ENGLISH_ONLY"
    let options = ["MULTILINGUAL_DETAIL_OPTION_MIXED_en-IN", "MULTILINGUAL_DETAIL_OPTION_ENGLISH_ONLY"]
    let path = "/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework"
    let table = "AssistantMultilingualDetail"
    
    var body: some View {
        CustomList(title: "English (India)") {
            Section {} footer: {
                Text(.init("MULTILINGUAL_DETAIL_HEADER_en-IN".localized(path: path, table: table).replacing("Learn more…", with: "[Learn more…](https://support.apple.com/105012)")))
            }
            
            Section {
                Picker("MULTILINGUAL_DETAIL_GROUP_TITLE".localized(path: path, table: table), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("MULTILINGUAL_DETAIL_GROUP_TITLE".localized(path: path, table: table))
            } footer: {
                if selected == "MULTILINGUAL_DETAIL_OPTION_ENGLISH_ONLY" {
                    Text("MULTILINGUAL_DETAIL_FOOTER_ENGLISH_ONLY".localized(path: path, table: table))
                } else {
                    Text("MULTILINGUAL_DETAIL_FOOTER_MIXED_en-IN".localized(path: path, table: table))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EnglishIndiaView()
    }
}
