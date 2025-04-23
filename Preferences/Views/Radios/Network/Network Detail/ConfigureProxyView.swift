//
//  ConfigureProxyView.swift
//  Preferences
//
//  Settings > Wi-Fi > [info.circle] > Configure DNS
//

import SwiftUI

struct ConfigureProxyView: View {
    @Binding var selected: String
    @Environment(\.dismiss) private var dismiss
    @State private var currentSelected = "kWFLocSettingsProxyConfigOffTitle"
    @State private var server = ""
    @State private var port = ""
    @State private var authentication = false
    @State private var username = ""
    @State private var password = ""
    @State private var proxyURL = ""
    let options = ["kWFLocSettingsProxyConfigOffTitle", "kWFLocSettingsIPV4ConfigureManual", "kWFLocSettingsProxyConfigAutomaticTitle"]
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocSettingsProxyConfigureTitle".localize(table: table)) {
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
            case "kWFLocSettingsIPV4ConfigureManual": // Manual
                Section {
                    // Server
                    HStack {
                        Text("kWFLocSettingsProxyServerCell", tableName: table)
                        TextField(server, text: $server)
                            .autocorrectionDisabled()
                            .keyboardType(.URL)
                            .multilineTextAlignment(.trailing)
                            .textInputAutocapitalization(.never)
                    }
                    // Port
                    HStack {
                        Text("kWFLocSettingsProxyPortCell", tableName: table)
                        TextField(port, text: $port)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    // Authentication
                    Toggle("kWFLocSettingsProxyAuthenticationCell".localize(table: table), isOn: $authentication)
                    
                    if authentication {
                        // Username
                        HStack {
                            Text("kWFLocSettingsProxyUsernameCell", tableName: table)
                            TextField(username, text: $username)
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                                .textInputAutocapitalization(.never)
                        }
                        // Password
                        HStack {
                            Text("kWFLocSettingsProxyPasswordCell", tableName: table)
                            SecureField(password, text: $password)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                } footer: {
                    if authentication {
                        Text("kWFLocProxyAuthenticationWarningFooter", tableName: table)
                    }
                }
            case "kWFLocSettingsProxyConfigAutomaticTitle": // Automatic
                // URL
                HStack {
                    Text("kWFLocSettingsProxyURLCell", tableName: table)
                    TextField(proxyURL, text: $proxyURL)
                        .autocorrectionDisabled()
                        .keyboardType(.URL)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.never)
                }
            default: // Off
                EmptyView()
            }
        }
        .animation(.default, value: currentSelected)
        .onAppear {
            if selected != currentSelected {
                currentSelected = selected
            }
        }
        .toolbar {
            Button("OK".localize(table: "General")) {
                selected = currentSelected
                dismiss()
            }
            .disabled(currentSelected == selected)
            .disabled(currentSelected == "kWFLocSettingsIPV4ConfigureManual" && (server.isEmpty || port.isEmpty))
            .disabled(currentSelected == "kWFLocSettingsIPV4ConfigureManual" && (authentication && username.isEmpty))
        }
    }
}

#Preview {
    NavigationStack {
        ConfigureProxyView(selected: .constant("kWFLocSettingsProxyConfigOffTitle"))
    }
}
