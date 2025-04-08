//
//  TransitView.swift
//  Preferences
//
//  Settings > Maps > Transit
//

import SwiftUI

struct TransitView: View {
    // Variables
    @State private var selectedOptions: [String] = ["Bus [Long transit mode]", "Subway & Light Rail [Long transit mode]", "Commuter Rail [Long transit mode]", "Ferry [Long transit mode]"]
    let options = ["Bus [Long transit mode]", "Subway & Light Rail [Long transit mode]", "Commuter Rail [Long transit mode]", "Ferry [Long transit mode]"]
    let table = "MapsSettings"
    
    var body: some View {
        CustomList(title: "Transit Transportation Mode Label [Settings]".localize(table: table), topPadding: true) {
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
                            Text(option.localize(table: table))
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
                Text("Prefer Trips Using", tableName: table)
            } footer: {
                Text("Prefer these vehicles when planning transit trips.", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TransitView()
    }
}
