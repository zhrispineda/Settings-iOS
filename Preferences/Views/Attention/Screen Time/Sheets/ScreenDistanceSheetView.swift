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
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundStyle(.gray)
                    .frame(maxHeight: 275)
                Spacer()
            }
            VStack(spacing: 15) {
                Text("**Screen Distance**")
                    .font(.largeTitle)
                    .padding(.top, 30)
                Text("To reduce eye strain, and the risk of myopia in children, Screen Distance will alert you to hold an iPhone or iPad with Face ID at a recommended distance.")
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            .padding(.top, -50)
            VStack(spacing: 20) {
                Spacer()
                Text("Screen Distance works by measuring the distance between the screen and your eyes. The camera is not capturing images or video, and the data collected remains on the device and is not shared with Apple.")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Button("**Continue**") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("**Not Now**") {
                    dismiss()
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    ScreenDistanceSheetView()
}
