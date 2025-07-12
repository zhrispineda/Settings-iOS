//
//  AppWebsiteActivitySheetView.swift
//  Preferences
//
//  Settings > Screen Time > App & Website Activity [Sheet]
//

import SwiftUI

struct AppWebsiteActivitySheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var appWebsiteActivityEnabled: Bool
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 15) {
                    Image(_internalSystemName: "person.badge.hourglass.fill")
                        .resizable()
                        .foregroundStyle(.blue)
                        .symbolRenderingMode(.hierarchical)
                        .scaledToFit()
                        .frame(height: 70)
                    Text("AppAndWebsiteActivitySpecifierName".localized(path: path))
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("IntroWelcomeDetail".localized(path: path))
                }
                .padding(40)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.title)
                            .foregroundStyle(.blue)
                            .frame(minWidth: 50)
                        VStack(alignment: .leading) {
                            Text("IntroWelcomeWeeklyReportsTitle".localized(path: path))
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            Text("IntroWelcomeWeeklyReportsDetail".localized(path: path))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(_internalSystemName: "downtime")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blue)
                            .frame(width: 34)
                            .frame(minWidth: 50)
                        VStack(alignment: .leading) {
                            Text("DeviceDowntimeSpecifierName".localized(path: path))
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            Text("IntroAppAndWebsiteActivityScheduledDowntimeDetail".localized(path: path))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "hourglass")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                            .frame(minWidth: 50)
                        VStack(alignment: .leading) {
                            Text("AppLimitsSpecifierName".localized(path: path))
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            Text("AppAndWebsiteActivityEDUAppLimitsDetail".localized(path: path))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.horizontal, 5)
            .padding(.top, -100)
            VStack(spacing: 20) {
                Spacer()
                Button("IntroAppAndWebsiteActivityTurnOnButton".localized(path: path)) {
                    withAnimation {
                        appWebsiteActivityEnabled.toggle()
                    }
                    dismiss()
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                Button("AppAndWebsiteActivityEDUNotNowButton".localized(path: path)) {
                    dismiss()
                }
                .fontWeight(.semibold)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    AppWebsiteActivitySheetView(appWebsiteActivityEnabled: .constant(false))
}
