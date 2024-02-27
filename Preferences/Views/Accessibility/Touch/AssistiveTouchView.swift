//
//  AssistiveTouchView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch
//

import SwiftUI

struct AssistiveTouchView: View {
    // Variables
    @State private var mousePointerDwellControlEnabled = false
    @State private var duration = 2.00
    
    var body: some View {
        CustomList {
            Section(content: {
                Toggle("MOUSE_POINTER_DWELL_CONTROL", isOn: $mousePointerDwellControlEnabled)
                CustomNavigationLink(title: "MOUSE_POINTER_DWELL_AUTOREVERT", status: "Tap", destination: FallbackActionView())
                NavigationLink("MOUSE_POINTER_DWELL_TOLERANCE", destination: MovementToleranceView())
                NavigationLink("MOUSE_POINTER_DWELL_HOT_CORNERS", destination: HotCornersView())
                Stepper(
                    value: $duration,
                    in: 0.25...8.00,
                    step: 0.25
                ) {
                    HStack {
                        Text("\(duration, specifier: "%.2f")")
                            .frame(width: 50, alignment: .leading)
                        Text(duration == 1.00 ? "Second" : "Seconds")
                            .foregroundStyle(.secondary)
                    }
                }
            }, footer: {
                Text("MOUSE_POINTER_DWELL_CONTROL_FOOTER")
            })
        }
    }
}

#Preview {
    NavigationStack {
        AssistiveTouchView()
    }
}
