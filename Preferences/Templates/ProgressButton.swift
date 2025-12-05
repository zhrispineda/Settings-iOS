//
//  ContinueButton.swift
//  Preferences
//

import SwiftUI

/// Progress view placeholder for buttons under a conditional.
struct ProgressButton: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .glassEffect()
    }
}

#Preview {
    List {
        ProgressButton()
    }
}
