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
    
    var body: some View {
        CustomList {
            if isEditing {
                Section {} header: {
                    Text("Known Networks")
                }
            } else {
                Section {
                    SectionHelp(title: "Wi-Fi", color: Color.blue, icon: "wifi", description: "Connect to Wi-Fi, view available networks, and manage settings for joining networks and nearby hotspots. [Learn more...](https://support.apple.com/guide/\(UIDevice.iPhone ?  "iphone/connect-to-the-internet-iphd1cf4268/ios" : "ipad/connect-to-the-internet-ipad2db29c3a/ipados"))")
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
                            Text("Wi-Fi")
                        }
                    }
                } footer: {
                    if !wifiEnabled {
                        Text("AirDrop, AirPlay, Notify When Left Behind, and \(UIDevice.iPhone ? "improved location accuracy" : "location services") require Wi-Fi.")
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
                                Text("Other...")
                                    .foregroundStyle(Color["Label"])
                                    .popover(isPresented: $showingOtherNetwork) {
                                        OtherNetworkView()
                                            .foregroundStyle(Color["Label"])
                                    }
                            }
                        }
                    } header: {
                        Text("Networks")
                    }
                    
                    Section {
                        CustomNavigationLink(title: "Ask to Join Networks", status: "Notify", destination: SelectOptionList(title: "Ask to Join Networks", options: ["Off", "Notify", "Ask"], selected: "Notify"))
                    } footer: {
                        Text("Known networks will be joined automatically. If no known networks are available, you will have to manually select a network.")
                    }
                    
                    Section {
                        CustomNavigationLink(title: "Auto-Join Hotspot", status: "Ask to Join", destination: SelectOptionList(title: "Auto-Join Hotspot", options: ["Never", "Ask to Join", "Automatic"], selected: "Ask to Join"))
                    } footer: {
                        Text("Allow this device to automatically discover nearby personal hotspots when no Wi-Fi network is available.")
                    }
                }
            }
        }
        .padding(.top, isEditing ? 19 : 0)
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("**Wi-Fi**")
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "**Done**" : "Edit") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
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
