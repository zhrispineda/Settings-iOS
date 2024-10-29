//
//  ControlCenterView.swift
//  Preferences
//
//  Settings > Control Center
//

import SwiftUI

struct ControlCenterView: View {
    // Variables
    @AppStorage("allowControlCenterInApps") private var allowControlCenterInApps = true
    @State private var showingAlert = false
    let table = "ControlCenterSettings"
    
    var body: some View {
        CustomList(title: "CONTROLCENTER".localize(table: table)) {
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("CONTROL_CENTER_TIP_HEADER", tableName: table)
                            .bold()
                            .font(.footnote)
                        Text(UIDevice.HomeButtonCapability ? "CONTROL_CENTER_TIP_INSTRUCTIONS_BOTTOM" : "CONTROL_CENTER_TIP_INSTRUCTIONS_TOP_RIGHT", tableName: table)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.leading, -5)
                    .padding(.top, 5)
                    Spacer()
                        .frame(width: 60)
                }
                .frame(minHeight: 100)
            }
            .listRowBackground(Color(UIColor.systemGray4))
            
            Section {
                Toggle("ALLOWED_WITHIN_APPS".localize(table: table), isOn: $allowControlCenterInApps)
            } footer: {
                Text("ALLOWED_WITHIN_APPS_FOOTER", tableName: table)
            }
            
            Section {
                Button("CONTROL_CENTER_RESET_TO_DEFAULT_LAYOUT".localize(table: table)) {
                    showingAlert.toggle()
                }
                .confirmationDialog("CONTROL_CENTER_RESET_TO_DEFAULT_LAYOUT_DESCRIPTION".localize(table: table), isPresented: $showingAlert, titleVisibility: .visible, actions: {
                    Button("CONTROL_CENTER_RESET_TO_DEFAULT_LAYOUT".localize(table: table), role: .destructive) {}
                })
            } footer: {
                Text("CONTROL_CENTER_RESET_TO_DEFAULT_LAYOUT_DESCRIPTION", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlCenterView()
    }
}
