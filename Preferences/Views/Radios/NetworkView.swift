//
//  NetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi
//

import SwiftUI

struct NetworkView: View {
    @AppStorage("wifi") private var wifiEnabled = true
    @AppStorage("AskJoinNetworkSelection") private var askJoinNetworkSelection = "kWFLocAskToJoinDetailNotify"
    @AppStorage("AutoJoinHotspotSelection") private var autoJoinHotspotSelection = "kWFLocAutoInstantHotspotJoinAskTitle"
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    @State private var connected = false
    @State private var frameY = 0.0
    @State private var opacity = 0.0
    @State private var searching = true
    @State private var showingHelpSheet = false
    @State private var showingOtherNetwork = false
    @State private var timer: Timer? = nil
    @State private var currentTopicID = ""
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocWiFiPowerTitle".localized(path: path, table: table), topPadding: true) {
            if isEditing {
                Section {} header: {
                    Text("kWFLocAllEditableKnownSectionTitle".localized(path: path, table: table))
                }
            } else {
                Section {
                    Placard(
                        title: "kWFLocWiFiPlacardTitle".localized(
                            path: path,
                            table: table
                        ),
                        icon: "com.apple.graphic-icon.wifi",
                        description: "kWFLocWiFiPlacardSubtitle".localized(
                            path: path,
                            table: table
                        ).replacing(
                            "helpkit",
                            with: "pref"
                        ),
                        frameY: $frameY,
                        opacity: $opacity
                    )
                    
                    Toggle(isOn: $wifiEnabled) {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.clear)
                            Text("kWFLocWiFiPowerTitle".localized(path: path, table: table))
                        }
                    }
                    
                    if connected {
                        ZStack {
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                                Text("Network")
                                Spacer()
                                Image(systemName: "lock.fill")
                                    .imageScale(.small)
                                Image(systemName: "wifi")
                                    .imageScale(.small)
                                Button {} label: {
                                    Image(systemName: "info.circle")
                                        .foregroundStyle(.blue)
                                }
                            }
                            NavigationLink(destination: NetworkDetailView(name: "Network")) {}
                                .opacity(0)
                        }
                    }
                    
                } footer: {
                    if !wifiEnabled {
                        Text(UIDevice.iPhone ? "kWFLocLocationServicesCellularWarning".localized(path: path, table: table) : "kWFLocLocationServicesWarning".localized(path: path, table: table))
                    }
                }
                
                // Networks
                if wifiEnabled {
                    Section {
                        Button {
                            showingOtherNetwork.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.clear)
                                Text("kWFLocOtherNetworkTitle".localized(path: path, table: table))
                            }
                        }
                        .foregroundStyle(.primary)
                    } header: {
                        HStack {
                            Text("kWFLocChooseNetworkSectionSingleTitle".localized(path: path, table: table))
                            if searching {
                                ProgressView()
                                    .frame(height: 0) // Prevent changing header frame height
                            }
                        }
                    }
                    .onAppear {
                        // Repeat showing ProgressView()
                        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                            Task {
                                await beignConstantScan()
                            }
                        }
                        Task {
                            beignConstantScan()
                        }
                    }
                    .onDisappear {
                        timer?.invalidate()
                        timer = nil
                    }
                    
                    // Ask to Join
                    Section {
                        SettingsLink(
                            "kWFLocAskToJoinTitle".localized(
                                path: path,
                                table: table
                            ),
                            status: askJoinNetworkSelection.localized(
                                path: path,
                                table: table
                            ),
                            destination: SelectOptionList(
                                "kWFLocAskToJoinTitle",
                                options: [
                                    "kWFLocAskToJoinDetailOff",
                                    "kWFLocAskToJoinDetailNotify",
                                    "kWFLocAskToJoinDetailAsk"
                                ],
                                selectedBinding: $askJoinNetworkSelection,
                                path: path,
                                table: table
                            )
                        )
                    } footer: {
                        Text("kWFLocAskToJoinNotifyFooter".localized(path: path, table: table))
                    }
                    
                    // Auto-Join Hotspot
                    Section {
                        SettingsLink(
                            "kWFLocAutoInstantHotspotTitle".localized(
                                path: path,
                                table: table
                            ),
                            status: autoJoinHotspotSelection.localized(
                                path: path,
                                table: table
                            ),
                            destination: SelectOptionList(
                                "kWFLocAutoInstantHotspotTitle",
                                options: [
                                    "kWFLocAutoInstantHotspotJoinNeverTitle",
                                    "kWFLocAutoInstantHotspotJoinAskTitle",
                                    "kWFLocAutoInstantHotspotJoinAutoTitle"
                                ],
                                selectedBinding: $autoJoinHotspotSelection,
                                path: path,
                                table: table
                            )
                        )
                    } footer: {
                        Text("kWFLocAutoInstantHotspotFooter".localized(path: path, table: table))
                    }
                }
            }
        }
        .animation(.default, value: isEditing)
        .onOpenURL {_ in
            showingHelpSheet.toggle()
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iphd1cf4268" : "ipad2db29c3a")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $showingOtherNetwork) {
            OtherNetworkView()
        }
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            if isEditing {
                // Cancel Button
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
            }
            
            // Navigation Title
            ToolbarItem(placement: .principal) {
                Text("kWFLocWiFiPlacardTitle".localized(path: path, table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
            
            // Edit/Done Button
            ToolbarItem(placement: .topBarTrailing) {
                if isEditing {
                    Button(role: .confirm) {
                        isEditing.toggle()
                    }
                } else {
                    Button("kWFLocEditListButtonTitle".localized(path: path, table: table)) {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
            }
        }
    }
    
    private func beignConstantScan() {
        Task { @MainActor in
            searching = true
            
            try? await Task.sleep(for: .seconds(Int.random(in: 1...2)))
            searching = false
        }
    }
}

#Preview {
    NavigationStack {
        NetworkView()
    }
}
