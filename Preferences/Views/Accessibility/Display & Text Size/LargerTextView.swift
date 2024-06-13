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
                if Device().isPhone {
                    Text("Apps that support Dynamic Type will adjust to your preferred reading size below.")
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
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if Device().isPhone {
                    Rectangle()
                        .frame(height: 90)
                        .foregroundStyle(Color(UIColor.systemFill))
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
                       label: { Text("Text Size") }
                )
                .tint(.gray)
                .imageScale(.large)
                .padding()
            }
            .padding(Device().isPhone ? .bottom : .all)
            if Device().isTablet {
                Text("Apps that support Dynamic Type will adjust to your preferred reading size above.")
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
