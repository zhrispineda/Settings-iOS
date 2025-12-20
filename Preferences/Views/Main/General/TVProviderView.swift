//
//  TVProviderView.swift
//  Preferences
//
//  Settings > General > TV Provider
//

import SwiftUI

struct TVProviderView: View {
    @State private var allProviders: [ProviderData] = []
    @State private var errorMessage: String?
    @State private var featured: [ProviderData] = []
    @State private var searchable = ""
    @State private var showingSheet = false
    private let endpointURL = URL(string: "https://amp-api.apps.apple.com/v1/catalog/us/tv-providers?extend=externalVersionId&include=apps&l=en-US&platform=iphone&redef%5Bmultiple-system-operators%5D=tv-providers")!
    private let path = "/System/Library/Frameworks/VideoSubscriberAccount.framework"
    private let privacyPath = "/System/Library/OnBoardingBundles/com.apple.onboarding.tvprovider.bundle"
    
    private var filteredAllProviders: [ProviderData] {
        if searchable.isEmpty { return allProviders }
        return allProviders.filter { $0.name.localizedCaseInsensitiveContains(searchable) }
    }
    
    private var groupedProviders: [String: [ProviderData]] {
        Dictionary(grouping: filteredAllProviders) { provider in
            String(provider.name.prefix(1)).uppercased()
        }
    }

    var body: some View {
        if errorMessage != nil {
            VStack(spacing: 50) {
                Spacer().frame(height: 20)
                Text("ACCOUNT_LOADING_ERROR_MESSAGE".localized(path: path))
                    .font(.title2)
                    .multilineTextAlignment(.center)
                Button("ERROR_ACTION_RETRY_TITLE".localized(path: path)) {
                    Task { await loadProviders() }
                }
                Spacer()
            }
            .navigationTitle("TV_PROVIDER_TITLE".localized(path: path))
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.inset)
        } else if allProviders.isEmpty {
            ProgressView {
                Text("LOADING_TITLE_NO_ELLIPSIS".localized(path: path).uppercased())
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("TV_PROVIDER_TITLE".localized(path: path))
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.inset)
            .onAppear {
                Task {
                    await loadProviders()
                }
            }
        } else {
            CustomList(title: "TV_PROVIDER_TITLE".localized(path: path), topPadding: true) {
                if searchable.isEmpty {
                    Section("IDENTITY_PROVIDER_PICKER_HEADER".localized(path: path)) {
                        ForEach(featured, id: \.id) { provider in
                            Button(provider.name) {}.foregroundStyle(.primary)
                        }
                    }
                }
                
                ForEach(groupedProviders.keys.sorted(), id: \.self) { letter in
                    Section(letter) {
                        ForEach(groupedProviders[letter] ?? [], id: \.id) { provider in
                            Button(provider.name) {}
                                .foregroundStyle(.primary)
                        }
                    }
                    .sectionIndexLabel(letter)
                }
                
                Section {
                    Button("REGIONS_PICKER_OTHER_REGIONS_ROW_TITLE".localized(path: path)) {}
                        .foregroundStyle(.primary)
                } footer: {
                    PSFooterHyperlinkView(
                        footerText: "\("IDENTITY_PROVIDER_PICKER_SETTINGS_FOOTER".localized(path: path))\n\n\("BUTTON_TITLE".localized(path: privacyPath, table: "TVProvider"))\n",
                        linkText: "BUTTON_TITLE".localized(path: privacyPath, table: "TVProvider"),
                        onLinkTap: {
                            showingSheet = true
                        }
                    )
                }
            }
            .searchable(text: $searchable, placement: .toolbar)
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .scrollIndicators(.hidden)
            .sheet(isPresented: $showingSheet) {
                OBPrivacySplashController(bundleID: "com.apple.onboarding.tvprovider")
                    .ignoresSafeArea()
            }
        }
    }
    
    private func loadProviders() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: endpointURL)
            let decoded = try JSONDecoder().decode(APIResponse.self, from: data)

            var featured: [ProviderData] = []
            var allProviders: [ProviderData] = []

            for item in decoded.data {
                guard let us = item.attributes.supportedStorefronts?["US"] else { continue }

                let provider = ProviderData(
                    id: item.id,
                    name: item.attributes.name,
                    sortOrdinal: us.sortOrdinal,
                    isFeatured: us.isFeatured
                )

                if provider.isFeatured == true {
                    featured.append(provider)
                }

                allProviders.append(provider)
            }

            self.featured = featured
                .sorted { ($0.sortOrdinal ?? Int.max) < ($1.sortOrdinal ?? Int.max) }
                .prefix(15)
                .map { $0 }

            self.allProviders = allProviders
                .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }

            self.errorMessage = nil

        } catch {
            let message = "Failed to load: \(error)"
            errorMessage = message
            SettingsLogger.error(message)
        }
    }
}

struct StorefrontInfo: Codable {
    let sortOrdinal: Int?
    let isFeatured: Bool?
}

struct ProviderAttributes: Codable {
    let name: String
    let supportedStorefronts: [String: StorefrontInfo]?
}

struct ProviderItem: Codable {
    let id: String
    let attributes: ProviderAttributes
}

struct APIResponse: Codable {
    let data: [ProviderItem]
}

struct ProviderData {
    let id: String
    let name: String
    let sortOrdinal: Int?
    let isFeatured: Bool?
}

#Preview {
    NavigationStack {
        TVProviderView()
    }
}
