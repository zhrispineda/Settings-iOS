//
//  AboutView.swift
//  Preferences
//
//  Settings > General > About
//

import SwiftUI

struct AboutView: View {
    // Variables
    @State private var showingModelNumber = true
    @State private var serialNumber = ""
    @State private var availableStorage: String = getAvailableStorage() ?? "N/A"
    @State private var totalStorage: String = getTotalStorage() ?? "N/A"

    
    var body: some View {
        CustomList(title: "About") {
            Section {
                HRowLabels(title: "Name", subtitle: UIDevice().localizedModel)
                
                NavigationLink(destination: VersionView()) {
                    HRowLabels(title: "\(UIDevice().systemName) Version", subtitle: UIDevice().systemVersion)
                }
                
                HRowLabels(title: "Model Name", subtitle: UIDevice.current.name)
                HRowLabels(title: "Model Number", subtitle: showingModelNumber ? getModelNumber() : "\(getModelNumber())LL/A")
                    .onTapGesture {
                        showingModelNumber.toggle()
                    }
                HRowLabels(title: "Serial Number", subtitle: serialNumber)
                    .onAppear(perform: {
                        serialNumber = randomSerialNumber()
                    })
            }
            
            Section {
                HRowLabels(title: "Songs", subtitle: "0")
                HRowLabels(title: "Videos", subtitle: "0")
                HRowLabels(title: "Photos", subtitle: "0")
                HRowLabels(title: "Capacity", subtitle: totalStorage)
                HRowLabels(title: "Available", subtitle: availableStorage)
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
