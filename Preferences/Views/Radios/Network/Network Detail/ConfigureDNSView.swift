//
//  ConfigureDNSView.swift
//  Preferences
//
//  Settings > Wi-Fi > [info.circle] > Configure DNS
//

import SwiftUI

struct ConfigureDNSView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selected: String
    @FocusState private var focusedServerID: UUID?
    @FocusState private var focusedSearchDomain: UUID?
    @State private var currentSelected = "kWFLocSettingsDNSConfigureAutomatic"
    @State private var DNSServers: [DNSServer] = []
    @State private var searchDomains: [SearchDomain] = []
    let options = ["kWFLocSettingsDNSConfigureAutomatic", "kWFLocSettingsDNSConfigureManual"]
    let path = "/System/Library/PrivateFrameworks/WiFiKitUI.framework"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        CustomList(title: "kWFLocSettingsDNSConfigureTitle".localized(path: path, table: table)) {
            Section {
                Picker("kWFLocSettingsDNSConfigureTitle".localized(path: path, table: table), selection: $currentSelected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            
            // MARK: DNS Servers
            Section("kWFLocSettingsDNSSectionHeader".localized(path: path, table: table)) {
                ForEach(DNSServers) { server in
                    TextField("0.0.0.0", text: serverBinding(for: server))
                        .textInputAutocapitalization(.never)
                        .focused($focusedServerID, equals: server.id)
                }
                .onDelete(perform: deleteServer)
                
                if currentSelected == "kWFLocSettingsDNSConfigureManual" {
                    HStack {
                        Button {
                            if DNSServers.last?.server.isEmpty == false || DNSServers.isEmpty {
                                withAnimation {
                                    addServer()
                                }
                            }
                            focusedServerID = DNSServers.last?.id
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.white, .green)
                                    .imageScale(.large)
                                Text("kWFLocSettingsDNSAddServer".localized(path: path, table: table))
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }
            }
            
            // MARK: Add Search Domain
            Section("kWFLocSettingsDNSAddSearchDomain".localized(path: path, table: table)) {
                ForEach(searchDomains) { domain in
                    TextField("domain.com", text: domainBinding(for: domain))
                        .textInputAutocapitalization(.never)
                        .focused($focusedSearchDomain, equals: domain.id)
                }
                .onDelete(perform: deleteDomain)
                
                if currentSelected == "kWFLocSettingsDNSConfigureManual" {
                    HStack {
                        Button {
                            if searchDomains.last?.domain.isEmpty == false || searchDomains.isEmpty {
                                withAnimation {
                                    addDomain()
                                }
                            }
                            focusedSearchDomain = searchDomains.last?.id
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(.white, .green)
                                    .imageScale(.large)
                                Text("kWFLocSettingsDNSAddSearchDomain".localized(path: path, table: table))
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }
            }
        }
        .animation(.default, value: currentSelected)
        .environment(\.editMode, .constant(.active))
        .onAppear {
            if selected != "kWFLocSettingsDNSConfigureAutomatic" {
                currentSelected = selected
            }
        }
        .toolbar {
            Button("kWFGlobalProxyCredSave".localized(path: path, table: table)) {
                selected = currentSelected
                dismiss()
            }
            .disabled(currentSelected == selected)
        }
    }
    
    // MARK: - Functions
    private func addDomain() {
        let newDomain = SearchDomain(id: UUID(), domain: "")
        searchDomains.append(newDomain)
    }
    
    private func addServer() {
        let newServer = DNSServer(id: UUID(), server: "")
        DNSServers.append(newServer)
    }
    
    private func domainBinding(for domain: SearchDomain) -> Binding<String> {
        guard let index = searchDomains.firstIndex(where: { $0.id == domain.id }) else {
            return .constant("")
        }
        return $searchDomains[index].domain
    }
    
    private func serverBinding(for server: DNSServer) -> Binding<String> {
        guard let index = DNSServers.firstIndex(where: { $0.id == server.id }) else {
            return .constant("")
        }
        return $DNSServers[index].server
    }
    
    private func deleteDomain(at offsets: IndexSet) {
        searchDomains.remove(atOffsets: offsets)
    }
    
    private func deleteServer(at offsets: IndexSet) {
        DNSServers.remove(atOffsets: offsets)
    }
}

// MARK: - Identifiable structs
struct DNSServer: Identifiable {
    let id: UUID
    var server: String
}

struct SearchDomain: Identifiable {
    let id: UUID
    var domain: String
}

#Preview {
    NavigationStack {
        ConfigureDNSView(selected: .constant("kWFLocSettingsDNSConfigureAutomatic"))
    }
}
