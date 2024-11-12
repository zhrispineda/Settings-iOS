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
    @State private var textHeight = Double()
    @State private var viewHeight = Double()
    var table = String()
    var childView = false // If view is from a parent view
    let services = [
        "Activity",
        "ADPAnalytics",
        "AppleArcade",
        "AppleBooks",
        "AppleCard",
        "ApplePayCash",
        "AppStore",
        "FitnessPlus",
        "OBAppleID" // AppleID
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if services.contains(table) {
                        Image(_internalSystemName: "privacy.handshake")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .foregroundStyle(.blue)
                    }
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
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    if services.contains(table) { // For services that have 3 separate bullet point keys
                        BulletPoint(key: table == "OBAppleID" ? "FIRST_BULLET_\(UIDevice.current.model.uppercased())" : "FIRST_BULLET", table: table)
                        BulletPoint(key: "SECOND_BULLET", table: table)
                        BulletPoint(key: "THIRD_BULLET", table: table)
                        // Check if fourth and fifth keys exist by comparing values
                        if NSLocalizedString("FOURTH_BULLET", tableName: table, comment: "") != "FOURTH_BULLET" {
                            BulletPoint(key: "FOURTH_BULLET", table: table)
                        }
                        if NSLocalizedString("FIFTH_BULLET", tableName: table, comment: "") != "FIFTH_BULLET" {
                            BulletPoint(key: "FIFTH_BULLET", table: table)
                        }
                    }
                    switch table {
                    case "OBAppleID":
                        Text("FOOTER_TEXT_WIFI_\(UIDevice.current.model.uppercased())".localize(table: table))
                            .font(.caption)
                            .padding(.top, 1)
                    case "Advertising", "AirDrop", "AppleBooks":
                        Text("FOOTER_TEXT_WIFI", tableName: table)
                            .font(.caption)
                            .padding(.top, 1)

                    default:
                        Text("FOOTER_TEXT", tableName: table)
                            .font(.caption)
                            .padding(.top, 1)
                    }
                    if !childView { // Hide Learn More... link if previous view in navigation exists
                        NavigationLink("WELCOME_LEARN_MORE".localize(table: "PrivacyDisclosureUI")) {
                            OnBoardingDetailView()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 0)
                        .font(.subheadline)
                    }
                }
                .padding(.horizontal, 50)
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            textHeight = geo.size.height
                        }
                    }
                }
            }
            .scrollDisabled(textHeight < viewHeight)
            .toolbar {
                if !childView {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                        .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("SPLASH_TITLE", tableName: table)
                        .opacity(frameY < -25 ? 1 : 0)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
        }
        .overlay {
            GeometryReader { geo in
                Color.clear.onAppear {
                    viewHeight = geo.size.height
                    
                }
            }
        }
    }
}

struct BulletPoint: View {
    let key: String
    let table: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text("• ")
                .fontWeight(.heavy)
                .offset(y: -3.5)
                .foregroundStyle(Color(UIColor.secondaryLabel))
            Text(key.localize(table: table))
                .font(.caption)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

#Preview {
    OnBoardingView(table: "ApplePayCash")
}
