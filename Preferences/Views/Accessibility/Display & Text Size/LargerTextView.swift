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
    
    var body: some View {
        ZStack {
            CustomList(title: "Larger Text") {
                Section {
                    Toggle("Larger Accessibility Sizes", isOn: $largerAccessibilitySizes)
                }
                Text("Apps that support Dynamic Type will adjust to your preferred reading size above.")
                    .multilineTextAlignment(.center)
                    .offset(y: -10)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
            }
            TextSizeView(largerAccessibilitySizes: $largerAccessibilitySizes)
        }
    }
}

struct TextSizeView: View {
    // Variables
    @State private var textSize = 3.0
    @Binding var largerAccessibilitySizes: Bool
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .frame(height: 90)
                    .foregroundStyle(Color(UIColor.tertiarySystemBackground))
                Slider(value: $textSize,
                       in: 0.0...(largerAccessibilitySizes ? 11.0 : 6.0),
                       step: 1.0,
                       minimumValueLabel: Image(systemName: "textformat.size.smaller"),
                       maximumValueLabel: Image(systemName: "textformat.size.larger"),
                       label: { Text("Text Size") }
                )
                .tint(.gray)
                .imageScale(.large)
                .padding()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    NavigationStack {
        LargerTextView()
    }
}
