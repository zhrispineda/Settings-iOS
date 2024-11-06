//
//  DisplayZoomView.swift
//  Preferences
//
//  Settings > Developer > Display Zoom
//

import SwiftUI

struct DisplayZoomView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var showingChangeDialog = false
    @State private var showingChangeAlert = false
    @State private var selected = "Default"
    @State private var lastSelection = "Default"
    var options = ["Larger Text", "Default"]
    let table = "DTDisplayZoom"
    
    var body: some View {
        CustomList(title: "DISPLAY_ZOOM".localize(table: table)) {
            Picker("DISPLAY_ZOOM".localize(table: table), selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
        .toolbar {
            if UIDevice.iPad {
                ToolbarItem(placement: .topBarLeading) {
                    Button("CONFIRMATION_CANCEL".localize(table: table)) {
                        dismiss()
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    UIDevice.iPhone ? showingChangeDialog.toggle() : showingChangeAlert.toggle()
                } label: {
                    Text("SET", tableName: table)
                }
                .disabled(selected == lastSelection)
            }
        }
        .alert(selected == "Larger Text" ? "CONFIRMATION_USE_ZOOMED".localize(table: table) : "CONFIRMATION_USE_DENSE".localize(table: table), isPresented: $showingChangeAlert) {
            Button(selected == "Larger Text" ? "ZOOMED".localize(table: table) : "CONFIRMATION_USE_DENSE".localize(table: table), role: .none) {
                lastSelection = selected
            }
            Button("CONFIRMATION_CANCEL".localize(table: table), role: .cancel) {}
        } message: {
            Text("CONFIRMATION_PROMPT", tableName: table)
        }
        .confirmationDialog("CONFIRMATION_PROMPT", isPresented: $showingChangeDialog,
                            titleVisibility: .visible,
                            actions: {
            Button(selected == "Default" ? "CONFIRMATION_USE_STANDARD".localize(table: table) : "CONFIRMATION_USE_ZOOMED".localize(table: table), role: .none) {
                lastSelection = selected
            }
            Button("CONFIRMATION_CANCEL".localize(table: table), role: .cancel) {}
        })
    }
}

#Preview {
    NavigationStack {
        DisplayZoomView()
    }
}
