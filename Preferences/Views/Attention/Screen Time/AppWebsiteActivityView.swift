//
//  AppWebsiteActivityView.swift
//  Preferences
//
//  Settings > Screen Time > See All App & Website Activity
//

import SwiftUI

struct AppWebsiteActivityView: View {
    // Variables
    @State private var currentTab: Tab = .week
    let table = "ScreenTimeSettingsUI"
    
    enum Tab {
        case week
        case day
    }
    
    var body: some View {
        VStack {
            Picker("Picker", selection: $currentTab) {
                Text("WeekTitle", tableName: table).tag(Tab.week)
                Text("DayTitle", tableName: table).tag(Tab.day)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            Spacer()
            Text(UIDevice.iPhone ? "NoDataDetailTextLabel_IPHONE".localize(table: table) : "NoDataDetailTextLabel_IPAD".localize(table: table))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .navigationTitle(UIDevice.current.model)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AppWebsiteActivityView()
    }
}
