//
//  SystemFontsDetailView.swift
//  Preferences
//
//  Settings > General > Fonts > System Fonts > [Font]
//

import SwiftUI

struct SystemFontsDetailView: View {
    var fontName = "Font"
    let path = "/System/Library/PreferenceBundles/FontSettings.bundle"
    
    var body: some View {
        CustomList(title: fontName) {
            Section {
                VStack(alignment: .leading, spacing: 30) {
                    Text(fontName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Copyright".localized(path: path))
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("Version".localized(path: path))
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            
            Section("%lld typefaces".localized(path: path, 1)) {
                NavigationLink("Plain") {
                    TabView {
                        Text("ALPHABET".localized(path: path))
                            .padding()
                        Text("LOREM_IPSUM".localized(path: path))
                            .padding()
                        Text("")
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .navigationTitle("Plain")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SystemFontsDetailView()
    }
}
