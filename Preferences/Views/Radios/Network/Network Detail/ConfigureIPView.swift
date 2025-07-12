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
    @FocusState private var focusedIP: Bool
    @State private var currentSelected = "kWFLocSettingsIPV4ConfigureAutomatic"
    @State private var clientID = ""
    @State private var IPAddress = ""
    @State private var subnetMask = ""
    @State private var router = ""
    let options = ["kWFLocSettingsIPV4ConfigureAutomatic", "kWFLocSettingsIPV4ConfigureManual", "kWFLocSettingsIPV4ConfigureBootP"]
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocSettingsIPConfigureTitle".localized(path: path, table: table)) {
            Section {
                Picker("kWFLocSettingsIPConfigureTitle".localized(path: path, table: table), selection: $currentSelected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
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
                        Text("kWFLocSettingsClientIDCell".localized(path: path, table: table))
                        TextField(clientID, text: $clientID)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.trailing)
                    }
                }
            case "kWFLocSettingsIPV4ConfigureManual":
                Section("kWFLocSettingsIPV4ConfigureManualSectionHeader".localized(path: path, table: table)) {
                    // MARK: IP Address
                    HStack {
                        Text("kWFLocSettingsIPV4AddressCell".localized(path: path, table: table))
                        TextField(clientID, text: $clientID, prompt: Text("0.0.0.0"))
                            .focused($focusedIP)
                            .onAppear {
                                focusedIP = true
                            }
                    }
                    // MARK: Subnet Mask
                    HStack {
                        Text("kWFLocSettingsSubnetMaskCell".localized(path: path, table: table))
                        TextField(subnetMask, text: $subnetMask, prompt: Text("255.255.0.0"))
                    }
                    // MARK: Router
                    HStack {
                        Text("kWFLocSettingsIPV4RouterCell".localized(path: path, table: table))
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
        .animation(.default, value: currentSelected)
        .onAppear {
            if selected != "kWFLocSettingsIPV4ConfigureAutomatic" {
                currentSelected = selected
            }
        }
        .toolbar {
            Button("kWFGlobalProxyCredSave".localized(path: path, table: table)) {
                selected = currentSelected
                dismiss()
            }
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
