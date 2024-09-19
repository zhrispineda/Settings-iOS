//
//  SystemFontsDetailView.swift
//  Preferences
//
//  Settings > General > Fonts > System Fonts > [Font]
//

import SwiftUI

struct SystemFontsDetailView: View {
    var fontName = "Font"
    
    var body: some View {
        CustomList(title: fontName) {
            Section {
                VStack(alignment: .leading, spacing: 30) {
                    Text(fontName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Copyright")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("Version")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            
            Section("One Typeface") {
                NavigationLink("Plain") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        SystemFontsDetailView()
    }
}
