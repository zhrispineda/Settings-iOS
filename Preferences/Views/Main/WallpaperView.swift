//
//  WallpaperView.swift
//  Preferences
//
//  Settings > Wallpaper
//

import SwiftUI

struct WallpaperView: View {
    // Variables
    let table = "WallpaperSettings"
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.label
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.secondaryLabel
    }
    
    var body: some View {
        CustomList(title: "WALLPAPER".localize(table: table)) {
            Section {
                Text("CURRENT_TITLE", tableName: table)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                TabView {
                    HStack(spacing: 15) {
                        Rectangle()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 130, height: UIDevice.iPhone ? 290 : 200)
                        Rectangle()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 130, height: UIDevice.iPhone ? 290 : 200)
                    }
                    .foregroundStyle(.gray)
                }
                .tabViewStyle(.page)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)
                Button {} label: {
                    Text(Image(systemName: "plus")) + Text("ADD_NEW_WALLPAPER", tableName: table)
                }
                .font(.caption)
                .controlSize(.small)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity)
            
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("ANIMATED_TIP_TITLE", tableName: table)
                            .bold()
                            .font(.footnote)
                        Text("ANIMATED_TIP_CAPTION", tableName: table)
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.leading, -5)
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    Image(UIDevice.iPhone && UIDevice.HomeButtonCapability ? .controlCenterSettingsTipPhoneHomeButton : .controlCenterSettingsTip)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIDevice.iPhone ? 50 : 75)
                        .padding(.horizontal)
                }
                .frame(minHeight: 100)
            }
            .listRowBackground(Color(UIColor.systemGray4))
        }
    }
}

#Preview {
    NavigationStack {
        WallpaperView()
    }
}
