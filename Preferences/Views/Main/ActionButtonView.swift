//
//  ActionButtonView.swift
//  Preferences
//
//  Settings > Action Button
//

import SwiftUI

struct ActionButtonView: View {
    var body: some View {
        ActionButtonViewController()
            .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        ActionButtonView()
    }
}
