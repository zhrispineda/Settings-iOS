//
//  TVProviderView.swift
//  Preferences
//
//  Settings > General > TV Provider
//

import SwiftUI

struct TVProviderView: View {
    @State private var showingSheet = false
    @State private var searchable = ""
    let providers = ["AT&T U-verse", "CenturyLink Prism", "Cox", "DIRECTV", "DIRECTV STREAM", "DISH", "Frontier", "Hulu", "Mediacom", "Optimum", "Optimum TV", "Sling TV", "Spectrum", "Verizon Fios", "Xfinity"]
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".map(String.init)
    let path = "/System/Library/Frameworks/VideoSubscriberAccount.framework"
    let privacyPath = "/System/Library/OnBoardingBundles/com.apple.onboarding.tvprovider.bundle"
    
    var body: some View {
        ZStack {
            CustomList(title: "TV_PROVIDER_TITLE".localized(path: path), topPadding: true) {
                Section {
                    ForEach(providers, id: \.self) { provider in
                        Button(provider) {}
                            .foregroundStyle(.primary)
                    }
                } header: {
                    Text("IDENTITY_PROVIDER_PICKER_HEADER".localized(path: path)).textCase(nil)
                }
                
                Section {
                    Button("REGIONS_PICKER_OTHER_REGIONS_ROW_TITLE".localized(path: path)) {}
                        .foregroundStyle(.primary)
                } footer: {
                    Text("IDENTITY_PROVIDER_PICKER_SETTINGS_FOOTER".localized(path: path))
                }
                
                Section {} footer: {
                    Text("[\("BUTTON_TITLE".localized(path: privacyPath, table: "TVProvider"))](pref://)\n")
                }
            }
            .searchable(text: $searchable, placement: .toolbar)
            .scrollIndicators(.hidden)
            
            VStack(spacing: 7) {
                Image(systemName: "magnifyingglass")
                ForEach(characters, id: \.self) { char in
                    Text(char)
                }
            }
            .foregroundStyle(.accent)
            .fontWeight(.semibold)
            .font(.system(size: 11))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 1)
        }
        .onOpenURL { url in
            if url.absoluteString == "pref://" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.tvprovider")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        TVProviderView()
    }
}
