//
//  TextSizeView.swift
//  Preferences
//
//  Settings > Display & Brightness > Text Size
//

import SwiftUI

struct TextSizeView: View {
    @State private var largerAccessibilitySizes = false
    let table = "Accessibility"
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                CustomList(title: "TEXT_SIZE".localize(table: table)) {
                    if UIDevice.iPhone {
                        Text("DYNAMIC_TYPE_DESCRIPTION", tableName: "LargeFontsSettings")
                            .multilineTextAlignment(.center)
                            .offset(y: -5)
                            .listRowBackground(Color.clear)
                            .frame(maxWidth: .infinity)
                    }
                }
                .overlay {
                    VStack {
                        Spacer(minLength: UIDevice.iPhone ? geometry.size.height/1.2 : geometry.size.height/2.5)
                        CustomViewController(path: "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings", controller: "DBSLargeTextSliderListController")
                    }
                }
            }
        }
    }
}

#Preview {
    TextSizeView()
}
