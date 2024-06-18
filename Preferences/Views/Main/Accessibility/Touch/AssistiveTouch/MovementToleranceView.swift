//
//  MovementToleranceView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Movement Tolerance
//

import SwiftUI

struct MovementToleranceView: View {
    // Variables
    @State private var tolerance = 3.0
    
    var body: some View {
        CustomList(title: "MOUSE_POINTER_DWELL_TOLERANCE") {
            Section {
                Slider(value: $tolerance, in: 0.0...200.0, step: 1.0)
            } footer: {
                Text("DWELL_MOVEMENT_TOLERACE_FOOTER")
            }
            
            Section {
                Circle()
                    .fill(.tertiary)
                    .stroke(Color["Label"], lineWidth: 1)
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: tolerance)
            }
            .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    NavigationStack {
        MovementToleranceView()
    }
}
