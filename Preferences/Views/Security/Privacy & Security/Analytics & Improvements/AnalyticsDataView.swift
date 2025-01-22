//
//  AnalyticsDataView.swift
//  Preferences
//
//  Settings > Privacy & Security > Analytics & Improvements > Analytics Data
//

import SwiftUI

struct AnalyticsDataView: View {
    // Variables
    @State private var searchText = String()
    
    var body: some View {
        CustomList(title: "Data", topPadding: true) {
            HStack {
                ProgressView()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    NavigationStack {
        AnalyticsDataView()
    }
}
