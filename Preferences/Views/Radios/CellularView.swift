//
//  CellularView.swift
//  Preferences
//
//  Settings > Cellular
//

import SwiftUI

struct CellularView: View {
    @State private var titleVisible = false
    @State private var showingHelpSheet = false
    let path = "/System/Library/PrivateFrameworks/SettingsCellularUI.framework"
    let table = "Cellular"
    
    var body: some View {
        CustomList(title: titleVisible ? "CELLULAR_TITLE".localized(path: path, table: table) : "") {
            Placard(
                title: "CELLULAR_TITLE".localized(path: path, table: table),
                icon: "com.apple.graphic-icon.cellular-settings",
                description: "CELLULAR_SETTINGS_SUBTITLE".localized(path: path, table: table).replacing("helpkit", with: "pref"),
                isVisible: $titleVisible
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
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
