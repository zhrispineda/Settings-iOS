//
//  AppWebsiteActivitySheetView.swift
//  Preferences
//
//  Settings > Screen Time > App & Website Activity [Sheet]
//

import SwiftUI

struct AppWebsiteActivitySheetView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 15) {
                    Image("person.badge.hourglass.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    Text("App & Website\nActivity")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text("Get insights about your screen time and set limits for what you want to manage.")
                }
                .padding(40)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.title)
                            .foregroundStyle(.blue)
                            .frame(minWidth: 50)
                        VStack(alignment: .leading) {
                            Text("**Weekly Reports**")
                                .font(.subheadline)
                            Text("Get a weekly report with insights about your screen time.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Image("downtime20x20")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 34)
                            .frame(minWidth: 50)
                        VStack(alignment: .leading) {
                            Text("**Downtime**")
                                .font(.subheadline)
                            Text("Set a schedule for time away from the screen.")
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
                            Text("**App Limits**")
                                .font(.subheadline)
                            Text("Set daily time limits for app categories you want to manage.")
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
                Button("**Turn On App & Website Activity**", action: {
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
    AppWebsiteActivitySheetView()
}
