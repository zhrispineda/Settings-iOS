//
//  FitnessView.swift
//  Preferences
//
//  Settings > Apps > Fitness
//

import SwiftUI

struct FitnessView: View {
    var body: some View {
        BundleControllerView(
            "FitnessSettings",
            controller: "FitnessSettingsController",
            title: "Fitness"
        )
    }
}

#Preview {
    NavigationStack {
        FitnessView()
    }
}
