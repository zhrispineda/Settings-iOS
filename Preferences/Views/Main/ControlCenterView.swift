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
                        Text(Device().hasHomeButton ? "Swipe up from the bottom of the screen to view Control Center. Add, rearrange, and resize any control." : "Swipe down from the top-right edge to open Control Center. Add, rearrange, and resize any control.", tableName: "ControlCenterSettings")
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
                Toggle(String(localized: "ALLOWED_WITHIN_APPS", table: "ControlCenterSettings"), isOn: $allowControlCenterInApps)
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
