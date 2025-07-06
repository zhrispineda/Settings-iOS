//
//  SoftwareUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update
//

import SwiftUI

struct SoftwareUpdateView: View {
    @State private var checkingForUpdates = false
    let table = "Software Update"

    var body: some View {
        GeometryReader { geometry in
            CustomList(title: "SOFTWARE_UPDATE".localize(table: table)) {
                Section {
                    SettingsLink("AUTOMATIC_UPDATES".localize(table: table), status: "ON".localize(table: table), destination: AutomaticUpdateView())
                }
                VStack {
                    if checkingForUpdates {
                        ProgressView()
                            .controlSize(.large)
                            .padding(.bottom, 1)
                    }

                    if checkingForUpdates {
                        withAnimation {
                            Text("CHECKING_FOR_UPDATES", tableName: table)
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                        }
                    } else {
                        if UIDevice.iPhone {
                            ContentUnavailableView(
                                "UP_TO_DATE_IPHONE".localize(table: table),
                                systemImage: "checkmark.circle.fill",
                                description: Text("\("OS_PLATFORM_IPHONE".localize(table: table)) \(UIDevice().systemVersion)")
                            )
                            .frame(maxHeight: 170)
                            NavigationLink("More Details") {
                                BundleControllerView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGSoftwareVersionController", title: "OS Version", table: "GeneralSettingsUI")
                            }
                            .navigationLinkIndicatorVisibility(.hidden)
                            .foregroundStyle(.blue)
                        } else if UIDevice.iPad {
                            ContentUnavailableView(
                                "UP_TO_DATE_IPAD".localize(table: table),
                                systemImage: "checkmark.circle.fill",
                                description: Text("\("OS_PLATFORM_IPAD".localize(table: table)) \(UIDevice().systemVersion)")
                            )
                            .frame(maxHeight: 170)
                            NavigationLink("More Details") {
                                BundleControllerView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGSoftwareVersionController", title: "OS Version", table: "GeneralSettingsUI")
                            }
                            .navigationLinkIndicatorVisibility(.hidden)
                            .foregroundStyle(.blue)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .frame(height: geometry.size.height/1.4)
                .onAppear {
                    Task {
                        checkingForUpdates = true
                        try await Task.sleep(for: .seconds(Double.random(in: 0.1...3.0)))
                        withAnimation {
                            checkingForUpdates.toggle()
                        }
                    }
                }
            }
        }
        .refreshable {}
    }
}

#Preview {
    NavigationStack {
        SoftwareUpdateView()
    }
}
