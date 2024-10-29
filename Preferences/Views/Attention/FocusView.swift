//
//  FocusView.swift
//  Preferences
//
//  Settings > Focus
//

import SwiftUI

struct FocusView: View {
    // Variables
    @State private var shareAcrossDevicesEnabled = true
    let table = "FocusSettings"
    
    var body: some View {
        CustomList(title: "Focus") {
            Section {
                // Do Not Disturb
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "moon.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.indigo)
                        Text("ONBOARDING_MODE_TITLE_DO_NOT_DISTURB", tableName: table)
                            .padding(.horizontal, 10)
                    }
                }
                
                // Personal
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "person.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.purple)
                        Text("ONBOARDING_MODE_TITLE_PERSONAL", tableName: table)
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("SETUP", tableName: table)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Sleep
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "bed.double.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.cyan)
                        Text("ONBOARDING_MODE_TITLE_SLEEP", tableName: table)
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("SETUP", tableName: table)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Work
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "person.crop.square.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.cyan)
                        Text("ONBOARDING_MODE_TITLE_WORK", tableName: table)
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("SETUP", tableName: table)
                            .foregroundStyle(.secondary)
                    }
                }
            } footer: {
                Text("FOCUS_MODES_FOOTER_TEXT", tableName: table)
            }
            
            Section {
                Toggle("CLOUD_SYNCING".localize(table: table), isOn: $shareAcrossDevicesEnabled)
            } footer: {
                Text("CLOUD_SYNCING_FOOTER_TEXT", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "FOCUS_STATUS".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
            } footer: {
                Text("FOCUS_STATUS_DESCRIPTION", tableName: table)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {} label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FocusView()
    }
}
