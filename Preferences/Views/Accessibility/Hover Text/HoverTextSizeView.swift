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
    
    var body: some View {
        ZStack {
            CustomList(title: "Size") {
                Text("Hover Text will adjust to your preferred reading size below.")
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
                       label: { Text("Text Size") }
                )
                .tint(.gray)
                .imageScale(.large)
                .padding()
            }
            .padding()
            Button(action: {
                textSize = 3.0
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(height: 50)
                        .foregroundStyle(Color(UIColor.secondarySystemFill))
                    Text("Reset Font Size to Default")
                }
                .padding()
            })
            Spacer()
        }
    }
}

#Preview {
    HoverTextSizeView()
}
