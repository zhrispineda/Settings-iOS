//
//  LargerTextView.swift
//  Preferences
//
//  Settings > Accessibility > Display & Text Size > Larger Text View
//

import SwiftUI

struct LargerTextView: View {
    // Variables
    @State private var largerAccessibilitySizes = false
    let table = "Accessibility"
    let fontTable = "LargeFontsSettings"
    
    var body: some View {
        ZStack {
            CustomList(title: "LARGER_TEXT".localize(table: table)) {
                Section {
                    Toggle("LARGER_DYNAMIC_TYPE".localize(table: table), isOn: $largerAccessibilitySizes)
                }
                if UIDevice.iPhone {
                    Text("DYNAMIC_TYPE_DESCRIPTION", tableName: fontTable)
                        .multilineTextAlignment(.center)
                        .offset(y: -10)
                        .listRowBackground(Color.clear)
                        .frame(maxWidth: .infinity)
                }
            }
            TextSizeView(largerAccessibilitySizes: $largerAccessibilitySizes)
        }
    }
}

struct TextSizeView: View {
    // Variables
    @State private var textSize = 3.0
    @Binding var largerAccessibilitySizes: Bool
    let table = "Accessibility"
    let fontTable = "LargeFontsSettings"
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if UIDevice.iPhone {
                    Rectangle()
                        .frame(height: 90)
                        .foregroundStyle(Color(.background))
                } else {
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(height: 90)
                        .foregroundStyle(Color(UIColor.systemFill))
                }
                Slider(value: $textSize,
                       in: 0.0...(largerAccessibilitySizes ? 11.0 : 6.0),
                       step: 1.0,
                       minimumValueLabel: Image(systemName: "textformat.size.smaller"),
                       maximumValueLabel: Image(systemName: "textformat.size.larger"),
                       label: { Text("TEXT_SIZE", tableName: table) }
                )
                .tint(.gray)
                .imageScale(.large)
                .padding()
            }
            .padding(UIDevice.iPhone ? .bottom : .all)
            if UIDevice.iPad {
                Text("DYNAMIC_TYPE_DESCRIPTION", tableName: fontTable)
                    .multilineTextAlignment(.center)
                    .offset(y: -10)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        LargerTextView()
    }
}
