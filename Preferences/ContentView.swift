//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct ContentView: View {
    // Variables
    @State private var searchText = String()
    @State private var selection: SettingsModel? = .general
    @State private var destination = AnyView(GeneralView())
    @State private var isOnLandscapeOrientation: Bool = UIDevice.current.orientation.isLandscape
    @State private var id = UUID()
    
    var body: some View {
        ZStack {
            Color.primary
                .opacity(0.35)
                .ignoresSafeArea()
            HStack(spacing: 0.3) {
                NavigationStack { // TODO: Clean up loops, maybe separate iPad and iPhone views
                    if UIDevice.current.localizedModel == "iPad" {
                        List(selection: $selection) {
                            Button(action: {}, label: {
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")                                        .resizable()
                                        .foregroundStyle(Color(UIColor.systemGray6), Color(UIColor.systemGray2))
                                        .fontWeight(.thin)
                                        .frame(width: 54, height: 54)
                                    VStack {
                                        Text("Sign in to your \(UIDevice.current.localizedModel)")
                                            .font(.system(size: 16))
                                            .padding(.bottom, 0)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Set up iCloud, the App Store, and more.")
                                            .foregroundStyle(Color(UIColor.label))
                                            .font(.system(size: 13))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.trailing)
                                    }
                                    .padding(.leading, 5)
                                }
                                .padding(.vertical, -5)
                            })
                            
                            Section {
                                ForEach(focusSettings) { setting in
                                    Button(action: {
                                        id = UUID() // Reset destination
                                        selection = setting.type
                                    }, label: {
                                        HStack(spacing: 15) {
                                            ZStack {
                                                setting.color
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color.white, lineWidth: 0.1))
                                                Image(systemName: setting.icon)
                                                    .imageScale(.large)
                                                    .foregroundStyle(.white)
                                            }
                                            Text(setting.id)
                                        }
                                        .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
                                    })
                                    .listRowBackground(selection == setting.type ? Color.blue : nil)
                                }
                            }
                            
                            Section {
                                ForEach(mainSettings) { setting in
                                    Button(action: {
                                        id = UUID() // Reset destination
                                        selection = setting.type
                                    }, label: {
                                        HStack(spacing: 15) {
                                            ZStack {
                                                setting.color
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color.white, lineWidth: 0.1))
                                                Image(systemName: setting.icon)
                                                    .imageScale(.large)
                                                    .foregroundStyle(.white)
                                            }
                                            Text(setting.id)
                                        }
                                        .foregroundStyle(selection == setting.type ? Color.white : Color(UIColor.label))
                                    })
                                    .listRowBackground(selection == setting.type ? Color.blue : nil)
                                }
                            }
                        }
                        .navigationTitle("Settings")
                        .searchable(text: $searchText, placement: .navigationBarDrawer)
                        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                            if UIDevice.current.orientation.rawValue <= 4 {
                                isOnLandscapeOrientation = UIDevice.current.orientation.isLandscape
                            }
                        }
                        .onChange(of: selection, { // Change views when selecting sidebar navigation links
                            if let selectedSettingsItem = combinedSettings.first(where: { $0.type == selection }) {
                                destination = selectedSettingsItem.destination
                            }
                        })
                    } else {
                        List {
                            Section {
                                Button(action: {}, label: {
                                    HStack {
                                        Image(systemName: "person.crop.circle.fill")                                        .resizable()
                                            .foregroundStyle(Color(UIColor.systemGray6), Color(UIColor.systemGray2))
                                            .fontWeight(.thin)
                                            .frame(width: 54, height: 54)
                                        VStack {
                                            Text("Sign in to your \(UIDevice.current.localizedModel)")
                                                .font(.system(size: 16))
                                                .padding(.bottom, 0)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("Set up iCloud, the App Store, and more.")
                                                .foregroundStyle(Color(UIColor.label))
                                                .font(.system(size: 13))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(.leading, 5)
                                    }
                                    .padding(.vertical, -5)
                                })
                            }
                            
                            Section {
                                ForEach(focusSettings) { setting in
                                    NavigationLink(destination: setting.destination) {
                                        HStack(spacing: 15) {
                                            ZStack {
                                                setting.color
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color.white, lineWidth: 0.1))
                                                Image(systemName: setting.icon)
                                                    .imageScale(.large)
                                                    .foregroundStyle(.white)
                                            }
                                            Text(setting.id)
                                        }
                                    }
                                }
                            }
                            
                            Section {
                                ForEach(mainSettings) { setting in
                                    NavigationLink(destination: setting.destination) {
                                        HStack(spacing: 15) {
                                            ZStack {
                                                setting.color
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .stroke(Color.white, lineWidth: 0.1))
                                                Image(systemName: setting.icon)
                                                    .imageScale(.large)
                                                    .foregroundStyle(.white)
                                            }
                                            Text(setting.id)
                                        }
                                    }
                                }
                            }
                        }
                        .navigationTitle("Settings")
                        .searchable(text: $searchText)
                    }
                }
                .frame(maxWidth: UIDevice.current.localizedModel == "iPad" ? (isOnLandscapeOrientation ? 400 : 320) : nil)
                if UIDevice.current.localizedModel == "iPad" {
                    NavigationStack {
                        destination
                    }.id(id)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
