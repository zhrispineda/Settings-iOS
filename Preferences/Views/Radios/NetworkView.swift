//
//  NetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi
//

import SwiftUI

struct NetworkView: View {
    // Variables
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    @AppStorage("wifi") private var wifiEnabled = true
    @State private var showingOtherNetwork = false
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList {
            if isEditing {
                Section {} header: {
                    Text("kWFLocAllEditableKnownSectionTitle".localize(table: table))
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
                            Text("kWFLocWiFiPlacardTitle".localize(table: table))
                        }
                    }
                } footer: {
                    if !wifiEnabled {
                        Text(UIDevice.iPhone ? "kWFLocLocationServicesCellularWarning".localize(table: table) : "kWFLocLocationServicesWarning".localize(table: table))
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
                                Text("kWFLocOtherNetworkTitle".localize(table: table))
                                    .foregroundStyle(Color["Label"])
                                    .popover(isPresented: $showingOtherNetwork) {
                                        OtherNetworkView()
                                            .foregroundStyle(Color["Label"])
                                    }
                            }
                        }
                    } header: {
                        Text("kWFLocChooseNetworkSectionSingleTitle".localize(table: table))
                    }
                    
                    Section {
                        CustomNavigationLink(title: "kWFLocAskToJoinTitle".localize(table: table), status: "kWFLocAskToJoinDetailNotify".localize(table: table), destination: SelectOptionList(title: "kWFLocAskToJoinTitle".localize(table: table), options: ["kWFLocAskToJoinDetailOff".localize(table: table), "kWFLocAskToJoinDetailNotify".localize(table: table), "kWFLocAskToJoinDetailAsk".localize(table: table)], selected: "kWFLocAskToJoinDetailNotify".localize(table: table)))
                    } footer: {
                        Text("kWFLocAskToJoinNotifyFooter".localize(table: table))
                    }
                    
                    Section {
                        CustomNavigationLink(title: "kWFLocAutoInstantHotspotTitle".localize(table: table), status: "kWFLocAutoInstantHotspotJoinAskTitle".localize(table: table), destination: SelectOptionList(title: "kWFLocAutoInstantHotspotTitle".localize(table: table), options: ["kWFLocAutoInstantHotspotJoinNeverTitle".localize(table: table), "kWFLocAutoInstantHotspotJoinAskTitle".localize(table: table), "kWFLocAutoInstantHotspotJoinAutoTitle".localize(table: table)], selected: "kWFLocAutoInstantHotspotJoinAutoTitle".localize(table: table)))
                    } footer: {
                        Text("kWFLocAutoInstantHotspotFooter".localize(table: table))
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
