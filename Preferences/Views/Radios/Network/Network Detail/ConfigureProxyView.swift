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
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocSettingsProxyConfigureTitle".localized(path: path, table: table)) {
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
            case "kWFLocSettingsIPV4ConfigureManual": // Manual
                Section {
                    // Server
                    HStack {
                        Text("kWFLocSettingsProxyServerCell".localized(path: path, table: table))
                        TextField(server, text: $server)
                            .autocorrectionDisabled()
                            .keyboardType(.URL)
                            .multilineTextAlignment(.trailing)
                            .textInputAutocapitalization(.never)
                    }
                    // Port
                    HStack {
                        Text("kWFLocSettingsProxyPortCell".localized(path: path, table: table))
                        TextField(port, text: $port)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    // Authentication
                    Toggle("kWFLocSettingsProxyAuthenticationCell".localized(path: path, table: table), isOn: $authentication)
                    
                    if authentication {
                        // Username
                        HStack {
                            Text("kWFLocSettingsProxyUsernameCell".localized(path: path, table: table))
                            TextField(username, text: $username)
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                                .textInputAutocapitalization(.never)
                        }
                        // Password
                        HStack {
                            Text("kWFLocSettingsProxyPasswordCell".localized(path: path, table: table))
                            SecureField(password, text: $password)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                } footer: {
                    if authentication {
                        Text("kWFLocProxyAuthenticationWarningFooter".localized(path: path, table: table))
                    }
                }
            case "kWFLocSettingsProxyConfigAutomaticTitle": // Automatic
                // URL
                HStack {
                    Text("kWFLocSettingsProxyURLCell".localized(path: path, table: table))
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
            Button("kWFGlobalProxyCredSave".localized(path: path, table: table)) {
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
