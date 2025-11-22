//
//  SoftwareUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update
//

import SwiftUI

struct SoftwareUpdateView: View {
    @State private var checkingForUpdates = false
    let path = "/System/Library/PrivateFrameworks/SoftwareUpdateSettings.framework"
    let general = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"
    let update = "/System/Library/PrivateFrameworks/SoftwareUpdateUIKit.framework"
    let table = "Software Update"

    var body: some View {
        GeometryReader { geometry in
            CustomList(title: "SOFTWARE_UPDATE".localized(path: path, table: table)) {
                Section {
                    SettingsLink(
                        "AUTOMATIC_UPDATES".localized(path: path, table: table),
                        status: "ON".localized(path: path, table: table),
                        destination: AutomaticUpdateView()
                    )
                }
                
                VStack {
                    if checkingForUpdates {
                        ProgressView()
                            .controlSize(.large)
                            .padding(.bottom, 1)
                    }

                    if checkingForUpdates {
                        withAnimation {
                            Text("CHECKING_FOR_UPDATES".localized(path: path, table: table))
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                        }
                    } else {
                        if UIDevice.`apple-internal-install` {
                            ContentUnavailableView {
                                Label(
                                    "Unable to Check for Update".localized(path: update),
                                    systemImage: "exclamationmark.circle.fill"
                                )
                            } description: {
                                Text("""
                                    An error occurred while checking for a software update.

                                    [Internal Only]
                                    Verify that you are connected to the Internal Network; trigger VPN manually if applicable.
                                    """.localized(path: update)
                                )
                                .font(.caption)
                            } actions: {
                                Button("Try Again".localized(path: update)) {
                                    checkForUpdates()
                                }
                                .font(.footnote)
                            }
                            .frame(width: geometry.size.width)
                        } else {
                            ContentUnavailableView {
                                Label(
                                    "\(UIDevice.iPhone ? "UP_TO_DATE_IPHONE" : "UP_TO_DATE_IPAD")".localized(path: path, table: table),
                                    systemImage: "checkmark.circle.fill"
                                )
                            } description: {
                                Text("\("\(UIDevice.iPhone ? "OS_PLATFORM_IPHONE" : "OS_PLATFORM_IPAD")".localized(path: path, table: table)) \(UIDevice().systemVersion)")
                            } actions: {
                                NavigationLink("More Details".localized(path: update)) {
                                    BundleControllerView(
                                        "\(general)/GeneralSettingsUI",
                                        controller: "PSGSoftwareVersionController",
                                        title: "OS Version".localized(path: general)
                                    )
                                }
                                .navigationLinkIndicatorVisibility(.hidden)
                                .foregroundStyle(.blue)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .frame(height: geometry.size.height/1.4)
                .onAppear {
                    checkForUpdates()
                }
            }
        }
        .refreshable {
            checkForUpdates()
        }
    }
    
    private func checkForUpdates() {
        Task {
            checkingForUpdates = true
            try await Task.sleep(for: .seconds(Double.random(in: 0.1...3.0)))
            withAnimation {
                checkingForUpdates.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SoftwareUpdateView()
    }
}
