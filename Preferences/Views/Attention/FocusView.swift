//
//  FocusView.swift
//  Preferences
//
//  Settings > Focus
//

import SwiftUI

struct FocusView: View {
    @State private var shareAcrossDevicesEnabled = true
    let path = "/System/Library/PreferenceBundles/FocusSettings.bundle"
    let table = "FocusSettings!"
    
    var body: some View {
        CustomList(title: "Focus") {
            Section {
                // Do Not Disturb
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "moon.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.indigo)
                        Text("ONBOARDING_MODE_TITLE_DO_NOT_DISTURB".localized(path: path))
                            .padding(.horizontal, 10)
                    }
                }
                
                // Personal
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "person.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.purple)
                        Text("ONBOARDING_MODE_TITLE_PERSONAL".localized(path: path))
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("SETUP".localized(path: path))
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Sleep
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "bed.double.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.cyan)
                        Text("ONBOARDING_MODE_TITLE_SLEEP".localized(path: path))
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("SETUP".localized(path: path))
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Work
                NavigationLink {} label: {
                    HStack {
                        Image(systemName: "person.crop.square.fill").imageScale(.large)
                            .frame(width: 30)
                            .foregroundColor(.cyan)
                        Text("ONBOARDING_MODE_TITLE_WORK".localized(path: path))
                            .padding(.horizontal, 10)
                        Spacer()
                        Text("SETUP".localized(path: path))
                            .foregroundStyle(.secondary)
                    }
                }
            } footer: {
                Text("FOCUS_MODES_FOOTER_TEXT".localized(path: path))
            }
            
            Section {
                Toggle("CLOUD_SYNCING".localized(path: path), isOn: $shareAcrossDevicesEnabled)
            } footer: {
                Text("CLOUD_SYNCING_FOOTER_TEXT".localized(path: path))
            }
            
            Section {
                SettingsLink("FOCUS_STATUS".localized(path: path), status: "OFF".localized(path: path), destination: EmptyView())
            } footer: {
                Text("FOCUS_STATUS_DESCRIPTION".localized(path: path))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {} label: {
                    Image(systemName: "plus")
                }
                Button("Add Focus", systemImage: "plus") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        FocusView()
    }
}
