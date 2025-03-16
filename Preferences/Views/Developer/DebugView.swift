//
//  DebugView.swift
//  Preferences
//

import SwiftUI

struct DebugView: View {
    var body: some View {
        List {
            Section {
                Button("") {}
            }
            
            Section {
                NavigationLink("") {}
                NavigationLink("") {}
            }
            
            Section("") {
                LabeledContent("", value: "")
                LabeledContent("", value: "")
            }
            
            Section("") {
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
                LabeledContent("", value: "")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugView()
    }
}
