//
//  HotCornersView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Hot Corners
//

import SwiftUI

struct HotCornersView: View {
    // Variables
    let table = "HandSettings"
    
    var body: some View {
        CustomList(title: "MOUSE_POINTER_DWELL_HOT_CORNERS".localize(table: table)) {
            Section {
                CustomNavigationLink(title: "DWELL_HOT_CORNER_TOP_LEFT".localize(table: table), status: "NONE".localize(table: table), destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_TOP_LEFT".localize(table: table)))
                CustomNavigationLink(title: "DWELL_HOT_CORNER_TOP_RIGHT".localize(table: table), status: "NONE".localize(table: table), destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_TOP_RIGHT".localize(table: table)))
                CustomNavigationLink(title: "DWELL_HOT_CORNER_BOTTOM_LEFT".localize(table: table), status: "NONE".localize(table: table), destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_BOTTOM_LEFT".localize(table: table)))
                CustomNavigationLink(title: "DWELL_HOT_CORNER_BOTTOM_RIGHT".localize(table: table), status: "NONE".localize(table: table), destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_BOTTOM_RIGHT".localize(table: table)))
            } footer: {
                Text("DWELL_HOT_CORNER_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HotCornersView()
    }
}
