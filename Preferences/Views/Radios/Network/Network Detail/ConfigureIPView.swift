//
//  ConfigureIPView.swift
//  Preferences
//
//  Settings > Wi-Fi > [info.circle] > Configure IP
//

import SwiftUI

struct ConfigureIPView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selected: String
    @State private var currentSelected = "kWFLocSettingsIPV4ConfigureAutomatic"
    @State private var clientID = ""
    @State private var IPAddress = ""
    @State private var subnetMask = ""
    @State private var router = ""
    let options = ["kWFLocSettingsIPV4ConfigureAutomatic", "kWFLocSettingsIPV4ConfigureManual", "kWFLocSettingsIPV4ConfigureBootP"]
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocSettingsIPConfigureTitle".localize(table: table)) {
            Section {
                Picker("kWFLocSettingsIPConfigureTitle".localize(table: table), selection: $currentSelected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            
            switch currentSelected {
            case "kWFLocSettingsIPV4ConfigureAutomatic":
                Section {
                    // MARK: Client ID
                    HStack {
                        Text("kWFLocSettingsClientIDCell", tableName: table)
                        TextField(clientID, text: $clientID)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.trailing)
                    }
                }
            case "kWFLocSettingsIPV4ConfigureManual":
                Section("kWFLocSettingsIPV4ConfigureManualSectionHeader".localize(table: table)) {
                    // MARK: IP Address
                    HStack {
                        Text("kWFLocSettingsIPV4AddressCell", tableName: table)
                        TextField(clientID, text: $clientID, prompt: Text("0.0.0.0"))
                    }
                    // MARK: Subnet Mask
                    HStack {
                        Text("kWFLocSettingsSubnetMaskCell", tableName: table)
                        TextField(subnetMask, text: $subnetMask, prompt: Text("255.255.0.0"))
                    }
                    // MARK: Router
                    HStack {
                        Text("kWFLocSettingsIPV4RouterCell", tableName: table)
                        TextField(router, text: $router)
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numbersAndPunctuation)
            default:
                EmptyView()
            }
        }
        .onAppear {
            if selected != "kWFLocSettingsIPV4ConfigureAutomatic" {
                currentSelected = selected
            }
        }
        .toolbar {
            Button("OK".localize(table: "General")) {
                selected = currentSelected
                dismiss()
            }
            .disabled(currentSelected == "kWFLocSettingsIPV4ConfigureAutomatic" && clientID.isEmpty)
            .disabled(currentSelected == "kWFLocSettingsIPV4ConfigureManual" && !isValidIP(IPAddress) && !isValidIP(subnetMask))
            .disabled(currentSelected == selected && clientID.isEmpty)
        }
    }
    
    func isValidIP(_ ip: String) -> Bool {
        let pattern = /^(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)){3}$/
        return ip.firstMatch(of: pattern) != nil
    }
}

#Preview {
    NavigationStack {
        ConfigureIPView(selected: .constant("kWFLocSettingsIPV4ConfigureAutomatic"))
    }
}
