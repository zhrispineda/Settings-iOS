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
            //ActionButtonRender()
            Image("actionButton")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack {
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(height: 200)
                    .mask(
                        LinearGradient(
                            gradient: .init(colors: [.black.opacity(0.95)]), startPoint: .bottom, endPoint: .top)
                    )
                    .blur(radius: 25, opaque: false)
                    .offset(y: -80)
                Spacer()
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(height: 300)
                    .mask(
                        LinearGradient(
                            gradient: .init(colors: [.black.opacity(0.95)]), startPoint: .bottom, endPoint: .top)
                    )
                    .blur(radius: 40, opaque: false)
                    .offset(y: 70)
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
        Button {
            self.action()
        } label: {
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
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
}

#Preview {
    NavigationStack {
        ActionButtonView()
    }
}
