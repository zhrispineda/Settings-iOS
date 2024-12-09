/*
Abstract:
Based off of OnBoardingKit, shows the collection of Privacy tables.
*/

import SwiftUI

/// A `NavigationStack` container for displaying a list of Privacy tables.
/// ```swift
/// var body: some View {
///     OnBoardingDetailView()
/// }
/// ```
struct OnBoardingDetailView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @State private var frameY = Double()
    @State private var opacity = Double()
    var table = "PrivacyPane"
    let tables = [ // SPLASH_SHORT_TITLE tables
        "Activity",
        "ADPAnalytics",
        "AirDrop",
        "AppStore",
        "OBAppleID", // AppleID
        "Advertising",
        "AppleArcade",
        "AppleBooks",
        "AppleCard",
        "ApplePayCash",
        "FitnessPlus",
        "Intelligence",
        "Maps",
        "BusinessChat",
        "AppleMusic",
        "AppleMusicFriends",
        "News",
        "NewsletterIssues",
        "ApplePay",
        "ApplePayLater",
        "Podcasts",
        "ResearchApp",
        "TVApp",
        "Camera",
        "CheckIn",
        "ClassKit",
        "ConnectedCards",
        "EmergencySOS",
        "ExposureNotifications",
        "FaceID",
        "FaceTime",
        "FamilySetup",
        "FamilySharing",
        "FindMy",
        "GameCenter",
        "GymKit",
        "HealthApp",
        "HealthRecords",
        "HomeElectricity",
        "AnalyticsiCloud",
        "iCloudKeychain",
        "PrivateRelay",
        "Identity",
        "ImproveApplePay",
        "ImproveAstVoice",
        "ImproveCommunicationSafety",
        "ImproveEVRouting",
        "ImproveFitnessPlus",
        "ImproveHandwashing",
        "ImproveHealth",
        "ImproveHealthRecords",
        "ImproveMaps",
        "ImproveSafetyFeatures",
        "ImproveSensitiveContentWarning",
        "ImproveSiriDictation",
        "WheelchairMode",
        "iTunesStore",
        "Journal",
        "LocationServices",
        "MailPrivacyProtection",
        "MapsRAP",
        "OBMessages", // Messages
        "MySports",
        "NFCAndSEPlatform",
        "Passwords",
        "SpatialAudioProfiles",
        "OBPhotos", // Photos
        "RatingsAndPhotos",
        "Safari",
        "SafetyFeatures",
        "Savings",
        "SiriSuggestions",
        "SensorUsage",
        "ShortcutsSharing",
        "SignInWithApple",
        "SignInWithAppleAtWorkAndSchool",
        "AskSiri",
        "SMSFiltering",
        "Stocks",
        "OBTouchID", // TouchID
        "Translate",
        "TVProvider",
        "VPNs",
        "Wallet",
        "Weather",
        "CloudCalling"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    // Handshake icon
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
                    
                    // Title text
                    Text("SPLASH_TITLE", tableName: table)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    // Summary text
                    Text("SPLASH_SUMMARY", tableName: table)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    
                    // Device footer text
                    Text(UIDevice.iPhone ? "FOOTER_TEXT_IPHONE" : "FOOTER_TEXT_IPAD", tableName: table)
                        .font(.subheadline)
                    
                    Text("[\("BUTTON_TITLE".localize(table: "OBAppleID"))](https://www.apple.com/privacy)")
                        .padding(.bottom, 10)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .multilineTextAlignment(.center)
                .scrollContentBackground(.hidden)
                
                // List of apps and services with privacy tables
                Section {
                    ForEach(tables, id: \.self) { item in
                        NavigationLink(destination: OnBoardingView(table: item, childView: true)) {
                            Text(splashTitle(textTable: item))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(UIColor.label))
                        }
                        .listRowBackground(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.secondarySystemGroupedBackground))
                    }
                }
            }
            .navigationTitle("PRIVACY".localize(table: "PSSystemPolicy"))
            .navigationBarTitleDisplayMode(.inline)
            .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
            .scrollContentBackground(.hidden)
            .contentMargins(.horizontal, 20, for: .scrollContent)
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
    
    /// A function that returns the value of a splash title based on the given table name.
    /// - Parameter textTable: The `String` name of the table to use for localization.
    /// - Returns: The `String` value of the shortened splash title from the given table variable `textTable`.
    private func splashTitle(textTable: String) -> String {
        if NSLocalizedString("SPLASH_SHORT_TITLE_WIFI", tableName: textTable, comment: "") != "SPLASH_SHORT_TITLE_WIFI" {
            return "SPLASH_SHORT_TITLE_WIFI".localize(table: textTable)
        }
        return "SPLASH_SHORT_TITLE".localize(table: textTable)
    }
}

#Preview {
    OnBoardingDetailView()
}
