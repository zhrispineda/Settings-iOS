//
//  SensitivePhotosVideosProtectionSheetView.swift
//  Preferences
//
//  Settings > Screen Time > Communication Safety [Sheet]
//

import SwiftUI

struct SensitivePhotosVideosProtectionSheetView: View {
    @Environment(\.dismiss) private var dismiss
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(systemName: "bubble.left.and.exclamationmark.bubble.right.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.blue)
                    .symbolRenderingMode(.hierarchical)
                Text("IntroCommunicationSafetyTitle".localized(path: path))
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .multilineTextAlignment(.center)
                Text("CommunicationSafetyEDUFeatureDetails".localized(path: path))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("[\("IntroCommunicationSafetyLearnMoreButton".localized(path: path))](https://support.apple.com/HT212850)")
                Spacer()
            }
            .padding(.top, 75)
            .padding(.horizontal, 30)
            
            VStack(spacing: 20) {
                Spacer()
                Button("IntroCommunicationSafetyTurnOnButton".localized(path: path)) {
                    dismiss()
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("CommunicationSafetyEDUNotNow".localized(path: path)) {
                    dismiss()
                }
                .fontWeight(.semibold)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    SensitivePhotosVideosProtectionSheetView()
}
