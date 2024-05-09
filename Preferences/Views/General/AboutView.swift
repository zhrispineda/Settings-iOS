//
//  AboutView.swift
//  Preferences
//
//  Settings > General > About
//

import SwiftUI

struct AboutView: View {
    // Variables
    @State private var showingModelNumber = false
    @State private var serialNumber = String()
    @State private var availableStorage: String = getAvailableStorage() ?? "N/A"
    @State private var totalStorage: String = getTotalStorage() ?? "N/A"

    
    var body: some View {
        CustomList(title: "About") {
            Section {
                if Configuration().isSimulator {
                    HText("Name", status: UIDevice().localizedModel)
                } else {
                    CustomNavigationLink(title: "Name", status: UIDevice().localizedModel, destination: EmptyView())
                }
                
                CustomNavigationLink(title: "\(UIDevice().systemName) Version", status: UIDevice().systemVersion, destination: VersionView())
                
                HText("Model Name", status: DeviceInfo().hasHomeButton && DeviceInfo().isPhone ? "iPhone SE" : UIDevice.current.name)
                HText("Model Number", status: showingModelNumber ? getModelNumber() : "\(getModelNumber())LL/A")
                    .onTapGesture {
                        showingModelNumber.toggle()
                    }
                HText("Serial Number", status: serialNumber)
                    .onAppear(perform: {
                        serialNumber = randomSerialNumber()
                    })
            }
            
            Section(content: {
                CustomNavigationLink(title: "Limited Warranty", status: "Expires: 1/1/25", destination: EmptyView())
                Button(action: {}, label: {
                    Text("Add AppleCare+ Coverage")
                })
            }, footer: {
                Text("There are 60 days left to add coverage for accidental damage.")
            })
            
            Section {
                HText("Songs", status: "0")
                HText("Videos", status: "0")
                HText("Photos", status: "0")
                HText("Applications", status: "1")
                HText("Capacity", status: totalStorage)
                HText("Available", status: availableStorage)
            }
            
            if !Configuration().isSimulator {
                HText("Wi-Fi Address", status: "00:0A:AA:A0:A0:00") // TODO: Monospaced Digits
                HText("Bluetooth", status: "00:0A:AA:A0:A0:00") // TODO: Monospaced Digits
                HText("Modem Firmware", status: "1.60.02") // TODO: Monospaced Digits
                NavigationLink("SEID", destination: {})
                VStack {
                    Text("EID")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("00000000000000000000000000000000")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                        .monospaced()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HText("Carrier Lock", status: "No SIM restrictions")
                
                Section(content: {
                    HText("Network", status: "Network")
                    HText("Carrier", status: "Carrier 0.0")
                    HText("IMEI", status: "00 000000 000000 0") // TODO: Monospaced Digits
                    HText("ICCID", status: "0000000000000000000") // TODO: Monospaced Digits
                }, header: {
                    Text("eSIM")
                })
                
                Section(content: {
                    HText("IMEI2", status: "00 000000 000000 0") // TODO: Monospaced Digits
                }, header: {
                    Text("Available SIM")
                })
            }
            
            Section {
                NavigationLink("Certificate Trust Settings", destination: CertificateTrustSettingsView())
            }
        }
    }
    
    // Display corresponding model number
    func getModelNumber() -> String {
        var modelNumber: String
        
        switch UIDevice.current.name {
        case "iPhone 15 Pro Max":
            modelNumber = "A2849"
        case "iPhone 15 Pro":
            modelNumber = "A2848"
        case "iPhone SE (3rd generation)":
            modelNumber = "A2595"
        case "iPad mini (6th generation)":
            modelNumber = "A2567"
        case "iPad Pro (12.9-inch) (6th generation)":
            modelNumber = "A2436"
        case "iPad Pro (11-inch) (4th generation)":
            modelNumber = "A2759"
        default:
            modelNumber = "N/A"
        }
        
        return modelNumber
    }
    
    // Generate random characters as a serial number
    func randomSerialNumber() -> String {
        let letters = "BCDFGHJKLMNPQRTVWXYZ0123456789"
        var random = SystemRandomNumberGenerator()
        var randomString = ""
        for _ in 0..<10 {
            let randomIndex = Int(random.next(upperBound: UInt32(letters.count)))
            let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }
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
    return nil
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
