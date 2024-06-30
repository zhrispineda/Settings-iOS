//
//  BetaUpdatesView.swift
//  Preferences
//
//  Settings > General > Software Update > Beta Updates
//

import SwiftUI

struct BetaUpdatesView: View {
    // Variables
    @State private var selected = "\(UIDevice().systemName) 18 Developer Beta"
    @State private var showingAlert = false
    let options = ["Off", "\(UIDevice().systemName) 18 Developer Beta"]
    
    var body: some View {
        CustomList(title: "Beta Updates") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("Receive beta updates on this \(Device().model) to test-drive pre-release versions of \(UIDevice().systemName) and provide feedback to help make Apple software even better. [Learn more...](https://beta.apple.com)")
            }
            
            Section {
                Button("Apple ID:") {
                    showingAlert.toggle()
                }
                .alert("Apple ID for Beta Updates", isPresented: $showingAlert) {
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("Use a different Apple ID...")
                    }
                    Button("Cancel", role: .cancel) {
                        showingAlert.toggle()
                    }
                } message: {
                    Text("Signed in as .\n\nYou can sign in with a different Apple ID that is enrolled in the Apple Beta Software Program or Apple Developer Program.")
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        BetaUpdatesView()
    }
}
