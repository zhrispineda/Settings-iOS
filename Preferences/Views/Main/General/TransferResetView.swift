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
                Image(systemName: "\(Device().model.lowercased()).gen\(Device().hasHomeButton ? "1" : "2")")
                    .font(.system(size: 50))
                    .foregroundStyle(.blue)
                    .symbolRenderingMode(.monochrome)
                ZStack {
                    Color("Background")
                        .frame(width: Device().isPhone ? 35 : 45, height: Device().isPhone ? 55 : 59)
                    Image(systemName: "apps.\(Device().model.lowercased())")
                        .font(.system(size: 50))
                        .foregroundStyle(.blue)
                        .symbolRenderingMode(.monochrome)
                }
                .padding([.top, .trailing], -40)
                Text("**Prepare for New \(Device().model)**")
                Text("Make sure everything's ready to transfer to a new \(Device().model), even if you don't currently have enough iCloud storage to back up.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            HStack {
                Spacer()
                Button("Get Started", action: {})
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
            Button("Reset", action: { showingResetOptions.toggle() })
            Button("Erase All Content and Settings", action: {})
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
