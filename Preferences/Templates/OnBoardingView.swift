/*
Abstract:
Based off of OnBoardingKit, relies on CFBundleURLTypes to fire onOpenURL.
URLs do not open in Preview, use Simulator or a physical device, or
manually set the variable for displaying the sheet to true.
*/

import SwiftUI

/// A `ScrollView` container for displaying OnBoardingKit-like views for providing privacy information.
/// ```swift
/// var body: some View {
///     OnBoardingView(table: "BatteryUI")
/// }
/// ```
/// - Parameter table: The `String` table name to use for localization.
/// - Parameter childView: The `Bool` value for whether the view is a child view.
struct OnBoardingView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var frameY = Double()
    @State private var opacity = Double()
    @State private var textHeight = Double()
    @State private var viewHeight = Double()
    var table = String()
    var childView = false // If view is from a parent view
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if isService(table: table) {
                        // Handshake icon
                        Image(_internalSystemName: "privacy.handshake")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .foregroundStyle(.blue)
                    }
                    
                    // App or service splash title
                    Text(splashString(table: table))
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .opacity(frameY < -25 ? 0 : 1)
                        .overlay { // For calculating opacity of the principal toolbar item
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .scrollView).minY) {
                                        withAnimation {
                                            frameY = geo.frame(in: .scrollView).minY
                                        }
                                    }
                            }
                        }
                    
                    // Summary text
                    Text(summaryString(table: table))
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    
                    if isService(table: table) {
                        BulletPoint(key: bulletString(text: "FIRST_BULLET"), table: table)
                        BulletPoint(key: bulletString(text: "SECOND_BULLET"), table: table)
                        // Check keys exist by comparing values
                        if NSLocalizedString("THIRD_BULLET", tableName: table, comment: "") != "THIRD_BULLET" {
                            BulletPoint(key: "THIRD_BULLET", table: table)
                        }
                        if NSLocalizedString("FOURTH_BULLET", tableName: table, comment: "") != "FOURTH_BULLET" {
                            BulletPoint(key: "FOURTH_BULLET", table: table)
                        }
                        if NSLocalizedString("FIFTH_BULLET", tableName: table, comment: "") != "FIFTH_BULLET" {
                            BulletPoint(key: "FIFTH_BULLET", table: table)
                        }
                    }
                    
                    // Footer text
                    Text(.init(footerString()))
                        .font(.footnote)
                        .padding(.top, 1)
                    
                    // Learn more link
                    if !childView && table != "BatteryUI" { // Hide Learn More... link if previous view in navigation exists or BatteryUI table
                        NavigationLink("WELCOME_LEARN_MORE".localize(table: "PrivacyDisclosureUI")) {
                            OnBoardingDetailView()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 0)
                        .font(.callout)
                    }
                }
                .padding(.horizontal, 40)
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            textHeight = geo.size.height
                        }
                    }
                }
            }
            .navigationTitle(splashString(table: table))
            .navigationBarTitleDisplayMode(.inline)
            .scrollDisabled(textHeight < viewHeight && UIDevice.iPhone)
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
                    Text(splashString(table: table))
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
    
    // MARK: Functions
    
    
    /// Returns a `Bool` on whether the table has characteristics of a service.
    /// - Parameter table: The `String` name of the table to use for localization.
    /// - Returns: A `Bool` on whether the table is a service or not.
    private func isService(table: String) -> Bool {
        // Check if key is localized
        if NSLocalizedString("FIRST_BULLET", tableName: table, comment: "") != "FIRST_BULLET" {
            return true
        }
        
        // Otherwise, check table name
        switch table {
        case "OBAppleID", "TVApp":
            return true
        default:
            return false
        }
    }
    
    /// Returns the `String` value of the title based on the given table variable.
    /// - Parameter table: The `String` name of the table to use for localization.
    /// - Returns: The `String` value of the title.
    private func splashString(table: String) -> String {
        switch table {
        case "BatteryUI":
            return NSLocalizedString("BATTERY_WARRANTY_TITLE", tableName: table, comment: "")
        case "TVApp", "CloudCalling":
            return NSLocalizedString("SPLASH_TITLE_WIFI", tableName: table, comment: "")
        default:
            return NSLocalizedString("SPLASH_TITLE", tableName: table, comment: "")
        }
    }
    
    /// Returns the `String` value of a table's summary given the table name.
    /// - Parameter table: The `String` name of the table to use for localization.
    /// - Returns: The `String` value of the summary.
    private func summaryString(table: String) -> String {
        switch table {
        case "BatteryUI":
            return NSLocalizedString(UIDevice.iPhone ? "BATTERY_WARRANTY_P1_IPHONE" : "BATTERY_WARRANTY_P1_IPAD", tableName: table, comment: "")
        case "TVApp", "CloudCalling":
            return NSLocalizedString("SPLASH_SUMMARY_WIFI", tableName: table, comment: "")
        default:
            return NSLocalizedString("SPLASH_SUMMARY", tableName: table, comment: "")
        }
    }
    
    /// Returns the `String` value of the bullet point.
    /// - Parameter text: The `String` value to use for holding the bullet point string.
    /// - Returns: The `String` value of the bullet point.
    private func bulletString(text: String) -> String {
        let completeString = text
        
        switch table {
        case "OBAppleID":
            if text == "FIRST_BULLET" {
                return completeString + "_" + UIDevice.current.model.uppercased()
            }
            return completeString
        case "TVApp":
            return completeString + "_WIFI"
        default:
            return completeString
        }
    }
    
    /// Returns the `String` value of the footer text.
    /// - Returns: The `String` value of the footer text.
    private func footerString() -> String {
        if table == "BatteryUI" {
            var formattedString = String()
            if UIDevice.iPhone {
                formattedString = "BATTERY_WARRANTY_P2_IPHONE".localize(table: table, "80%", "1000", "[\("LM_TEXT".localize(table: table))](\("BW_LM_URL_2_IPHONE".localize(table: table)))")
                formattedString += "\n\n" + "BATTERY_WARRANTY_P3".localize(table: table, "[\("LM_TEXT".localize(table: table))](BW_LM_URL_3)")
            } else {
                formattedString = "BATTERY_WARRANTY_P2_IPAD".localize(table: table, "80%", "1000", "[\("LM_TEXT".localize(table: table))](\("BW_LM_URL_2_IPHONE".localize(table: table)))")
            }
            return formattedString
        } else if table == "AskSiri" {
            return UIDevice.iPhone ? "FOOTER_TEXT_IPHONE".localize(table: table) : "FOOTER_TEXT_IPAD".localize(table: table)
        }
        if NSLocalizedString("FOOTER_TEXT_WIFI_\(UIDevice.current.model.uppercased())", tableName: table, comment: "") != "FOOTER_TEXT_WIFI_\(UIDevice.current.model.uppercased())" {
            return "FOOTER_TEXT_WIFI_\(UIDevice.current.model.uppercased())".localize(table: table)
        } else if NSLocalizedString("FOOTER_TEXT_WIFI", tableName: table, comment: "") != "FOOTER_TEXT_WIFI" {
            return "FOOTER_TEXT_WIFI".localize(table: table)
        } else {
            return "FOOTER_TEXT".localize(table: table)
        }
    }
}

/// An `HStack` container for displaying a bullet point from an onboarding table.
/// ```swift
/// var body: some View {
///     List {
///         BulletPoint(key: bulletString(text: "FIRST_BULLET"), table: table)
///     }
/// }
/// ```
/// - Parameter key: The `String` key to localize.
/// - Parameter table: The `String` name of the table to use for localization.
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
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.bottom, 3)
    }
}

#Preview {
    OnBoardingView(table: "OBAppleID")
}
