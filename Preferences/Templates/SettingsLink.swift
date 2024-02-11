//
//  SettingsLink.swift
//  Preferences
//
//  Template for displaying a NavigationLink with a rounded icon and text.
//

import SwiftUI

struct SettingsLink<Content: View>: View {
    let color: Color
    let iconColor: Color
    let icon: String
    let larger: Bool
    let id: String
    let subtitle: String
    let status: String
    let content: Content
    
    init(color: Color = Color.clear, iconColor: Color = Color.white, icon: String, larger: Bool = true, id: String, subtitle: String = String(), status: String = String(), @ViewBuilder content: () -> Content) {
        self.color = color
        self.iconColor = iconColor
        self.icon = icon
        self.larger = larger
        self.id = id
        self.subtitle = subtitle
        self.status = status
        self.content = content()
    }
    
    var body: some View {
        NavigationLink(destination: content) {
            HStack(spacing: 15) {
                ZStack {
                    color
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                    if UIImage(systemName: icon) != nil {
                        switch icon {
                        case "chevron.compact.up":
                            VStack(spacing: -2) {
                                Image(systemName: icon)
                                    .imageScale(.small)
                                    .foregroundStyle(iconColor)
                                Image(systemName: icon)
                                    .imageScale(.medium)
                                    .foregroundStyle(iconColor)
                                Image(systemName: icon)
                                    .imageScale(.large)
                                    .foregroundStyle(iconColor)
                            }
                        case "appclip":
                            Image(systemName: icon)
                                .foregroundStyle(.blue)
                                .imageScale(.large)
                        default:
                            Image(systemName: icon)
                                .imageScale(larger && !smallerIcons.contains(icon) ? .large : .medium)
                                .fontWeight(icon == "nosign" ? .bold : .regular)
                                .foregroundStyle(iconColor)
                        }
                    } else {
                        switch icon {
                        case "logo.bluetooth":
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                        default:
                        Image(icon)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: 30, height: 30)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text(id)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                if !status.isEmpty {
                    Spacer()
                    Text(status)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsLink(color: .blue, icon: "logo.bluetooth", id: "Bluetooth", content: {
                EmptyView()
            })
        }
    }
}
