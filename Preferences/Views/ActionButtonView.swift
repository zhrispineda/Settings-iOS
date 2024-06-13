//
//  ActionButtonView.swift
//  Preferences
//
//  Settings > Action Button
//

import SwiftUI
import SceneKit

struct ActionButtonView: View {
    // Variables
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ActionButtonRender()
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.01)]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxHeight: 10)
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.01)]), startPoint: .bottom, endPoint: .top))
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxHeight: 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomButon {
            dismiss()
        })
    }
}

struct CustomButon: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Settings")
            }
            .foregroundStyle(.white)
        }
    }
}

struct ActionButtonRender: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        sceneView.antialiasingMode = .multisampling4X
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .black
        let scene = SCNScene(named: "iPhone15_Pro_NaturalTitanium.usdz")
        sceneView.scene = scene
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Empty
    }
}

#Preview {
    NavigationStack {
        ActionButtonView()
    }
}
