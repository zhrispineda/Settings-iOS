//
//  ActionButtonView.swift
//  Preferences
//
//  Settings > Action Button
//

import SwiftUI
import SceneKit

struct ActionButtonView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //ActionButtonRender()
                Image("actionButton") // Background image
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                RoundedRectangle(cornerRadius: 50.0) // Button highlight
                    .blendMode(.multiply)
                    .foregroundStyle(Color.orange.opacity(1.0))
                    .shadow(color: .orange, radius: 8)
                    .shadow(color: .red, radius: 15)
                    .blur(radius: 5)
                    .frame(width: 95, height: 210)
                    .offset(y: -75)
                ScrollView(.horizontal) { // Icons
                    LazyHStack {
                        Image(systemName: "bell.slash.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 64))
                            .opacity(0.8)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetBehavior(.paging)
                .offset(y: -75)
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 20.0)
                
                // Action title and description
                VStack(alignment: .center) {
                    Text("Silent Mode")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .font(.title)
                    Text("Switch between Silent and Ring for calls and alerts.")
                        .foregroundStyle(.white.secondary)
                        .font(.subheadline)
                        .padding(.horizontal, 30)
                }
                .multilineTextAlignment(.center)
                .offset(y: 125)
                
                VStack { // Top and bottom shadows
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomButton()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct CustomButton: View { // Replace back button with white foreground style
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
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
