//
//  SystemFontsDetailView.swift
//  Preferences
//
//  Settings > General > Fonts > System Fonts > [Font]
//

import SwiftUI

struct SystemFontsDetailView: View {
    var fontName = "Font"
    let table = "FontSettings"
    
    var body: some View {
        CustomList(title: fontName) {
            Section {
                VStack(alignment: .leading, spacing: 30) {
                    Text(fontName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("COPYRIGHT_TITLE", tableName: table)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("VERSION_TITLE", tableName: table)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            
            Section("FACES_PLURAL".localize(table: table)) {
                NavigationLink("Plain") {
                    TabView {
                        Text("ALPHABET", tableName: table)
                            .padding()
                        Text("LOREM_IPSUM", tableName: table)
                            .padding()
                        Text(String())
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
