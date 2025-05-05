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
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocWiFiPowerTitle".localize(table: table), topPadding: true) {
            if isEditing {
                Section {} header: {
                    Text("kWFLocAllEditableKnownSectionTitle", tableName: table)
                }
            } else {
                Section {
                    Placard(title: "kWFLocWiFiPlacardTitle".localize(table: table), color: Color.blue, icon: "wifi", description: NSLocalizedString("kWFLocWiFiPlacardSubtitle", tableName: table, comment: "").replacing("helpkit", with: "pref"), frameY: $frameY, opacity: $opacity)
                    
                    Toggle(isOn: $wifiEnabled) {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.clear)
                            Text("kWFLocWiFiPowerTitle", tableName: table)
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
                        Text(UIDevice.iPhone ? "kWFLocLocationServicesCellularWarning" : "kWFLocLocationServicesWarning", tableName: table)
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
                                Text("kWFLocOtherNetworkTitle", tableName: table)
                            }
                        }
                        .foregroundStyle(.primary)
                    } header: {
                        HStack {
                            Text("kWFLocChooseNetworkSectionSingleTitle", tableName: table)
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
                        CustomNavigationLink("kWFLocAskToJoinTitle".localize(table: table), status: askJoinNetworkSelection.localize(table: table), destination: SelectOptionList("kWFLocAskToJoinTitle", options: ["kWFLocAskToJoinDetailOff", "kWFLocAskToJoinDetailNotify", "kWFLocAskToJoinDetailAsk"], selectedBinding: $askJoinNetworkSelection, table: table))
                    } footer: {
                        Text("kWFLocAskToJoinNotifyFooter", tableName: table)
                    }
                    
                    // Auto-Join Hotspot
                    Section {
                        CustomNavigationLink("kWFLocAutoInstantHotspotTitle".localize(table: table), status: autoJoinHotspotSelection.localize(table: table), destination: SelectOptionList("kWFLocAutoInstantHotspotTitle", options: ["kWFLocAutoInstantHotspotJoinNeverTitle", "kWFLocAutoInstantHotspotJoinAskTitle", "kWFLocAutoInstantHotspotJoinAutoTitle"], selectedBinding: $autoJoinHotspotSelection, table: table))
                    } footer: {
                        Text("kWFLocAutoInstantHotspotFooter", tableName: table)
                    }
                }
            }
        }
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
                    Button("kWFLocAdhocJoinCancelButton".localize(table: table)) {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
            }
            
            // Navigation Title
            ToolbarItem(placement: .principal) {
                Text("kWFLocWiFiPlacardTitle", tableName: table)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
            
            // Edit/Done Button
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Done" : "kWFLocEditListButtonTitle".localize(table: table)) {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
                .fontWeight(isEditing ? .bold : .regular)
                .disabled(isEditing)
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
