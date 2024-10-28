//
//  ScreenDistanceSheetView.swift
//  Preferences
//
//  Settings > Screen Time > Screen Distance [Sheet]
//

import SwiftUI

struct ScreenDistanceSheetView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    let table = "ScreenTimeSettingsUI"
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(maxHeight: 275)
                Spacer()
            }
            VStack(spacing: 15) {
                Text("ScreenDistanceViewControllerTitle", tableName: table)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .padding(.top, 30)
                Text("ScreenDistanceEnableFeatureGroupSpecifierFooterText", tableName: table)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            .padding(.top, -50)
            VStack(spacing: 20) {
                Spacer()
                Text("ScreenDistanceEDUFeatureButtonTrayCaption", tableName: table)
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Button("ScreenDistanceEDUFeatureHowItWorksEnablementButton".localize(table: table)) {
                    dismiss()
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("ScreenDistanceEDUFeatureNotNowButton".localize(table: table)) {
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
