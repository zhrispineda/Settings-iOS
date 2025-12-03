import SwiftUI

/// A view that implements a UIViewControllerRepresentable instance with common modifiers.
///
/// - Parameter bundle: The path to the bundle's binary. If given a non-path string such as "DeveloperSettings", it will use the PreferenceBundles path.
/// - Parameter controller: The string class name of the view controller.
/// - Parameter title: The navigation title for the view.
struct ControllerBridgeView: View {
    let bundle: String
    let controller: String
    var title: String = ""
    
    init(
        _ bundle: String,
        controller: String,
        title: String = "",
    ) {
        self.bundle = bundle
        self.controller = controller
        self.title = title
    }
    
    var body: some View {
        CustomViewController(bundle.contains("/") ? bundle : "/System/Library/PreferenceBundles/\(bundle).bundle/\(bundle)", controller: controller)
            .ignoresSafeArea()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .border(PrimarySettingsListModel.shared.showingDebugOverlays ? Color.green.opacity(0.5) : .clear)
            .overlay(alignment: .topLeading) {
                if PrimarySettingsListModel.shared.showingDebugOverlays {
                    Text(controller)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color.green.colorMultiply(.gray))
                        .cornerRadius(0)
                        .offset(x: 1, y: 1)
                }
            }
    }
}
