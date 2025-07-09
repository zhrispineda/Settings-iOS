//
//  TransitView.swift
//  Preferences
//
//  Settings > Maps > Transit
//

import SwiftUI

struct TransitView: View {
    @State private var selectedOptions: [String] = ["Bus [Long transit mode]", "Subway & Light Rail [Long transit mode]", "Commuter Rail [Long transit mode]", "Ferry [Long transit mode]"]
    let options = ["Bus [Long transit mode]", "Subway & Light Rail [Long transit mode]", "Commuter Rail [Long transit mode]", "Ferry [Long transit mode]"]
    let path = "/System/Library/PreferenceBundles/MapsSettings.bundle"
    
    var body: some View {
        CustomList(title: "Transit Transportation Mode Label [Settings]".localized(path: path), topPadding: true) {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        if let index = selectedOptions.firstIndex(of: option) {
                            selectedOptions.remove(at: index)
                        } else {
                            selectedOptions.append(option)
                        }
                    } label: {
                        HStack {
                            Text(option.localized(path: path))
                                .foregroundStyle(.text)
                            Spacer()
                            if selectedOptions.contains(option) {
                                Image(systemName: "checkmark").fontWeight(.semibold)
                            }
                        }
                    }
                    .disabled(selectedOptions.contains(option) && selectedOptions.count < 2)
                }
            } header: {
                Text("Prefer Trips Using".localized(path: path))
            } footer: {
                Text("Prefer these vehicles when planning transit trips.".localized(path: path))
            }
        }
    }
}

#Preview {
    NavigationStack {
        TransitView()
    }
}
