//
//  HoverTextSizeView.swift
//  Preferences
//
//  Settings > Accessibility > Hover Text > Size
//

import SwiftUI

struct HoverTextSizeView: View {
    // Variables
    @State private var largerAccessibilitySizes = true
    let table = "Accessibility"
    
    var body: some View {
        ZStack {
            CustomList(title: "Size") {
                Text("HOVER_TEXT_TEXT_SIZE_DESCRIPTION", tableName: table)
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
            }
            HoverTextSizeSlider()
        }
    }
}

struct HoverTextSizeSlider: View {
    // Variables
    @State private var textSize = 3.0
    let table = "Accessibility"
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(height: 90)
                    .foregroundStyle(Color(UIColor.secondarySystemFill))
                Slider(value: $textSize,
                       in: 0.0...11.0,
                       step: 1.0,
                       minimumValueLabel: Image(systemName: "textformat.size.smaller"),
                       maximumValueLabel: Image(systemName: "textformat.size.larger"),
                       label: { Text("TEXT_SIZE", tableName: table) }
                )
                .tint(.gray)
                .imageScale(.large)
                .padding()
            }
            .padding()
            Button {
                textSize = 3.0
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(height: 50)
                        .foregroundStyle(Color(UIColor.secondarySystemFill))
                    Text("RESET_BUTTON_TEXT", tableName: "LargeFontsSettings")
                }
                .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    HoverTextSizeView()
}
