//
//  TVProviderView.swift
//  Preferences
//
//  Settings > General > TV Provider
//

import SwiftUI

struct TVProviderView: View {
    // Variables
    @State private var searchable = String()
    let providers = ["AT&T U-verse", "CenturyLink Prism", "Cox", "DIRECTV", "DIRECTV STREAM", "DISH", "Frontier", "Hulu", "Mediacom", "Optimum", "Optimum TV", "Sling TV", "Spectrum", "Verizon Fios", "Xfinity"]
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".map(String.init)
    let table = "VideoSubscriberAccount"
    
    var body: some View {
        ZStack {
            CustomList(title: "TV_PROVIDER_TITLE".localize(table: table), topPadding: true) {
                Section {
                    ForEach(providers, id: \.self) { provider in
                        Button(provider) {}
                            .foregroundStyle(.primary)
                    }
                } header: {
                    Text("IDENTITY_PROVIDER_PICKER_HEADER", tableName: table).textCase(nil)
                }
                
                // TODO: Remaining TV Providers
                
                Section {
                    Button("REGIONS_PICKER_OTHER_REGIONS_ROW_TITLE".localize(table: table)) {}
                        .foregroundStyle(.primary)
                } footer: {
                    Text("\("IDENTITY_PROVIDER_PICKER_SETTINGS_FOOTER".localize(table: table))\n\n[\("BUTTON_TITLE".localize(table: "About TV Provider & Privacy…"))](#)")
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
    }
}

#Preview {
    NavigationStack {
        TVProviderView()
    }
}
