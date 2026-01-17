//
//  AboutView.swift
//  Preferences
//

import SwiftUI

/// View for Settings > General > About
struct AboutView: View {
    @State private var showingModelNumber = false
    @AppStorage("ModelNumber") private var modelNumber = ""
    @AppStorage("RegulatoryModelNumber") private var regulatoryModelNumber = ""
    @State private var serialNumber = ""
    @State private var availableStorage = "Error"
    @State private var capacityStorage = ""
    @State private var wifiAddress = ""
    @State private var bluetoothAddress = ""
    @State private var eidValue = ""
    @AppStorage("DeviceName") private var deviceName = UIDevice.current.model
    private let path = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"
    private let table = "General"
    
    var body: some View {
        CustomList(title: "About".localized(path: path, table: table)) {
            Section {
                if UIDevice.IsSimulator {
                    LabeledContent("Device_Name".localized(path: path, table: table), value: UIDevice.current.model)
                } else {
                    SLink(
                        "Device_Name".localized(path: path, table: table),
                        status: deviceName,
                        destination: NameView()
                    )
                }
                
                SLink(
                    "OS Version".localized(path: path),
                    status: UIDevice().systemVersion,
                    destination: ControllerBridgeView(
                        "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI",
                        controller: "PSGSoftwareVersionController",
                        title: "OS Version".localized(path: path)
                    )
                )
                
                LabeledContent("ProductModelName".localized(path: path), value: UIDevice.`marketing-name`)
                    .textSelection(.enabled)
                LabeledContent(
                    "ProductModel".localized(path: path),
                    value: showingModelNumber ? regulatoryModelNumber : "\(modelNumber)\(getRegionInfo())"
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    showingModelNumber.toggle()
                }
                LabeledContent("SerialNumber".localized(path: path), value: serialNumber)
            }
            .task {
                if serialNumber.isEmpty {
                    serialNumber = MGHelper.read(key: "VasUgeSzVyHdB27g2XpN0g") ?? getRandomSerialNumber() // SerialNumber
                    modelNumber = MGHelper.read(key: "D0cJ8r7U5zve6uA6QbOiLA") ?? getRegulatoryModelNumber() // ModelNumber
                    regulatoryModelNumber = getRegulatoryModelNumber()
                    wifiAddress = generateRandomAddress()
                    bluetoothAddress = generateRandomAddress()
                    eidValue = getRandomEID()
                    capacityStorage = UIDevice.storageCapacity ?? getTotalStorage()
                }
            }
            
            Section {
                LabeledContent("SONGS".localized(path: path), value: "0")
                LabeledContent("VIDEOS".localized(path: path), value: "0")
                LabeledContent("PHOTOS".localized(path: path), value: "6")
                if !UIDevice.IsSimulator {
                    LabeledContent("APPLICATIONS".localized(path: path), value: "1")
                }
                LabeledContent("User Data Capacity".localized(path: path), value: capacityStorage)
                LabeledContent("User Data Available".localized(path: path), value: availableStorage)
            }
            
            if !UIDevice.IsSimulator {
                LabeledContent("MACAddress".localized(path: path), value: wifiAddress)
                LabeledContent("BTMACAddress".localized(path: path), value: bluetoothAddress)
                if UIDevice.CellularTelephonyCapability {
                    LabeledContent("ModemVersion".localized(path: path), value: "1.00.00")
                }
                NavigationLink("SEID", destination: SEIDView())
                
                if UIDevice.CellularTelephonyCapability {
                    VStack {
                        Text("EID".localized(path: path))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(eidValue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondary)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    LabeledContent("CARRIER_LOCK".localized(path: path, table: table), value: "CARRIER_LOCK_UNLOCKED".localized(path: path, table: table))
                    
                    Section {
                        LabeledContent("ModemIMEI".localized(path: path), value: "00 000000 000000 0")
                            .contextMenu {
                                Button("COPY".localized(path: path, table: table), systemImage: "document.on.document") {}
                                Button("BARCODE".localized(path: path, table: table), systemImage: "barcode") {}
                                Button("SHARE_IDENTITY".localized(path: path, table: table), systemImage: "iphone.gen3.crop.circle") {}
                            }
                        LabeledContent("ModemIMEI2".localized(path: path, table: table), value: "00 000000 000000 0")
                            .contextMenu {
                                Button("COPY".localized(path: path, table: table), systemImage: "document.on.document") {}
                                Button("BARCODE".localized(path: path, table: table), systemImage: "barcode") {}
                                Button("SHARE_IDENTITY".localized(path: path, table: table), systemImage: "iphone.gen3.crop.circle") {}
                            }
                    } header: {
                        Text("AVAILABLE_SIMS".localized(path: path, table: table))
                    }
                }
            }
            
            Section {
                NavigationLink("CERT_TRUST_SETTINGS".localized(path: path), destination: ControllerBridgeView("/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI", controller: "PSGCertTrustSettings", title: "CERT_TRUST_SETTINGS".localized(path: path)))
            }
        }
        .task {
            availableStorage = getAvailableStorage() ?? "Error"
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
    
    private func getTotalStorage() -> String {
        let fileManager = FileManager.default
        guard let systemAttributes = try? fileManager.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let totalSize = systemAttributes[.systemSize] as? NSNumber else {
            return "Error"
        }
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: totalSize.int64Value)
    }
    
    private func getAvailableStorage() -> String? {
        guard let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let freeSize = attributes[.systemFreeSize] as? NSNumber else {
            return nil
        }
        
        return ByteCountFormatter.string(fromByteCount: freeSize.int64Value, countStyle: .file)
    }
}

func generateRandomAddress() -> String {
    (0..<6)
        .map { _ in String(format: "%02X", Int.random(in: 0...255)) }
        .joined(separator: ":")
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
