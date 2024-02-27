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
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selected = option
                }, label: {
                    HStack {
                        Text(option)
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        Image(systemName: "\(selected == option ? "checkmark" : "")")
                            .bold()
                    }
                })
            }
        }
        .toolbar {
            if DeviceInfo().isTablet {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    DeviceInfo().isPhone ? showingChangeDialog.toggle() : showingChangeAlert.toggle()
                }, label: {
                    Text("Set")
                })
                .disabled(selected == lastSelection)
            }
        }
        .alert("Use \(selected == "Larger Text" ? "Zoomed" : "More Space")", isPresented: $showingChangeAlert,
               actions: {
            Button("Use \(selected == "Larger Text" ? "Zoomed" : "More Space")", role: .none) {
                lastSelection = selected
            }
            Button("Cancel", role: .cancel) {}
        }, message: {
            Text("Changing Display Zoom will restart iPad.")
        })
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
