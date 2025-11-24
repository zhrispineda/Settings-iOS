//
//  CellularView.swift
//  Preferences
//
//  Settings > Cellular
//

import SwiftUI

struct CellularView: View {
    @State private var frameY = 0.0
    @State private var opacity = 0.0
    @State private var showingHelpSheet = false
    let path = "/System/Library/PrivateFrameworks/SettingsCellularUI.framework"
    let table = "Cellular"
    
    var body: some View {
        CustomList {
            Placard(
                title: "CELLULAR_TITLE".localized(path: path, table: table),
                icon: "com.apple.graphic-icon.cellular-settings",
                description: "CELLULAR_SETTINGS_SUBTITLE".localized(path: path, table: table).replacing("helpkit", with: "pref"),
                frameY: $frameY,
                opacity: $opacity
            )
            
            Section {
                Button("SETUP_CELLULAR".localized(path: path, table: table)) {}
            }
        }
        .onOpenURL {_ in
            showingHelpSheet.toggle()
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph3dd5f213" : "ipadbfe780eb")
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CELLULAR_TITLE".localized(path: path, table: table))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
