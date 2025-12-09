//
//  SUSSoftwareUpdateReleaseNotesDetail.swift
//  Preferences
//

import SwiftUI

/// A UIViewRepresentable instance for `SUSSoftwareUpdateReleaseNotesDetail` from the SoftwareUpdateSettings framework.
///
/// - Parameter readMeName: The name of the ReadMe file.
///
/// - Warning: Do not use this method for public applications. It is not publicly supported.
struct SUSSoftwareUpdateReleaseNotesDetail: UIViewControllerRepresentable {
    let readMeName: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        dlopen("/System/Library/PrivateFrameworks/SoftwareUpdateSettings.framework/SoftwareUpdateSettings", RTLD_NOW)
        
        guard let controllerClass = NSClassFromString("SUSSoftwareUpdateReleaseNotesDetail") as? UIViewController.Type else {
            SettingsLogger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail")
            return UIViewController()
        }
        
        let instance = controllerClass.init()
        
        if let readMe = loadReadMe(named: readMeName) {
            instance.setValue(readMe, forKey: "releaseNotes")
        }
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    private func loadReadMe(named fileName: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "html") else {
            SettingsLogger.error("Could not find ReadMe: \(fileName)")
            return nil
        }
        
        do {
            return try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            SettingsLogger.error("Could not load ReadMe: \(error)")
            return nil
        }
    }
}

#Preview {
    NavigationStack {
        SUSSoftwareUpdateReleaseNotesDetail(readMeName: "iOSReadMeSummary")
            .navigationTitle("Release Notes")
    }
}
