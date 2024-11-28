//
//  OnBoardingView.swift
//  Preferences
//
//  Based off of OnBoardingKit, relies to CFBundleURLTypes to fire onOpenURL.
//  URLs do not open in Preview, use Simulator or a physical device, or
//  manually set the variable for displaying the sheet to true.
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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if isService(table: table) {
                        Image(_internalSystemName: "privacy.handshake")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .foregroundStyle(.blue)
                    }
                    Text(splashString(table: table))
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
                    Text(summaryString(table: table))
                        .font(.footnote)
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
                    Text(.init(footerString()))
                        .font(.caption)
                        .padding(.top, 1)
                    if !childView && table != "BatteryUI" { // Hide Learn More... link if previous view in navigation exists or BatteryUI table
                        NavigationLink("WELCOME_LEARN_MORE".localize(table: "PrivacyDisclosureUI")) {
                            OnBoardingDetailView()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 0)
                        .font(.subheadline)
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
    OnBoardingView(table: "BatteryUI")
}
