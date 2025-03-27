//
//  LargerTextView.swift
//  Preferences
//
//  Settings > Display & Brightness > Text Size
//  Settings > Accessibility > Display & Text Size > Larger Text View
//

import SwiftUI

struct LargerTextView: View {
    // Variables
    @State private var largerAccessibilitySizes = false
    let table = "Accessibility"
    let fontTable = "LargeFontsSettings"
    let displayTable = "Display"
    var textOnly = false
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                CustomList(title: textOnly ? "TEXT_SIZE".localize(table: table) : "LARGER_TEXT".localize(table: table)) {
                    if !textOnly {
                        Section {
                            Toggle("LARGER_DYNAMIC_TYPE".localize(table: table), isOn: $largerAccessibilitySizes)
                        }
                    }
                    if UIDevice.iPhone {
                        Text("DYNAMIC_TYPE_DESCRIPTION", tableName: fontTable)
                            .multilineTextAlignment(.center)
                            .offset(y: -10)
                            .listRowBackground(Color.clear)
                            .frame(maxWidth: .infinity)
                    }
                }
                .overlay {
                    VStack {
                        Spacer(minLength: UIDevice.iPhone ? geometry.size.height/1.2 : geometry.size.height/2.5)
                        TextSliderViewController()
                    }
                }
                //TextSizeView(largerAccessibilitySizes: $largerAccessibilitySizes)
            }
        }
    }
}

// TextSizeView: Replaced by TextSliderViewController
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

/// ViewController responsible for adjusting text size, directly from the DisplayAndBrightnessSettings framework.
/// Missing permissions for (CFPrefsManagedSource/kCFPreferencesCurrentUser) user-preference-read/file-read-data sandbox access
struct TextSliderViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let path = "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings"
        let handle = dlopen(path, RTLD_NOW)
        defer { dlclose(handle) }
        
        let controller = NSClassFromString("DBSLargeTextSliderListController") as! UIViewControllerType.Type
        let instance = controller.init()
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    NavigationStack {
        LargerTextView()
    }
}
