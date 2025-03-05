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
    let table = "HandSettings"
    let strTable = "LocalizedStrings"
    
    var body: some View {
        CustomList {
            Section {
                Toggle("MOUSE_POINTER_DWELL_CONTROL".localize(table: table), isOn: $mousePointerDwellControlEnabled)
                CustomNavigationLink("MOUSE_POINTER_DWELL_AUTOREVERT".localize(table: table), status: "TAP".localize(table: strTable), destination: FallbackActionView())
                NavigationLink("MOUSE_POINTER_DWELL_TOLERANCE".localize(table: table), destination: MovementToleranceView())
                NavigationLink("MOUSE_POINTER_DWELL_HOT_CORNERS".localize(table: table), destination: HotCornersView())
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
            } footer: {
                Text("MOUSE_POINTER_DWELL_CONTROL_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AssistiveTouchView()
    }
}
