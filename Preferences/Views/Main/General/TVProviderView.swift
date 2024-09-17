//
//  TVProviderView.swift
//  Preferences
//
//  Created by Chris on 9/17/24.
//

import SwiftUI

struct TVProviderView: View {
    // Variables
    @State private var searchable = String()
    let providers = ["AT&T U-verse", "CenturyLink Prism", "Cox", "DIRECTV", "DIRECTV STREAM", "DISH", "Frontier", "Hulu", "Mediacom", "Optimum", "Optimum TV", "Sling TV", "Spectrum", "Verizon Fios", "Xfinity"]
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".map(String.init)
    
    var body: some View {
        ZStack {
            CustomList(title: "TV Provider", topPadding: true) {
                Section {
                    ForEach(providers, id: \.self) { provider in
                        Button(provider) {}
                            .foregroundStyle(.primary)
                    }
                } header: {
                    Text("Watch TV shows and movies from apps included in your TV subscription. Select your TV provider to get started.").textCase(nil)
                }
                
                // TODO: Remaining TV Providers
                
                Section {
                    Button("Other TV Provider Regions...") {}
                        .foregroundStyle(.primary)
                } footer: {
                    Text("If you don‘t see your TV provider, sign in directly from the app you want to use.\n\n[About TV Provider & Privacy...](#)")
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
            .font(.system(size: 13))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 10)
        }
    }
}

#Preview {
    NavigationStack {
        TVProviderView()
    }
}
