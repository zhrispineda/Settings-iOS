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
    
    enum Tab {
        case week
        case day
    }
    
    var body: some View {
        VStack {
            Picker("Picker", selection: $currentTab) {
                Text("Week").tag(Tab.week)
                Text("Day").tag(Tab.day)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(20)
            Spacer()
            Text("As you use your \(UIDevice.current.model), screen time will be reported here.")
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
