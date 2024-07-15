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
    
    var body: some View {
        CustomList(title: "Display Zoom") {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
        }
        .toolbar {
            if UIDevice.iPad {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    UIDevice.iPhone ? showingChangeDialog.toggle() : showingChangeAlert.toggle()
                } label: {
                    Text("Set")
                }
                .disabled(selected == lastSelection)
            }
        }
        .alert("Use \(selected == "Larger Text" ? "Zoomed" : "More Space")", isPresented: $showingChangeAlert) {
            Button("Use \(selected == "Larger Text" ? "Zoomed" : "More Space")", role: .none) {
                lastSelection = selected
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Changing Display Zoom will restart iPad.")
        }
        .confirmationDialog("Changing Display Zoom will restart iPhone.", isPresented: $showingChangeDialog,
                            titleVisibility: .visible,
                            actions: {
            Button("Use \(selected == "Default" ? "Standard" : "Zoomed")", role: .none) {
                lastSelection = selected
            }
            Button("Cancel", role: .cancel) {}
        })
    }
}

#Preview {
    NavigationStack {
        DisplayZoomView()
    }
}
