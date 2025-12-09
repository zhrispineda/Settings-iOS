//
//  SettingsAppDebugMenuGestureProxyView.swift
//  Preferences
//

import SwiftUI

/// A UIViewRepresentable instance of a gesture recognizer for a single two-finger tap.
struct SettingsAppDebugMenuGestureProxyView: UIViewRepresentable {
    var onTwoFingerTap: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTwoFingerTap(_:))
        )
        gesture.numberOfTouchesRequired = 2
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onTwoFingerTap: onTwoFingerTap)
    }
    
    class Coordinator {
        let onTwoFingerTap: () -> Void
        
        init(onTwoFingerTap: @escaping () -> Void) {
            self.onTwoFingerTap = onTwoFingerTap
        }
        
        @MainActor
        @objc func handleTwoFingerTap(_ gesture: UITapGestureRecognizer) {
            guard let view = gesture.view else { return }
            let location = gesture.location(in: view)
            let statusBarHeight: CGFloat = UIDevice.iPad ? 50 : 75
            
            if location.y <= statusBarHeight && gesture.state == .recognized {
                onTwoFingerTap()
            }
        }
    }
}
