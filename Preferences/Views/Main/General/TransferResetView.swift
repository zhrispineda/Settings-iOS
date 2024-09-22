//
//  TransferResetView.swift
//  Preferences
//
//  Settings > General > Transfer or Reset [Device]
//

import SwiftUI

struct TransferResetView: View {
    @State private var showingResetOptions = false
    let table = "Reset"
    
    var body: some View {
        CustomList(title: "TRANSFER_OR_RESET_TITLE".localize(table: "General")) {
            VStack {
                Image(UIDevice.iPhone ? (UIDevice.HomeButtonCapability ? "ClassiciPhone" : "ModerniPhone") : "ModerniPad")
                    .foregroundStyle(.accent)
                Text("PREBUDDY_LABEL".localize(table: table))
                    .font(.headline)
                    .padding(.vertical, 5)
                Text("PREBUDDY_TEXT".localize(table: table))
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return 0
            }
            
            Button("GET_STARTED".localize(table: table)) {}
                .frame(maxWidth: .infinity, alignment: .center)
        }
        
        List {
            Button("RESET".localize(table: table)) {
                showingResetOptions.toggle()
            }
            .confirmationDialog("Select an option to reset", isPresented: $showingResetOptions,
                                titleVisibility: .hidden) {
                Button("CLEAR_LABEL".localize(table: table)) {}
                Button("RESET_NETWORK_LABEL".localize(table: table)) {}
                Button("RESET_KEYBOARD_DICTIONARY_LABEL".localize(table: table)) {}
                Button("RESET_ICONS_LABEL".localize(table: table)) {}
                Button("RESET_PERSONALIZED_HANDWRITING_STYLE_LABEL".localize(table: table)) {}
                Button("RESET_PRIVACY_LABEL".localize(table: table)) {}
            }
            Button("ERASE_LABEL".localize(table: table)) {}
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
