//
//  AboutView.swift
//  Preferences
//
//  Settings > General > About
//

import SwiftUI

struct AboutView: View {
    @State private var showingModelNumber = false
    @AppStorage("ModelNumber") private var modelNumber = String()
    @AppStorage("RegulatoryModelNumber") private var regulatoryModelNumber = String()
    @State private var serialNumber = String()
    @State private var availableStorage: String = getAvailableStorage() ?? "Error"
    @State private var capacityStorage = String()
    @State private var wifiAddress = String()
    @State private var bluetoothAddress = String()
    @State private var eidValue = String()
    @AppStorage("DeviceName") private var deviceName = UIDevice.current.model
    let table = "General"
    let UITable = "GeneralSettingsUI"
    
    var body: some View {
        CustomList(title: "About".localize(table: table)) {
            Section {
                if UIDevice.IsSimulator {
                    LabeledContent("Device_Name".localize(table: table), value: UIDevice.current.model)
                } else {
                    SettingsLink("Device_Name".localize(table: table), status: deviceName, destination: NameView())
                }
                
                SettingsLink("OS Version".localize(table: UITable), status: UIDevice().systemVersion, destination: BundleControllerView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGSoftwareVersionController", title: "OS Version", table: UITable))
                    .textSelection(.enabled)
                
                LabeledContent("ProductModelName".localize(table: UITable), value: UIDevice.fullModel)
                    .textSelection(.enabled)
                MonospacedLabel("ProductModel".localize(table: UITable), value: showingModelNumber ? regulatoryModelNumber : "\(modelNumber)\(getRegionInfo())")
                    .contentShape(Rectangle())
                    .onTapGesture {
                      showingModelNumber.toggle()
                    }
                LabeledContent("SerialNumber".localize(table: UITable), value: serialNumber)
            }
            .task {
                if serialNumber.isEmpty {
                    serialNumber = MGHelper.read(key: "VasUgeSzVyHdB27g2XpN0g") ?? getRandomSerialNumber() // SerialNumber
                    modelNumber = MGHelper.read(key: "D0cJ8r7U5zve6uA6QbOiLA") ?? getRegulatoryModelNumber() // ModelNumber
                    regulatoryModelNumber = getRegulatoryModelNumber()
                    wifiAddress = generateRandomAddress()
                    bluetoothAddress = generateRandomAddress()
                    eidValue = getRandomEID()
                    capacityStorage = UIDevice.storageCapacity ?? getTotalStorage()!
                }
            }
            
            Section {
                LabeledContent("SONGS".localize(table: UITable), value: "0")
                LabeledContent("VIDEOS".localize(table: UITable), value: "0")
                LabeledContent("PHOTOS".localize(table: UITable), value: "6")
                if !UIDevice.IsSimulator {
                    LabeledContent("APPLICATIONS".localize(table: UITable), value: "1")
                }
                LabeledContent("User Data Capacity".localize(table: UITable), value: capacityStorage)
                LabeledContent("User Data Available".localize(table: UITable), value: availableStorage)
            }
            
            if !UIDevice.IsSimulator {
                MonospacedLabel("MACAddress".localize(table: UITable), value: wifiAddress)
                MonospacedLabel("BTMACAddress".localize(table: UITable), value: bluetoothAddress)
                if UIDevice.CellularTelephonyCapability {
                    MonospacedLabel("ModemVersion".localize(table: UITable), value: "1.00.00")
                }
                NavigationLink("SEID", destination: SEIDView())
                
                if UIDevice.CellularTelephonyCapability {
                    VStack {
                        Text("EID", tableName: table)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            ForEach(Array(eidValue.enumerated()), id: \.offset) { _, character in
                                let char = String(character)
                                if character == "1" {
                                    Text(char)
                                } else {
                                    Text(char)
                                        .fontDesign(.monospaced)
                                        .kerning(-1)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                    }
                    LabeledContent("CARRIER_LOCK".localize(table: table), value: "CARRIER_LOCK_UNLOCKED".localize(table: table))
                    
                    //                Section {
                    //                    LabeledContent("Network", value: "Not Available")
                    //                    LabeledContent("Carrier", value: "Carrier 0.0")
                    //                    HText("IMEI", status: "00 000000 000000 0", monospaced: true)
                    //                    HText("ICCID", status: getRandomICCID(), monospaced: true)
                    //                } header: {
                    //                    Text(UIDevice.HomeButtonCapability && UIDevice.iPhone ? "Physical SIM" : "eSIM")
                    //                }
                    
                    Section {
                        MonospacedLabel("ModemIMEI".localize(table: UITable), value: "00 000000 000000 0")
                            .contextMenu {
                                Button("Copy", systemImage: "document.on.document") {}
                                Button("Barcode", systemImage: "barcode") {}
                            }
                        MonospacedLabel("ModemIMEI2".localize(table: table), value: "00 000000 000000 0")
                            .contextMenu {
                                Button("Copy", systemImage: "document.on.document") {}
                                Button("Barcode", systemImage: "barcode") {}
                            }
                    } header: {
                        Text("AVAILABLE_SIMS".localize(table: table))
                    }
                }
            }
            
            Section {
                NavigationLink("CERT_TRUST_SETTINGS".localize(table: UITable), destination: BundleControllerView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGCertTrustSettings", title: "CERT_TRUST_SETTINGS", table: UITable))
            }
        }
    }
    
    // Functions
    private func getRegionInfo() -> String {
        if let mobileGestalt = UIDevice.checkDevice() {
            let cacheExtra = mobileGestalt["CacheExtra"] as! [String : AnyObject]
            return cacheExtra["zHeENZu+wbg7PUprwNwBWg"] as! String // RegionInfo check
        }
        return "LL/A" // Fallback
    }
    
    // Display corresponding model number
    private func getRegulatoryModelNumber() -> String {
        // Check MobileGestalt CacheExtra first
        if let answer = MGHelper.read(key: "97JDvERpVwO+GHtthIh7hA") { // RegulatoryModelNumber
            return answer
        }
        
        // Fallback
        if let mobileGestalt = UIDevice.checkDevice() {
            let cacheExtra = mobileGestalt["CacheExtra"] as! [String : AnyObject]
            return cacheExtra["97JDvERpVwO+GHtthIh7hA"] as! String // RegulatoryModelNumber cached
        }
        
        return "Error"
    }
    
    // Generate random characters as a serial number
    private func getRandomSerialNumber() -> String {
        let letters = "BCDFGHJKLMNPQRTVWXYZ0123456789"
        var random = SystemRandomNumberGenerator()
        var randomString = String()
        for _ in 0..<10 {
            let randomIndex = Int(random.next(upperBound: UInt32(letters.count)))
            let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }
    
    // Generate random characters as EID string
    private func getRandomEID() -> String {
        let lowerBound = "10000000000000000000000000000000"
        let upperBound = "99999999999999999999999999999999"
        var randomNumber = String()
        
        for i in 0..<lowerBound.count {
            let lowerDigit = lowerBound[lowerBound.index(lowerBound.startIndex, offsetBy: i)].wholeNumberValue!
            let upperDigit = upperBound[upperBound.index(upperBound.startIndex, offsetBy: i)].wholeNumberValue!
            
            let digit = Int.random(in: lowerDigit...upperDigit)
            randomNumber += "\(digit)"
        }
        
        return randomNumber
    }
    
    // Generate random characters as EID string
    private func getRandomICCID() -> String {
        let lowerBound = "1000000000000000000"
        let upperBound = "9999999999999999999"
        var randomNumber = String()
        
        for i in 0..<lowerBound.count {
            let lowerDigit = lowerBound[lowerBound.index(lowerBound.startIndex, offsetBy: i)].wholeNumberValue!
            let upperDigit = upperBound[upperBound.index(upperBound.startIndex, offsetBy: i)].wholeNumberValue!
            
            let digit = Int.random(in: lowerDigit...upperDigit)
            randomNumber += "\(digit)"
        }
        
        return randomNumber
    }
}

struct AboutRoute: @preconcurrency Routable {
    @MainActor func destination() -> AnyView {
        AnyView(AboutView())
    }
}

// Generate random address
func generateRandomAddress() -> String {
    let characters = "0123456789ABCDEF"
    var address = String()
    
    for i in 0..<6 {
        if i > 0 {
            address += ":"
        }
        let byte = (0..<2).map { _ in characters.randomElement()! }
        address += String(byte)
    }
    
    return address
}

// Get available storage
func getAvailableStorage() -> String? {
    let fileManager = FileManager.default
    do {
        let systemAttributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
        
        if let freeSize = systemAttributes[.systemFreeSize] as? NSNumber {
            let bytes = freeSize.int64Value
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useGB]
            formatter.countStyle = .file
            return formatter.string(fromByteCount: bytes)
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    return nil
}

// Get total storage
func getTotalStorage() -> String? {
    let fileManager = FileManager.default
    do {
        let systemAttributes = try fileManager.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
        
        if let totalSize = systemAttributes[.systemSize] as? NSNumber {
            let bytes = totalSize.int64Value
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useGB]
            formatter.countStyle = .file
            return formatter.string(fromByteCount: bytes)
        }
    } catch {
        print("Error: \(error.localizedDescription)")
    }
    return "Error"
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
