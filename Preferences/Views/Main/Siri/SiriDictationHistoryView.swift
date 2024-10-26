//
//  SiriDictationHistoryView.swift
//  Preferences
//
//  Settings > Siri > Siri & Dictation History
//

import SwiftUI

struct SiriDictationHistoryView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteHistoryAlert = false
    @State private var showingDeleteHistoryDialog = false
    @State private var showingProcessRequestAlert = false
    let table = "AssistantSettings"
    
    var body: some View {
        CustomList(title: "ASSISTANT_HISTORY_LABEL".localize(table: table)) {
            Section {
                Button("DELETE_SIRI_HISTORY_ACTION".localize(table: table)) {
                    UIDevice.iPhone ? showingDeleteHistoryDialog.toggle() : showingDeleteHistoryAlert.toggle()
                }
                .foregroundStyle(.red)
                .alert("DELETE_SIRI_HISTORY".localize(table: table), isPresented: $showingDeleteHistoryAlert) {
                    Button("DELETE_SIRI_HISTORY_ACTION".localize(table: table), role: .destructive) { showingProcessRequestAlert.toggle()
                        dismiss()
                    }
                    Button("DELETE_SIRI_HISTORY_ALERT_SHEET_CANCEL".localize(table: table), role: .cancel) {}
                } message: {
                    Text("DELETE_SIRI_HISTORY_ALERT_SHEET_MESSAGE_IPAD", tableName: table)
                }
                .confirmationDialog("DELETE_SIRI_HISTORY".localize(table: table), isPresented: $showingDeleteHistoryDialog, titleVisibility: .visible) {
                    Button("DELETE_SIRI_HISTORY_ACTION".localize(table: table), role: .destructive) { showingProcessRequestAlert.toggle()
                        dismiss()
                    }
                    Button("DELETE_SIRI_HISTORY_ALERT_SHEET_CANCEL".localize(table: table), role: .cancel) {}
                } message: {
                    Text("DELETE_SIRI_HISTORY_ALERT_SHEET_MESSAGE_IPHONE", tableName: table)
                }
                .alert("DELETE_SIRI_HISTORY_ALERT_SUCCESS_TITLE".localize(table: table), isPresented: $showingProcessRequestAlert) {
                    Button("DELETE_SIRI_HISTORY_ALERT_DISMISS".localize(table: table)) {}
                } message: {
                    Text("DELETE_SIRI_HISTORY_ALERT_SUCCESS_MESSAGE", tableName: table)
                }
            } footer: {
                if UIDevice.iPhone {
                    Text("DELETE_SIRI_HISTORY_FOOTER_EXPLANATION_IPHONE_OPTEDOUT", tableName: table) + Text("[\("DELETE_SIRI_HISTORY_FOOTER_LINK".localize(table: table))](#)")
                } else if UIDevice.iPad {
                    Text("DELETE_SIRI_HISTORY_FOOTER_EXPLANATION_IPAD_OPTEDOUT", tableName: table) + Text("[\("DELETE_SIRI_HISTORY_FOOTER_LINK".localize(table: table))](#)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriDictationHistoryView()
    }
}
