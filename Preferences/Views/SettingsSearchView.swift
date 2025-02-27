//
//  SearchView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct SettingsSearchView: View {
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        Section("Suggestions") {
            HStack(alignment: .top) {
                // Apps
                Button {
                    stateManager.path.append(AnyRoute(AppsRoute()))
                } label: {
                    VStack {
                        IconView(id: "Apps", icon: "app.grid.3x3", color: Color.indigo, iconColor: Color.white)
                            .scaleEffect(2.1)
                            .frame(width: 64, height: 64)
                        Text("Apps")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                // General
                Button {
                    stateManager.path.append(AnyRoute(GeneralRoute()))
                } label: {
                    VStack {
                        IconView(id: "General", icon: "gear", color: Color.gray, iconColor: Color.white)
                            .scaleEffect(2.1)
                            .frame(width: 64, height: 64)
                        Text("General")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                // Accessibility
                Button {
                    stateManager.path.append(AnyRoute(AccessibilityRoute()))
                } label: {
                    VStack {
                        IconView(id: "Accessibility", icon: "accessibility", color: Color.blue, iconColor: Color.white)
                            .scaleEffect(2.1)
                            .frame(width: 64, height: 64)
                        Text("Accessibility")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                // Privacy & Security
                Button {
                    stateManager.path.append(AnyRoute(PrivacySecurityRoute()))
                } label: {
                    VStack {
                        IconView(id: "Privacy & Security", icon: "hand.raised.fill", color: Color.blue, iconColor: Color.white)
                            .scaleEffect(2.1)
                            .frame(width: 64, height: 64)
                        Text("Privacy & Security")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SettingsSearchView()
        .environmentObject(StateManager())
}
