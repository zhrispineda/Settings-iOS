//
//  OnBoardingView.swift
//  Preferences
//
//  Based off of OnBoardingKit, relies to CFBundleURLTypes to fire onOpenURL.
//

import SwiftUI

struct OnBoardingView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var frameY = Double()
    @State private var opacity = Double()
    var table = String()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    Text("SPLASH_TITLE", tableName: table)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .overlay { // For calculating opacity of the principal toolbar item
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .scrollView).minY) {
                                        frameY = geo.frame(in: .scrollView).minY
                                    }
                            }
                        }
                    Text("SPLASH_SUMMARY", tableName: table)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Text(table == "AirDrop" ? "FOOTER_TEXT_WIFI" : "FOOTER_TEXT", tableName: table)
                        .font(.caption)
                    NavigationLink("WELCOME_LEARN_MORE".localize(table: "PrivacyDisclosureUI")) {
                        EmptyView()
                    }
                        .padding(.top, 20)
                        .padding(.bottom, 0)
                        .font(.subheadline)
                }
                .padding(.horizontal, 50)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
                ToolbarItem(placement: .principal) {
                    Text("SPLASH_TITLE", tableName: table)
                        .opacity(frameY < -25 ? 1 : 0)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    OnBoardingView(table: "Camera")
}
