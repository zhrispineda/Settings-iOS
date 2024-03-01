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
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(systemName: "bubble.left.and.exclamationmark.bubble.right.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.blue)
                    .symbolRenderingMode(.hierarchical)
                Text("**Sensitive Photos and Videos Protection**")
                    .font(.largeTitle)
                    .padding(.top, 30)
                    .multilineTextAlignment(.center)
                Text("Apple products help protect kids from sharing sensitive photos and videos, with resources to guide them.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("iOS can detect nude photos and videos before they‘re sent or viewed on your child‘s device, and provide guidance and age-appropriate resources to help them make a safe choice. Apple does not have access to the photos or videos.")
                    .multilineTextAlignment(.center)
                Text("[Learn more about Communication Safety...](https://support.apple.com/en-us/HT212850)")
                Spacer()
            }
            .padding(.top, 75)
            .padding(.horizontal, 30)
            VStack(spacing: 20) {
                Spacer()
                Button("**Continue**", action: {
                    dismiss()
                })
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("**Not Now**", action: {
                    dismiss()
                })
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    SensitivePhotosVideosProtectionSheetView()
}
