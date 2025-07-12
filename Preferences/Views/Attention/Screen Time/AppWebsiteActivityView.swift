//
//  AppWebsiteActivityView.swift
//  Preferences
//
//  Settings > Screen Time > See All App & Website Activity
//

import SwiftUI

struct AppWebsiteActivityView: View {
    @State private var currentTab: Tab = .week
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    enum Tab {
        case week
        case day
    }
    
    var body: some View {
        VStack {
            Picker("Picker", selection: $currentTab) {
                Text("WeekTitle".localized(path: path)).tag(Tab.week)
                Text("DayTitle".localized(path: path)).tag(Tab.day)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            Spacer()
            Text(UIDevice.iPhone ? "NoDataDetailTextLabel_IPHONE".localized(path: path) : "NoDataDetailTextLabel_IPAD".localized(path: path))
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
