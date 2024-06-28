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
    @State private var networkEnabled = true
    @State private var showingOtherNetwork = false
    
    var body: some View {
        CustomList(title: "Wi-Fi") {
            if isEditing {
                Section {} header: {
                    Text("\n\nKnown Networks")
                }
            } else {
                Section {
                    SectionHelp(title: "Wi-Fi", color: Color.blue, icon: "wifi", description: "Connect to Wi-Fi, view available networks, and manage settings for joining networks and nearby hotspots. [Learn more...](https://support.apple.com/guide/\(Device().isPhone ?  "iphone/connect-to-the-internet-iphd1cf4268/ios" : "ipad/connect-to-the-internet-ipad2db29c3a/ipados"))")
                    
                    Toggle(isOn: $networkEnabled) {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.clear)
                            Text("Wi-Fi")
                        }
                    }
                } footer: {
                    if !networkEnabled {
                        Text("AirDrop, AirPlay, Notify When Left Behind, and \(Device().isPhone ? "improved location accuracy" : "location services") require Wi-Fi.")
                    }
                }
                
                if networkEnabled {
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
                        CustomNavigationLink(title: "Ask to Join Networks", status: "Off", destination: EmptyView())
                    } footer: {
                        Text("Known networks will be joined automatically. If no known networks are available, you will have to manually select a network.")
                    }
                    
                    Section {
                        CustomNavigationLink(title: "Auto-Join Hotspot", status: "Never", destination: EmptyView())
                    } footer: {
                        Text("Allow this device to automatically discover nearby personal hotspots when no Wi-Fi network is available.")
                    }
                }
            }
        }
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
