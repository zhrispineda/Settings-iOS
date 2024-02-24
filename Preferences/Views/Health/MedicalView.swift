//
//  MedicalView.swift
//  Preferences
//
//  Settings > Health > Medical ID
//

import SwiftUI

struct MedicalView: View {
    var body: some View {
        CustomList(title: "Medical ID") {
            VStack {
                Text("A Medical ID provides medical information about you that may be important in an emergency, like allergies and medical conditions.")
                Text("The Medical ID can be accessed from the emergency dialer without unlocking your phone.")
                Button(action: {}, label: {
                    Text("Create Medical ID")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MedicalView()
    }
}
