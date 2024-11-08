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
    @State private var showingOtherNetwork = false
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocWiFiPowerTitle".localize(table: table)) {
            if isEditing {
                Section {} header: {
                    Text("kWFLocAllEditableKnownSectionTitle", tableName: table)
                }
            } else {
                Section {
                    Placard(title: "kWFLocWiFiPlacardTitle".localize(table: table), color: Color.blue, icon: "wifi", description: "kWFLocWiFiPlacardSubtitle".localize(table: table))
                        .overlay { // For calculating opacity of the principal toolbar item
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .scrollView).minY) {
                                        frameY = geo.frame(in: .scrollView).minY
                                        opacity = frameY / -30
                                    }
                            }
                        }
                    
                    Toggle(isOn: $wifiEnabled) {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.clear)
                            Text("kWFLocWiFiPlacardTitle", tableName: table)
                        }
                    }
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
                        Text("kWFLocChooseNetworkSectionSingleTitle", tableName: table)
                    }
                    
                    Section {
                        CustomNavigationLink(title: "kWFLocAskToJoinTitle".localize(table: table), status: askJoinNetworkSelection.localize(table: table), destination: SelectOptionList(title: "kWFLocAskToJoinTitle", options: ["kWFLocAskToJoinDetailOff", "kWFLocAskToJoinDetailNotify", "kWFLocAskToJoinDetailAsk"], selectedBinding: $askJoinNetworkSelection, table: table))
                    } footer: {
                        Text("kWFLocAskToJoinNotifyFooter", tableName: table)
                    }
                    
                    Section {
                        CustomNavigationLink(title: "kWFLocAutoInstantHotspotTitle".localize(table: table), status: autoJoinHotspotSelection.localize(table: table), destination: SelectOptionList(title: "kWFLocAutoInstantHotspotTitle", options: ["kWFLocAutoInstantHotspotJoinNeverTitle", "kWFLocAutoInstantHotspotJoinAskTitle", "kWFLocAutoInstantHotspotJoinAutoTitle"], selectedBinding: $autoJoinHotspotSelection, table: table))
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
                Text("kWFLocWiFiPlacardTitle".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
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
}

#Preview {
    NavigationStack {
        NetworkView()
    }
}
