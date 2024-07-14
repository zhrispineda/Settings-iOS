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
    
    var body: some View {
        CustomList(title: String(localized: "CONTROLCENTER", table: "ControlCenterSettings")) {
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("CONTROL_CENTER_TIP_HEADER", tableName: "ControlCenterSettings")
                            .bold()
                            .font(.footnote)
                        Text(UIDevice.HomeButtonCapability ? "CONTROL_CENTER_TIP_INSTRUCTIONS_BOTTOM" : "CONTROL_CENTER_TIP_INSTRUCTIONS_TOP_RIGHT", tableName: "ControlCenterSettings")
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
                Toggle("ALLOWED_WITHIN_APPS".localize(table: "ControlCenterSettings"), isOn: $allowControlCenterInApps)
            } footer: {
                Text("ALLOWED_WITHIN_APPS_FOOTER", tableName: "ControlCenterSettings")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ControlCenterView()
    }
}
