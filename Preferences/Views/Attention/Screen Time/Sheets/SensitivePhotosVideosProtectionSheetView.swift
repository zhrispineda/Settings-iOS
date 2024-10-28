//
//  SensitivePhotosVideosProtectionSheetView.swift
//  Preferences
//
//  Settings > Screen Time > Communication Safety [Sheet]
//

import SwiftUI

struct SensitivePhotosVideosProtectionSheetView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(systemName: "bubble.left.and.exclamationmark.bubble.right.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.blue)
                    .symbolRenderingMode(.hierarchical)
                Text("IntroCommunicationSafetyTitle", tableName: table)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .multilineTextAlignment(.center)
                Text("CommunicationSafetyEDUFeatureDetails", tableName: table)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("[\("IntroCommunicationSafetyLearnMoreButton".localize(table: table))](https://support.apple.com/en-us/HT212850)")
                Spacer()
            }
            .padding(.top, 75)
            .padding(.horizontal, 30)
            VStack(spacing: 20) {
                Spacer()
                Button("IntroCommunicationSafetyTurnOnButton".localize(table: table)) {
                    dismiss()
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("CommunicationSafetyEDUNotNow".localize(table: table)) {
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
