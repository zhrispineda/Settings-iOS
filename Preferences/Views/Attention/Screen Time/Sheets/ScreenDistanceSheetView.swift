//
//  ScreenDistanceSheetView.swift
//  Preferences
//
//  Settings > Screen Time > Screen Distance [Sheet]
//

import SwiftUI

struct ScreenDistanceSheetView: View {
    @Environment(\.dismiss) private var dismiss
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(maxHeight: 275)
                Spacer()
            }
            VStack(spacing: 15) {
                Text("ScreenDistanceViewControllerTitle".localized(path: path))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .padding(.top, 30)
                Text("ScreenDistanceEnableFeatureGroupSpecifierFooterText".localized(path: path))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            .padding(.top, -50)
            VStack(spacing: 20) {
                Spacer()
                Text("ScreenDistanceEDUFeatureButtonTrayCaption".localized(path: path))
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Button("ScreenDistanceEDUFeatureHowItWorksEnablementButton".localized(path: path)) {
                    dismiss()
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("ScreenDistanceEDUFeatureNotNowButton".localized(path: path)) {
                    dismiss()
                }
                .fontWeight(.semibold)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    ScreenDistanceSheetView()
}
