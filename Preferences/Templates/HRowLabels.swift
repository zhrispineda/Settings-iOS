//
//  HRowLabels.swift
//  Preferences
//
//  Horizontal Row Labels
//

import SwiftUI

struct HRowLabels: View {
    var title = String()
    var subtitle = String()
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(subtitle)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    HRowLabels()
}
