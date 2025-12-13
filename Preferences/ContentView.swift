//
//  ContentView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

struct ContentView: View {
    @AppStorage("FollowUpDismissed") private var followUpDismissed = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(PrimarySettingsListModel.self) private var model
    @State private var searchFocused = false
    @State private var searchText = ""
    @State private var showingSignInError = false
    @State private var showingSignInSheet = false
    @State private var showingResearchSheet = false
    
    var body: some View {
        @Bindable var model = model
        
        NavigationSplitView {
            List(selection: $model.selection) {
                if UIDevice.ResearchFuse {
                    Section {} footer: { Text("SECURITY_RESEARCH_DEVICE_FOOTER") }
                }
                Section {
                    Button {
                        if model.isConnected {
                            showingSignInSheet.toggle()
                        } else {
                            SettingsLogger.info("Presenting Network Alert.")
                            showingSignInError.toggle()
                        }
                    } label: {
                        NavigationLink {} label: {
                            AppleAccountSection()
                        }
                        .navigationLinkIndicatorVisibility(UIDevice.iPad && !model.isCompact ? .hidden : .visible)
                    }
                }
                
                if !followUpDismissed {
                    SettingsGroup(model.followUpSettings)
                }
                
                SettingsGroup(model.radioSettings)
                SettingsGroup(model.mainSettings)
                SettingsGroup(model.attentionSettings)
                SettingsGroup(model.securitySettings)
                SettingsGroup(model.serviceSettings)
                SettingsGroup(model.appsSettings)
                SettingsGroup(model.developerSettings)
            }
            .navigationTitle(UIDevice.iPhone || model.isCompact ? .settings : "")
            .toolbar(removing: .sidebarToggle)
            .alert(.connectToTheInternetToSignInToYourDevice, isPresented: $showingSignInError) {
                Button(.ok) {}
            }
            .sheet(isPresented: $showingSignInSheet) {
                NavigationStack {
                    SelectSignInOptionView()
                        .interactiveDismissDisabled()
                }
            }
            .searchable(text: $searchText, isPresented: $searchFocused, placement: UIDevice.iPad ? .navigationBarDrawer(displayMode: .always) : .automatic)
            .overlay {
                if UIDevice.iPad && searchFocused && !searchText.isEmpty {
                    GeometryReader { geo in
                        List {
                            if searchText.isEmpty {
                                Section("Suggestions") {}
                            } else {
                                ContentUnavailableView.search(text: searchText)
                                    .frame(minHeight: 0, idealHeight: geo.size.height, maxHeight: .infinity)
                                    .edgesIgnoringSafeArea(.all)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .scrollDisabled(!searchText.isEmpty)
                        .listStyle(.inset)
                    }
                } else if UIDevice.iPhone && searchFocused {
                    GeometryReader { geo in
                        List {
                            if searchText.isEmpty {
                                SettingsSearchView()
                            } else {
                                ContentUnavailableView.search(text: searchText)
                                    .frame(minHeight: 0, idealHeight: geo.size.height, maxHeight: .infinity)
                                    .edgesIgnoringSafeArea(.all)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .scrollDisabled(!searchText.isEmpty)
                        .listStyle(.inset)
                    }
                }
            }
        } detail: {
            NavigationStack(path: $model.path) {
                model.selection?.destination
            }
        }
        .accessibilityIdentifier("SettingsList")
        .overlay {
            if UIDevice.`apple-internal-install` {
                VStack {
                    SettingsAppDebugMenuGestureProxyView {
                        model.showingDebugMenu.toggle()
                    }
                    .frame(height: UIDevice.iPad ? 50 : 75, alignment: .top)
                    Spacer()
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            model.isCompact = horizontalSizeClass == .compact
            if model.selection == nil && UIDevice.iPad && !model.isCompact {
                model.selection = model.mainSettings.first
            }
        }
        .onChange(of: model.path) { oldValue, _ in
            if !oldValue.isEmpty {
                SettingsLogger.log("Last Navigation Event: \(oldValue.joined(separator: " → "))")
            }
        }
        .onChange(of: horizontalSizeClass) {
            model.isCompact = horizontalSizeClass == .compact
            if !model.isCompact && model.selection == nil {
                model.selection = model.mainSettings.first
            }
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://" {
                showingResearchSheet = true
            }
        }
        .sheet(isPresented: $model.showingDebugMenu) {
            NavigationStack {
                DebugView()
            }
            .presentationDetents(UIDevice.iPhone ? [.medium, .large] : [.large])
        }
        .sheet(isPresented: $showingResearchSheet) {
            NavigationStack {
                OBWelcomeView(
                    title: String(localized: .aboutSecurityResearchDevice),
                    detailText: String(localized: .securityResearchText)
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(.done) {
                            showingResearchSheet = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(PrimarySettingsListModel())
}
