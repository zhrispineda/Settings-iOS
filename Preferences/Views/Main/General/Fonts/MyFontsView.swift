//
//  MyFontsView.swift
//  Preferences
//
//  Settings > General > Fonts > My Fonts
//

import SwiftUI

struct MyFontsView: View {
    // Variables
    let table = "FontSettings"
    
    var body: some View {
        ScrollView() {
            ZStack {
                Spacer().containerRelativeFrame(.vertical)
                VStack(alignment: .center) {
                    Text("NO_FONTS_INSTALLED", tableName: table)
                        .fontWeight(.bold)
                        .font(.title2)
                    Text("NO_FONTS_INSTALLED_DETAIL", tableName: table)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                    Button("NO_FONTS_INSTALLED_APP_STORE_BUTTON".localize(table: table)) {}
                        .padding(.vertical, 5)
                }
                .padding(30)
            }
        }
        .navigationTitle("MY_FONTS".localize(table: table))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        MyFontsView()
    }
}
