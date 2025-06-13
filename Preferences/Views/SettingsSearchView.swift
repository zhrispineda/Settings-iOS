//
//  SearchView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct SettingsSearchView: View {
    var stateManager: StateManager

    var body: some View {
        Section("Suggestions") {
            HStack(alignment: .top) {
                // Apps
                Button {
                    stateManager.path.append(AnyRoute(AppsRoute()))
                } label: {
                    SuggestedIconView(id: "Apps", icon: "app.grid.3x3", iconColor: Color.indigo)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                // General
                Button {
                    stateManager.path.append(AnyRoute(GeneralRoute()))
                } label: {
                    SuggestedIconView(id: "General", icon: "gear", iconColor: Color.gray)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                // Accessibility
                Button {
                    stateManager.path.append(AnyRoute(AccessibilityRoute()))
                } label: {
                    SuggestedIconView(id: "Accessibility", icon: "accessibility", iconColor: Color.blue)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                // Privacy & Security
                Button {
                    stateManager.path.append(AnyRoute(PrivacySecurityRoute()))
                } label: {
                    SuggestedIconView(id: "Privacy & Security", icon: "hand.raised.fill", iconColor: Color.blue)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
        }
    }
}

struct SuggestedIconView: View {
    var id: String
    var icon: String
    var iconColor: Color
    
    var body: some View {
        VStack {
            IconView(id: id, icon: icon, color: iconColor, iconColor: Color.white)
                .scaleEffect(2.1)
                .frame(width: 64, height: 64)
            Text(id)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 100)
        }
    }
}

#Preview {
    SettingsSearchView(stateManager: StateManager())
}
