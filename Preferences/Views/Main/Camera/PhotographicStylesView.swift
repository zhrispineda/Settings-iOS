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
    
    var body: some View {
        VStack(spacing: 30) {
            Image("onboarding_asset")
            Text("Photographic Styles")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Text("Select four photos captured with this iPhone. If you have not taken any photos, open Camera to begin.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Spacer()
            Text("Photographic Styles lets you personalize how you appear in photos with incredible nuance to get the look you want.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Spacer()
                .frame(height: 130)
            Button("OK") {
                dismiss()
            }
            .fontWeight(.semibold)
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.blue)
            .foregroundStyle(Color.white)
            .cornerRadius(15)
            Button("Open Camera") {
                dismiss()
            }
            .bold()
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
