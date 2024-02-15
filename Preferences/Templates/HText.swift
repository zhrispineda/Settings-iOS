//
//  HText.swift
//  Preferences
//
/// Template for an HStack with title and status text.
/// - Parameters:
///   - title: The main text describing the label.
///   - status: Description of a state of a destination's controls.

import SwiftUI

struct HText: View {
    var title = String()
    var status = String()
    
    init(_ title: String = String(), status: String = String()) {
        self.title = title
        self.status = status
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(status)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HText()
}
