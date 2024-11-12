//
//  OnBoardingDetailView.swift
//  Preferences
//

import SwiftUI

struct OnBoardingDetailView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var frameY = Double()
    @State private var opacity = Double()
    var table = "PrivacyPane"
    let tables = [ // SPLASH_SHORT_TITLE tables
        "Activity",
        "ADPAnalytics",
        "AppStore",
        "OBAppleID", // AppleID
        "AirDrop",
        "Camera",
        "FitnessPlus",
        "ImproveSensitiveContentWarning",
        "OBPhotos", // Photos
        "Passwords",
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    Image(_internalSystemName: "privacy.handshake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .foregroundStyle(.blue)
                        .overlay { // For calculating opacity of the principal toolbar item
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .scrollView).minY) {
                                        frameY = geo.frame(in: .scrollView).minY
                                    }
                            }
                        }
                    Text("SPLASH_TITLE", tableName: table)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("SPLASH_SUMMARY", tableName: table)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Text(UIDevice.iPhone ? "FOOTER_TEXT_IPHONE" : "FOOTER_TEXT_IPAD", tableName: table)
                        .font(.footnote)
                    Text("[See how your data is managed...](https://www.apple.com/privacy)")
                        .padding(.bottom, 10)
                        .font(.footnote)
                }
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Section {
                    ForEach(tables, id: \.self) { item in
                        NavigationLink(destination: OnBoardingView(table: item, childView: true)) {
                            Text("SPLASH_SHORT_TITLE", tableName: item)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor.label))
                        }
                        .listRowBackground(Color(UIColor.tertiarySystemGroupedBackground))
                    }
                }
            }
            .navigationTitle("PRIVACY".localize(table: "PSSystemPolicy"))
            .navigationBarTitleDisplayMode(.inline)
            .background(colorScheme == .light ? .white : Color(UIColor.secondarySystemBackground))
            .scrollContentBackground(.hidden)
            .contentMargins(.horizontal, 30, for: .scrollContent)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SPLASH_TITLE", tableName: table)
                        .opacity(frameY < -10 ? 1 : 0)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    OnBoardingDetailView()
}
