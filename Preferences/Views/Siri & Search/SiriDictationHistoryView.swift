//
//  SiriDictationHistoryView.swift
//  Preferences
//
//  Settings > Siri & Search > Siri & Dictation History
//

import SwiftUI

struct SiriDictationHistoryView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteHistoryAlert = false
    @State private var showingDeleteHistoryDialog = false
    @State private var showingProcessRequestAlert = false
    
    var body: some View {
        CustomList(title: "Siri & Dictation History") {
            Section(content: {
                Button("Delete Siri & Dictation History", action: {
                    DeviceInfo().isPhone ? showingDeleteHistoryDialog.toggle() : showingDeleteHistoryAlert.toggle()
                })
                .foregroundStyle(.red)
                .alert("Delete Siri & Dictation History", isPresented: $showingDeleteHistoryAlert) {
                    Button("Delete Siri & Dictation History", role: .destructive) { showingProcessRequestAlert.toggle()
                        dismiss()
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Siri & Dictation interactions currently associated with this \(DeviceInfo().model) will be deleted from Apple servers.")
                }
                .confirmationDialog("Delete Siri & Dictation History", isPresented: $showingDeleteHistoryDialog, titleVisibility: .visible) {
                    Button("Delete Siri & Dictation History", role: .destructive) { showingProcessRequestAlert.toggle()
                        dismiss()
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Siri & Dictation interactions currently associated with this \(DeviceInfo().model) will be deleted from Apple servers.")
                }
                .alert("Your Process Is Being Requested", isPresented: $showingProcessRequestAlert) {
                    Button("OK") {}
                } message: {
                    Text("Your Siri and Dictation history will be deleted.")
                }
            }, footer: {
                Text("Delete Siri & Dictation interactions currently associated with this \(DeviceInfo().model) from Apple servers. [About Improve Siri & Dictation...](#)")
            })
        }
    }
}

#Preview {
    NavigationStack {
        SiriDictationHistoryView()
    }
}
