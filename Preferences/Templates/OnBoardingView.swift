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
    let services = ["Activity", "FitnessPlus"]
    
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
                        HStack(alignment: .top, spacing: 15) {
                            Text("• ")
                                .fontWeight(.heavy)
                                .padding(.top, 5)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Text("FIRST_BULLET", tableName: table)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        HStack(alignment: .top, spacing: 15) {
                            Text("• ")
                                .fontWeight(.heavy)
                                .padding(.top, 5)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Text("SECOND_BULLET", tableName: table)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack(alignment: .top, spacing: 15) {
                            Text("• ")
                                .fontWeight(.heavy)
                                .padding(.top, 5)
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                            Text("THIRD_BULLET", tableName: table)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical, 10)
                            Spacer()
                        }
                    }
                    Text(table == "AirDrop" ? "FOOTER_TEXT_WIFI" : "FOOTER_TEXT", tableName: table)
                        .font(.caption)
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

#Preview {
    OnBoardingView(table: "Activity")
}
