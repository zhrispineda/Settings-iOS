//
//  PhotographicStylesView.swift
//  Preferences
//
//  Settings > Camera > Photographic Styles
//

import SwiftUI

struct PhotographicStylesView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    let table = "CameraUI-SmartStyles"
    
    var body: some View {
        VStack(spacing: 10) {
            Image("onboarding_asset")
                .resizable()
                .scaledToFit()
            Text("SMART_STYLES_SETTINGS_TITLE_INTRO".localize(table: table))
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("SMART_STYLES_SETTINGS_INTRO_INSTRUCTION_NOT_ENOUGH_PHOTOS".localize(table: table))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .frame(height: 150)
            Text("SMART_STYLES_SETTINGS_INTRO_DESCRIPTION".localize(table: table))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .frame(height: 100)
            
            Spacer()
            
            Button("SMART_STYLES_SETTINGS_NOT_ENOUGH_PHOTOS_DISMISS".localize(table: table)) {
                dismiss()
            }
            .fontWeight(.semibold)
            .font(.headline)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.blue)
            .foregroundStyle(Color.white)
            .cornerRadius(15)
            
//            Button("SMART_STYLES_SETTINGS_LAUNCH_CAMERA".localize(table: table)) {
//                dismiss()
//            }
//            .padding(.top, 10)
//            .bold()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhotographicStylesView()
    }
}
