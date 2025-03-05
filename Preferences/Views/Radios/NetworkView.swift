//
//  NetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi
//

import SwiftUI

struct NetworkView: View {
    // Variables
    @AppStorage("wifi") private var wifiEnabled = true
    @AppStorage("AskJoinNetworkSelection") private var askJoinNetworkSelection = "kWFLocAskToJoinDetailNotify"
    @AppStorage("AutoJoinHotspotSelection") private var autoJoinHotspotSelection = "kWFLocAutoInstantHotspotJoinAskTitle"
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    @State private var frameY = Double()
    @State private var opacity = Double()
    @State private var searching = true
    @State private var showingOtherNetwork = false
    @State private var timer: Timer? = nil
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocWiFiPowerTitle".localize(table: table)) {
            if isEditing {
                Section {} header: {
                    Text("kWFLocAllEditableKnownSectionTitle", tableName: table)
                }
            } else {
                Section {
                    Placard(title: "kWFLocWiFiPlacardTitle".localize(table: table), color: Color.blue, icon: "wifi", description: "kWFLocWiFiPlacardSubtitle".localize(table: table), frameY: $frameY, opacity: $opacity)
                    
                    Toggle(isOn: $wifiEnabled) {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.clear)
                            Text("kWFLocWiFiPlacardTitle", tableName: table)
                        }
                    }
//                    ZStack {
//                        HStack {
//                            Image(systemName: "checkmark")
//                                .foregroundStyle(.blue)
//                                .fontWeight(.semibold)
//                            Text("Network")
//                            Spacer()
//                            Image(systemName: "lock.fill")
//                                .imageScale(.small)
//                            Image(systemName: "wifi")
//                                .imageScale(.small)
//                            Button {} label: {
//                                Image(systemName: "info.circle")
//                                    .foregroundStyle(.blue)
//                            }
//                        }
//                        NavigationLink(destination: NetworkDetailView(name: "Network")) {}
//                            .opacity(0)
//                    }
                } footer: {
                    if !wifiEnabled {
                        Text(UIDevice.iPhone ? "kWFLocLocationServicesCellularWarning" : "kWFLocLocationServicesWarning", tableName: table)
                    }
                }
                
                if wifiEnabled {
                    Section {
                        Button {
                            showingOtherNetwork.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.clear)
                                Text("kWFLocOtherNetworkTitle", tableName: table)
                                    .foregroundStyle(Color["Label"])
                                    .sheet(isPresented: $showingOtherNetwork) {
                                        OtherNetworkView()
                                            .foregroundStyle(Color["Label"])
                                    }
                            }
                        }
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
                    
                    Section {
                        CustomNavigationLink("kWFLocAskToJoinTitle".localize(table: table), status: askJoinNetworkSelection.localize(table: table), destination: SelectOptionList(title: "kWFLocAskToJoinTitle", options: ["kWFLocAskToJoinDetailOff", "kWFLocAskToJoinDetailNotify", "kWFLocAskToJoinDetailAsk"], selectedBinding: $askJoinNetworkSelection, table: table))
                    } footer: {
                        Text("kWFLocAskToJoinNotifyFooter", tableName: table)
                    }
                    
                    Section {
                        CustomNavigationLink("kWFLocAutoInstantHotspotTitle".localize(table: table), status: autoJoinHotspotSelection.localize(table: table), destination: SelectOptionList(title: "kWFLocAutoInstantHotspotTitle", options: ["kWFLocAutoInstantHotspotJoinNeverTitle", "kWFLocAutoInstantHotspotJoinAskTitle", "kWFLocAutoInstantHotspotJoinAutoTitle"], selectedBinding: $autoJoinHotspotSelection, table: table))
                    } footer: {
                        Text("kWFLocAutoInstantHotspotFooter", tableName: table)
                    }
                }
            }
        }
        .padding(.top, isEditing ? 19 : 0)
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .topBarLeading) {
                    Button("kWFLocAdhocJoinCancelButton".localize(table: table)) {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("kWFLocWiFiPlacardTitle", tableName: table)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the placard title
            }
            
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
