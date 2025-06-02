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
                    
                    //                if !checkingForUpdates && !updateCheckFailed {
                    //                    SettingsLink("Beta Updates", status: "\(UIDevice().systemName) 18 Developer Beta", destination: BetaUpdatesView())
                    //                }
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
                                "\("OS_PLATFORM_IPHONE".localize(table: table)) \(UIDevice().systemVersion)",
                                systemImage: "",
                                description: Text("UP_TO_DATE_IPHONE", tableName: table)
                            )
                        } else if UIDevice.iPad {
                            ContentUnavailableView(
                                "\("OS_PLATFORM_IPAD".localize(table: table)) \(UIDevice().systemVersion)",
                                systemImage: "",
                                description: Text("UP_TO_DATE_IPAD", tableName: table)
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .frame(height: geometry.size.height/1.4)
                .onAppear {
                    Task {
                        checkingForUpdates = true
                        try await Task.sleep(for: .seconds(Double.random(in: 0.1...5.0)))
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
