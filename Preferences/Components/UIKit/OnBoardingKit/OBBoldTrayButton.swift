//
//  OBBoldTrayButton.swift
//  Preferences
//

import SwiftUI

/// A UIViewRepresentable instance for `OBBoldTrayButton` from the OnBoardingKit framework.
///
/// - Parameter titleKey: The label to display on the button.
/// - Parameter action: The code to run on a touch-up event.
///
/// - Warning: Do not use this method for public applications. It is not publicly supported.
struct OBBoldTrayButton: UIViewRepresentable {
    var titleKey: String
    let action: () -> Void
    @Binding var isLoading: Bool
    
    init(
        _ titleKey: String,
        isLoading: Binding<Bool> = .constant(false),
        action: @escaping () -> Void = {}
    ) {
        self.titleKey = titleKey
        self._isLoading = isLoading
        self.action = action
    }
    
    func makeUIView(context: Context) -> UIButton {
        guard let buttonClass = NSClassFromString("OBBoldTrayButton") as? NSObject.Type,
              let button = buttonClass.perform(NSSelectorFromString("boldButton"))?.takeUnretainedValue() as? UIButton else {
            return UIButton()
        }
        
        button.setTitle(titleKey, for: .normal)
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTap), for: .touchUpInside)
        
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        if isLoading {
            uiView.perform(NSSelectorFromString("showsBusyIndicator"))
        } else {
            uiView.perform(NSSelectorFromString("hidesBusyIndicator"))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator {
        let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func didTap() {
            action()
        }
    }
}
