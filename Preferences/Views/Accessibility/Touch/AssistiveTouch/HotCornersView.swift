//
//  HotCornersView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Hot Corners
//

import SwiftUI

struct HotCornersView: View {
    var body: some View {
        CustomList(title: "MOUSE_POINTER_DWELL_HOT_CORNERS") {
            Section(content: {
                CustomNavigationLink(title: "DWELL_HOT_CORNER_TOP_LEFT", status: "None", destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_TOP_LEFT"))
                CustomNavigationLink(title: "DWELL_HOT_CORNER_TOP_RIGHT", status: "None", destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_TOP_RIGHT"))
                CustomNavigationLink(title: "DWELL_HOT_CORNER_BOTTOM_LEFT", status: "None", destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_BOTTOM_LEFT"))
                CustomNavigationLink(title: "DWELL_HOT_CORNER_BOTTOM_RIGHT", status: "None", destination: HotCornersDetailView(title: "DWELL_HOT_CORNER_BOTTOM_RIGHT"))
            }, footer: {
                Text("DWELL_HOT_CORNER_FOOTER")
            })
        }
    }
}

#Preview {
    NavigationStack {
        HotCornersView()
    }
}
