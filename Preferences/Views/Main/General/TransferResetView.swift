//
//  TransferResetView.swift
//  Preferences
//
//  Settings > General > Transfer or Reset [Device]
//

import SwiftUI

struct TransferResetView: View {
    @State private var showingResetOptions = false
    
    var body: some View {
        CustomList(title: "Transfer or Reset \(Device().model)") {
            VStack(alignment: .center) {
                Image(Device().isPhone ? (UIDevice.HomeButtonCapability ? "ClassiciPhone" : "ModerniPhone") : "ModerniPad")
                    .foregroundStyle(.accent)
                Text("**Prepare for New \(Device().model)**")
                Text("Make sure everything's ready to transfer to a new \(Device().model), even if you don't currently have enough iCloud storage to back up.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            HStack {
                Spacer()
                Button("Get Started") {}
                Spacer()
            }
        }
        .confirmationDialog("Select an option to reset", isPresented: $showingResetOptions,
                            titleVisibility: .hidden,
            actions: {
                Button("Reset All Settings") {}
                Button("Reset Network Settings") {}
                Button(Device().isPhone ? "Delete All eSIMs" : "Subscriber Services") {}
                Button("Reset Keyboard Dictionary") {}
                Button("Reset Keyboard Dictionary") {}
                Button("Reset Location & Privacy") {}
        })
        List {
            Button("Reset") { showingResetOptions.toggle() }
            Button("Erase All Content and Settings") {}
        }
        .padding(.top, -25)
        .frame(maxHeight: 100)
    }
}

#Preview {
    NavigationStack {
        TransferResetView()
    }
}
