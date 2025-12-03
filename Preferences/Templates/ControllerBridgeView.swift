import SwiftUI

/// A view that implements a UIViewControllerRepresentable instance with common modifiers.
///
/// - Parameter bundle: The path to the bundle's binary. If given a non-path string such as "DeveloperSettings", it will use the PreferenceBundles path.
/// - Parameter controller: The string class name of the view controller.
/// - Parameter title: The navigation title for the view.
/// - Parameter path: The path to use for localization.
/// - Parameter table: The table name to use for localization.
struct ControllerBridgeView: View {
    let bundle: String
    let controller: String
    var title: String = ""
    var path: String = ""
    var table: String = ""
    
    init(
        _ bundle: String,
        controller: String,
        title: String = "",
        path: String = "",
        table: String = ""
    ) {
        self.bundle = bundle
        self.controller = controller
        self.title = title
        self.path = path
        self.table = table
    }
    
    var body: some View {
        CustomViewController(bundle.contains("/") ? bundle : "/System/Library/PreferenceBundles/\(bundle).bundle/\(bundle)", controller: controller)
            .ignoresSafeArea()
            .navigationTitle(title.isEmpty ? "" : title.localized(path: path, table: table))
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
