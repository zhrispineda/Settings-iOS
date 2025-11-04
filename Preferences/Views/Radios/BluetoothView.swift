//
//  BluetoothView.swift
//  Preferences
//
//  Settings > Bluetooth
//

import SwiftUI
import CoreBluetooth

@Observable class BluetoothManager: NSObject, CBCentralManagerDelegate {
    var discoveredPeripherals = [CBPeripheral]()
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.append(peripheral)
        }
    }
    
    func resetList() {
        discoveredPeripherals = [CBPeripheral]()
    }
}


struct BluetoothView: View {
    @AppStorage("Bluetooth") private var bluetoothEnabled = true
    @AppStorage("DeviceName") private var deviceName = UIDevice.current.model
    @State private var bluetoothManager = BluetoothManager()
    @State private var showingHelpSheet = false
    let path = "/System/Library/PreferenceBundles/BluetoothSettings.bundle"
    let table = "Devices"
    
    var body: some View {
        CustomList {
            Section {
                Button {} label: {
                    Placard(
                        title: "BLUETOOTH".localized(path: path, table: table),
                        icon: "com.apple.graphic-icon.bluetooth",
                        description: """
                                    \("BLUETOOTHPLACARDINFO".localized(path: path, table: table))
                                    [\("LEARN_MORE".localized(path: path, table: table))](pref://helpkit)
                                    """,
                        frameY: .constant(0.0),
                        opacity: .constant(0.0))
                }
                .foregroundStyle(.primary)
                Toggle("BLUETOOTH".localized(path: path, table: table), isOn: $bluetoothEnabled.animation())
            } footer: {
                if bluetoothEnabled {
                    Text("DISCOVERABLE".localized(path: path, table: table, deviceName))
                } else {
                    Text("POWER_OFF_WARNING".localized(path: path, table: table))
                }
            }
            
            if bluetoothEnabled {
                Section {
                    ForEach(bluetoothManager.discoveredPeripherals, id: \.identifier) { peripheral in
                        if let name = peripheral.name, name != "Unknown" {
                            Button(name) {}.foregroundStyle(.primary)
                        }
                    }
                } header: {
                    HStack {
                        Text("DEVICES".localized(path: path, table: table))
                        ProgressView()
                            .padding(.horizontal, 1)
                    }
                } footer: {
                    if UIDevice.iPhone {
                        Text(.init("APPLE_WATCH_FOOTER_TEXT".localized(path: path, table: table,  "[\("APPLE_WATCH_APP_LINK".localized(path: path, table: table))](itms-watchs://)")))
                    }
                }
            }
        }
        .onChange(of: bluetoothEnabled) {
            if !bluetoothEnabled {
                bluetoothManager.resetList()
            }
        }
        .onDisappear {
            bluetoothManager.resetList()
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://helpkit" {
                showingHelpSheet = true
            }
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph3c50f191" : "ipad997da4cf")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("BLUETOOTH".localized(path: path, table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    //.opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BluetoothView()
    }
}
