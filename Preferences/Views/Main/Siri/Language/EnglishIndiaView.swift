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
    let table = "AssistantMultilingualDetail"
    
    var body: some View {
        CustomList(title: "English (India)") {
            Section {} footer: {
                Text("MULTILINGUAL_DETAIL_HEADER_en-IN", tableName: table)
            }
            
            Section {
                Picker("MULTILINGUAL_DETAIL_GROUP_TITLE".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("MULTILINGUAL_DETAIL_GROUP_TITLE", tableName: table)
            } footer: {
                if selected == "MULTILINGUAL_DETAIL_OPTION_ENGLISH_ONLY" {
                    Text("MULTILINGUAL_DETAIL_FOOTER_ENGLISH_ONLY", tableName: table)
                } else {
                    Text("MULTILINGUAL_DETAIL_FOOTER_MIXED_en-IN", tableName: table)
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
